import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:winch_app/local_db/winch_driver_info_db.dart';
import 'package:winch_app/models/maps/address.dart';
import 'package:winch_app/models/up_comming_requests/upcoming_request_model.dart';
import 'package:winch_app/models/up_comming_requests/arrival_to_customer_location_model.dart';
import 'package:winch_app/models/up_comming_requests/ending_trip_model.dart';
import 'package:winch_app/models/up_comming_requests/get_nearest_clients_model.dart';
import 'package:winch_app/models/up_comming_requests/live_tracker_model.dart';
import 'package:winch_app/models/up_comming_requests/rating_for_customer_model.dart';
import 'package:winch_app/models/up_comming_requests/startting_winch_trip_model.dart';
import 'package:winch_app/provider/maps_prepration/maps_provider.dart';
import 'package:winch_app/provider/maps_prepration/polyLineProvider.dart';
import 'package:winch_app/screens/dash_board/dash_board.dart';
import 'package:winch_app/services/requesting_winch_driver/winch_requests_service.dart';

class WinchRequestProvider extends ChangeNotifier {
  bool currentState = false;
  bool isLoading = false;
  Timer liveTrackerTimer;
  Timer searchingForCustomerTimer;
  Position winchDriverCurrentPosition;
  bool SEARCHING_FOR_CUSTOMER = false;
  bool CUSTOMER_FOUNDED = false;
  bool ALREADY_HAVE_RIDE = false;
  bool RIDE_ACCEPTED = false;
  bool DriverARRIVED = false;
  bool SERVICE_STARTTED = false;
  bool SERVICE_FINISHED = false;
  bool isPopRequestDataReady = false;
  bool RATING_SUBMITTED = false;
  //BuildContext ctx;

  WinchRequestService requestService = WinchRequestService();
  /////////////////////////////////////////////////////////////////////////////
  GetNearestClientRequestModel getNearestClientRequestModel =
      new GetNearestClientRequestModel();
  GetNearestClientResponseModel getNearestClientResponseModel =
      new GetNearestClientResponseModel();
  /////////////////////////////////////////////////////////////////////////////
  UpcomingRequestRequestModel upcomingRequestAcceptRequestModel =
      UpcomingRequestRequestModel(driverResponse: "Accept");
  UpcomingRequestRequestModel upcomingRequestDenyRequestModel =
      UpcomingRequestRequestModel(driverResponse: "Deny");
  UpcomingRequestResponseModel upcomingRequestResponseModel =
      UpcomingRequestResponseModel();
  /////////////////////////////////////////////////////////////////////////////
  EndingWinchServiceRequestModel endingWinchServiceRequestModel =
      EndingWinchServiceRequestModel();
  EndingWinchServiceResponseModel endingWinchServiceResponseModel =
      EndingWinchServiceResponseModel();
  /////////////////////////////////////////////////////////////////////////////
  RatingForCustomerRequestModel ratingForCustomerRequestModel =
      RatingForCustomerRequestModel();
  RatingForCustomerResponseModel ratingForCustomerResponseModel =
      RatingForCustomerResponseModel();
  /////////////////////////////////////////////////////////////////////////////
  LiveTrackerRequestModel liveTrackerRequestModel = LiveTrackerRequestModel();
  LiveTrackerResponseModel liveTrackerResponseModel =
      LiveTrackerResponseModel();
  /////////////////////////////////////////////////////////////////////////////
  ArrivalOfWinchDriverRequestModel arrivalOfWinchDriverRequestModel =
      ArrivalOfWinchDriverRequestModel(driverResponse: "Arrived");
  ArrivalOfWinchDriverResponseModel arrivalOfWinchDriverResponseModel =
      ArrivalOfWinchDriverResponseModel();
  /////////////////////////////////////////////////////////////////////////////
  StartingOfWinchTripRequestModel startingOfWinchTripRequestModel =
      StartingOfWinchTripRequestModel(driverResponse: "Service Start");
  StartingOfWinchTripResponseModel startingOfWinchTripResponseModel =
      StartingOfWinchTripResponseModel();

  getWinchDriverCurrentState(state) {
    currentState = state;
    print("current State $state");
    state == true
        ? SEARCHING_FOR_CUSTOMER = true
        : SEARCHING_FOR_CUSTOMER = false;
    if (currentState == true) {
    } else {
      if (upcomingRequestResponseModel.msg == "Check For Another Request")
        searchingForCustomerTimer.cancel();
      resetAllFlags();
    }
    notifyListeners();
  }

  getNearestClientToMe(context) async {
    if (CUSTOMER_FOUNDED == false) {
      await getWinchDriverCurrentLocation(context);
    }
    getNearestClientRequestModel.locationLat =
        Provider.of<MapsProvider>(context, listen: false)
            .currentLocation
            .latitude
            .toString();
    getNearestClientRequestModel.locationLong =
        Provider.of<MapsProvider>(context, listen: false)
            .currentLocation
            .longitude
            .toString();
    isLoading = true;
    getNearestClientResponseModel = await requestService.getNearestClient(
        getNearestClientRequestModel, loadJwtTokenFromDB());
    isLoading = false;
    if (getNearestClientResponseModel.requestId == null &&
        getNearestClientResponseModel.error == "No client requests now") {
      Provider.of<MapsProvider>(context, listen: false).locatePosition(context);
      Provider.of<PolyLineProvider>(context, listen: false).resetPolyLine();
      SEARCHING_FOR_CUSTOMER = true;
      CUSTOMER_FOUNDED = false;
      ALREADY_HAVE_RIDE = false;
      notifyListeners();
    }
    if (getNearestClientResponseModel.nearestRidePickupLocation != null) {
      // PolyLineProvider.getPlaceDirection(context, MapsProvider.currentLocation, MapsProvider.customerPickUpLocation, _googleMapController):
      CUSTOMER_FOUNDED = true;
      SEARCHING_FOR_CUSTOMER = false;
      notifyListeners();
    }
    if (getNearestClientResponseModel.requestId != null &&
        getNearestClientResponseModel.error != null) {
      ALREADY_HAVE_RIDE = true;
      SEARCHING_FOR_CUSTOMER = false;
      notifyListeners();
    }
    notifyListeners();
  }

  bool acceptUpcomingRequestIsLoading = false;
  acceptUpcomingRequest(context) async {
    acceptUpcomingRequestIsLoading = true;
    notifyListeners();
    upcomingRequestResponseModel = await requestService.acceptCustomerRequest(
        upcomingRequestAcceptRequestModel, loadJwtTokenFromDB());
    acceptUpcomingRequestIsLoading = false;
    if (upcomingRequestResponseModel != null) {
      RIDE_ACCEPTED = true;
      SEARCHING_FOR_CUSTOMER = false;
      Provider.of<MapsProvider>(context, listen: false).getPickUpAddress(
          getNearestClientResponseModel.nearestRidePickupLocation.lat,
          getNearestClientResponseModel.nearestRidePickupLocation.lng,
          context);
      Provider.of<MapsProvider>(context, listen: false).getDropOffAddress(
          getNearestClientResponseModel.nearestRideDistinationLocation.lat,
          getNearestClientResponseModel.nearestRideDistinationLocation.lng,
          context);
      // liveTrackerTimer = Timer.periodic(Duration(seconds: 30), (z) async {
      //   //trackWinchDriver(context);
      // });
    }
    notifyListeners();
  }

  bool cancelUpcomingRequestIsLoading = false;
  cancelUpcomingRequest(context) async {
    cancelUpcomingRequestIsLoading = true;
    upcomingRequestResponseModel = await requestService.acceptCustomerRequest(
        upcomingRequestDenyRequestModel, loadJwtTokenFromDB());
    cancelUpcomingRequestIsLoading = false;
    if (upcomingRequestResponseModel.msg == "Check For Another Request") {
      Provider.of<MapsProvider>(context, listen: false).locatePosition(context);
      SEARCHING_FOR_CUSTOMER = true;
      CUSTOMER_FOUNDED = false;
      Provider.of<PolyLineProvider>(context, listen: false).resetPolyLine();
      searchingForCustomerTimer =
          Timer.periodic(Duration(seconds: 3), (z) async {
        print("start");
        await getNearestClientToMe(context);
        if (CUSTOMER_FOUNDED == true) {
          z.cancel();
          print("customer found");
          print(
              "CustomerPickUpLocation: Lat : ${getNearestClientResponseModel.nearestRidePickupLocation.lat} ,long : ${getNearestClientResponseModel.nearestRidePickupLocation.lng}");
          print(
              "CustomerDropOffLocation: Lat : ${getNearestClientResponseModel.nearestRideDistinationLocation.lat} ,long : ${getNearestClientResponseModel.nearestRideDistinationLocation.lng}");
          Address finalPos = Address(descriptor: "PickUp ");
          finalPos.latitude = double.parse(
              getNearestClientResponseModel.nearestRidePickupLocation.lat);
          finalPos.longitude = double.parse(
              getNearestClientResponseModel.nearestRidePickupLocation.lng);
          Address initial =
              Provider.of<MapsProvider>(context, listen: false).currentLocation;
          Provider.of<PolyLineProvider>(context, listen: false)
              .getPlaceDirection(
                  context,
                  initial,
                  finalPos,
                  Provider.of<MapsProvider>(context, listen: false)
                      .googleMapController);
          notifyListeners();
        } else if (ALREADY_HAVE_RIDE == true) {
          z.cancel();
          print(getNearestClientResponseModel.error);
          print(getNearestClientResponseModel.requestId);
          notifyListeners();
        } else if (SEARCHING_FOR_CUSTOMER == true) {
          print("still searching");
          print(getNearestClientResponseModel.error);
        }
      });
    } else
      print(upcomingRequestResponseModel.msg);
    notifyListeners();
  }

  bool endCurrentWinchServiceIsLoading = false;
  endCurrentWinchService() async {
    endingWinchServiceRequestModel.finalLocationLat =
        winchDriverCurrentPosition.latitude.toString();
    endingWinchServiceRequestModel.finalLocationLong =
        winchDriverCurrentPosition.longitude.toString();
    endCurrentWinchServiceIsLoading = true;
    notifyListeners();
    endingWinchServiceResponseModel = await requestService.endCustomerTrip(
        endingWinchServiceRequestModel, loadJwtTokenFromDB());
    endCurrentWinchServiceIsLoading = false;
    print("live tracker stopped");
    liveTrackerTimer.cancel();
    SERVICE_FINISHED = true;
    //SEARCHING_FOR_CUSTOMER = true;
    notifyListeners();
    if (endingWinchServiceResponseModel.status == "COMPLETED") {
      print("live tracker stopped");
      liveTrackerTimer.cancel();
      SERVICE_FINISHED = true;
      //SEARCHING_FOR_CUSTOMER = true;
      notifyListeners();
    }
    notifyListeners();
  }

  rateCustomer(context) async {
    isLoading = true;
    ratingForCustomerResponseModel = await requestService.ratingForCustomer(
        ratingForCustomerRequestModel, loadJwtTokenFromDB());
    if (ratingForCustomerResponseModel.msg != null) // to be changed
    {
      await returnToDashBoard(context);
      isLoading = false;
    }
    notifyListeners();
  }

  returnToDashBoard(context) {
    Navigator.pushNamedAndRemoveUntil(
        context, DashBoard.routeName, (route) => false);
    Provider.of<MapsProvider>(context, listen: false).locatePosition(context);
    SEARCHING_FOR_CUSTOMER = true;
    CUSTOMER_FOUNDED = false;
    Provider.of<PolyLineProvider>(context, listen: false).resetPolyLine();
  }

  trackWinchDriver(context) async {
    print("live tracker started");
    print("live tracker request body: ${liveTrackerRequestModel.toJson()}");
    liveTrackerResponseModel = await requestService.liveTracker(
        liveTrackerRequestModel, loadJwtTokenFromDB());
    await getWinchDriverCurrentLocation(context);
    liveTrackerTimer = Timer.periodic(Duration(seconds: 30), (z) async {
      await getWinchDriverCurrentLocation(context);
      print("live tracker request body: ${liveTrackerRequestModel.toJson()}");
      isLoading = true;
      liveTrackerResponseModel = await requestService.liveTracker(
          liveTrackerRequestModel, loadJwtTokenFromDB());
      isLoading = false;
      if (liveTrackerResponseModel.done != null) {
        print("updated ${liveTrackerResponseModel.done}");
      } else {
        print(liveTrackerResponseModel.error);
        liveTrackerTimer.cancel();
        print("trip cancelled from customer & live location cancelled aslo");
        print("notifcation must be added to notify driver");
        // Provider.of<MapsProvider>(context, listen: false)
        //     .locatePosition(context);
        // SEARCHING_FOR_CUSTOMER = true;
        // CUSTOMER_FOUNDED = false;
        // Provider.of<PolyLineProvider>(context, listen: false).resetPolyLine();
        // Navigator.pushNamedAndRemoveUntil(
        //     context, DashBoard.routeName, (route) => false);
        returnToDashBoard(context);
      }
      notifyListeners();
    });
    notifyListeners();
  }

  //final x= Provider.of<MapsProvider>(ctx, listen: false);
  getWinchDriverCurrentLocation(context) async {
    isLoading = true;
    winchDriverCurrentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    isLoading = false;
    print("Current Postionss: $winchDriverCurrentPosition");
    Provider.of<MapsProvider>(context, listen: false).getCurrentLocationAddress(
        winchDriverCurrentPosition.latitude.toString(),
        winchDriverCurrentPosition.longitude.toString(),
        context);

    liveTrackerRequestModel.locationLat =
        winchDriverCurrentPosition.latitude.toString();
    liveTrackerRequestModel.locationLong =
        winchDriverCurrentPosition.longitude.toString();

    notifyListeners();
  }

  arrivedToCustomerLocation(context) async {
    isLoading = true;
    arrivalOfWinchDriverResponseModel =
        await requestService.arrivalToCustomerLocation(
            arrivalOfWinchDriverRequestModel, loadJwtTokenFromDB());
    isLoading = false;
    if (arrivalOfWinchDriverResponseModel.msg == "Alright!") {
      DriverARRIVED = true;
      Provider.of<PolyLineProvider>(context, listen: false).resetPolyLine();
    }

    notifyListeners();
  }

  startingWinchService(context) async {
    isLoading = true;
    startingOfWinchTripResponseModel = await requestService.startingWinchTrip(
        startingOfWinchTripRequestModel, loadJwtTokenFromDB());
    isLoading = false;
    if (startingOfWinchTripResponseModel.error == null) {
      SERVICE_STARTTED = true;
      notifyListeners();
      Provider.of<PolyLineProvider>(context, listen: false).getPlaceDirection(
          context,
          Provider.of<MapsProvider>(context, listen: false)
              .customerPickUpLocation,
          Provider.of<MapsProvider>(context, listen: false)
              .customerDropOffLocation,
          Provider.of<MapsProvider>(context, listen: false)
              .googleMapController);
    }
    notifyListeners();
  }

  resetAllFlags() {
    SEARCHING_FOR_CUSTOMER = false;
    CUSTOMER_FOUNDED = false;
    ALREADY_HAVE_RIDE = false;
    RIDE_ACCEPTED = false;
    notifyListeners();
  }
}

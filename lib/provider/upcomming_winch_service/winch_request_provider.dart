import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:winch_app/local_db/winch_driver_info_db.dart';
import 'package:winch_app/models/up_comming_requests/accepting_trip_model.dart';
import 'package:winch_app/models/up_comming_requests/arrival_to_customer_location_model.dart';
import 'package:winch_app/models/up_comming_requests/ending_trip_model.dart';
import 'package:winch_app/models/up_comming_requests/get_nearest_clients_model.dart';
import 'package:winch_app/models/up_comming_requests/live_tracker_model.dart';
import 'package:winch_app/models/up_comming_requests/rating_for_customer_model.dart';
import 'package:winch_app/models/up_comming_requests/startting_winch_trip_model.dart';
import 'package:winch_app/services/requesting_winch_driver/winch_requests_service.dart';

class WinchRequestProvider extends ChangeNotifier {
  bool currentState = false;
  bool isLoading = false;
  Timer liveTrackerTimer;
  Position winchDriverCurrentPosition;
  bool SEARCHING_FOR_CUSTOMER = false;
  bool CUSTOMER_FOUNDED = false;
  bool ALREADY_HAVE_RIDE = false;
  bool RIDE_ACCEPTED = false;

  WinchRequestService requestService = WinchRequestService();
  /////////////////////////////////////////////////////////////////////////////
  GetNearestClientRequestModel getNearestClientRequestModel =
      new GetNearestClientRequestModel();
  GetNearestClientResponseModel getNearestClientResponseModel =
      new GetNearestClientResponseModel();
  /////////////////////////////////////////////////////////////////////////////
  AcceptingWinchServiceRequestModel acceptingWinchServiceRequestModel =
      AcceptingWinchServiceRequestModel(driverResponse: "Accept");
  AcceptingWinchServiceResponseModel acceptingWinchServiceResponseModel =
      AcceptingWinchServiceResponseModel();
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
    state == true
        ? SEARCHING_FOR_CUSTOMER = true
        : SEARCHING_FOR_CUSTOMER = false;
    // if (currentState == true)
    //  // CUSTOMER_FOUNDED = true;
    // else
    //   //CUSTOMER_FOUNDED = false;
    notifyListeners();
  }

  getNearestClientToMe() async {
    isLoading = true;
    print("hk hk");
    getNearestClientResponseModel = await requestService.getNearestClient(
        getNearestClientRequestModel, loadJwtTokenFromDB());
    print("pk pk");
    isLoading = false;

    if (getNearestClientResponseModel.requestId == null &&
        getNearestClientResponseModel.error == "No client requests now") {
      print("hi hi hi");
      SEARCHING_FOR_CUSTOMER = true;
      CUSTOMER_FOUNDED = false;
      ALREADY_HAVE_RIDE = false;
      notifyListeners();
    }
    if (getNearestClientResponseModel.nearestRidePickupLocation != null) {
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

  acceptUpcomingRequest() async {
    isLoading = true;
    acceptingWinchServiceResponseModel =
        await requestService.acceptCustomerRequest(
            acceptingWinchServiceRequestModel, loadJwtTokenFromDB());
    isLoading = false;
    if (acceptingWinchServiceResponseModel != null) {
      RIDE_ACCEPTED = true;
      SEARCHING_FOR_CUSTOMER = false;
      print("live tracker started");
      liveTrackerTimer = Timer.periodic(Duration(seconds: 30), (z) async {
        trackWinchDriver();
      });
    }
    notifyListeners();
  }

  endCurrentWinchService(endingWinchServiceRequestModel) async {
    isLoading = true;
    endingWinchServiceResponseModel = await requestService.endCustomerTrip(
        endingWinchServiceRequestModel, loadJwtTokenFromDB());
    isLoading = false;
    if (endingWinchServiceResponseModel.status == "COMPLETED") {
      print("live tracker stopped");
      liveTrackerTimer.cancel();
      SEARCHING_FOR_CUSTOMER = true;
      notifyListeners();
    }
    notifyListeners();
  }

  rateCustomer() async {
    isLoading = true;
    ratingForCustomerResponseModel = await requestService.ratingForCustomer(
        ratingForCustomerRequestModel, loadJwtTokenFromDB());
    isLoading = false;
    notifyListeners();
  }

  trackWinchDriver() async {
    await getWinchDriverCurrentLocation();
    print("live tracker request body: ${liveTrackerRequestModel.toJson()}");
    isLoading = true;
    liveTrackerResponseModel = await requestService.liveTracker(
        liveTrackerRequestModel, loadJwtTokenFromDB());
    isLoading = false;
    if (liveTrackerResponseModel.done != null)
      print("updated ${liveTrackerResponseModel.done}");
    else
      print(liveTrackerResponseModel.error);

    notifyListeners();
  }

  getWinchDriverCurrentLocation() async {
    isLoading = true;
    winchDriverCurrentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    isLoading = false;
    print("Current Postionss: $winchDriverCurrentPosition");
    liveTrackerRequestModel.locationLat =
        winchDriverCurrentPosition.latitude.toString();
    liveTrackerRequestModel.locationLong =
        winchDriverCurrentPosition.longitude.toString();
    notifyListeners();
  }

  arrivedToCustomerLocation() async {
    isLoading = true;
    arrivalOfWinchDriverResponseModel =
        await requestService.arrivalToCustomerLocation(
            arrivalOfWinchDriverRequestModel, loadJwtTokenFromDB());
    isLoading = false;
    notifyListeners();
  }

  startingWinchService() async {
    isLoading = true;
    startingOfWinchTripResponseModel = await requestService.startingWinchTrip(
        startingOfWinchTripRequestModel, loadJwtTokenFromDB());
    isLoading = false;
    notifyListeners();
  }
}

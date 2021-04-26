import 'dart:async';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:winch_app/models/maps/address.dart';
import 'package:winch_app/models/up_comming_requests/get_nearest_client_model.dart';
import 'package:winch_app/provider/maps_prepration/maps_provider.dart';
import 'package:winch_app/provider/upcomming_winch_service/winch_state_provider.dart';
import 'package:winch_app/services/Maps_Assistants/maps_services.dart';
import 'home_components/driver_status_header.dart';

class HomeBody extends StatefulWidget {
  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  Completer<GoogleMapController> _completerGoogleMap = Completer(); //////
  //GoogleMapController _googleMapController;
  //Position currentPosition;
  // var geoLocator = Geolocator();

  // void locatePosition(context) async {
  //   Position position = await Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.high);
  //   currentPosition = position;
  //   print("Current position:: $currentPosition");
  //   LatLng latLatPosition = LatLng(position.latitude, position.longitude);
  //
  //   CameraPosition cameraPosition =
  //       new CameraPosition(target: latLatPosition, zoom: 15.5);
  //   _googleMapController
  //       .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  // }

  final CameraPosition _initialPosition = CameraPosition(
    target: LatLng(31.2001, 29.9187),
    zoom: 15.4746,
  );

  //Address myStartAddress = Address(latitude: null, longitude: null, placeName: null);
  Address pickUpAddress = Address(
      latitude: 31.20684069999999, longitude: 29.9237711, placeName: null);
  Address dropOffAddress =
      Address(latitude: 31.2181232, longitude: 29.9570564, placeName: null);

  // getAddressNames() async {
  //   LatLng customerPosition =
  //       LatLng(pickUpAddress.latitude, pickUpAddress.longitude);
  //   LatLng destinationPosition =
  //       LatLng(dropOffAddress.latitude, dropOffAddress.longitude);
  //   //LatLng startPosition = LatLng(myStartAddress.latitude, myStartAddress.longitude);
  //   print(destinationPosition);
  //   pickUpAddress.placeName =
  //       await MapsApiService.searchCoordinateAddress(customerPosition, context);
  //   dropOffAddress.placeName = await MapsApiService.searchCoordinateAddress(
  //       destinationPosition, context);
  //   print("Customer pickUp location:: ${pickUpAddress.placeName}");
  //   print("Customer dropOff location:: ${dropOffAddress.placeName}");
  //   //myStartAddress.placeName = await MapsApiService.searchCoordinateAddress(
  //   //  startPosition, context);
  //   //Provider.of<AppData>(context, listen: false).updateMyStartLocationAddress(myStartAddress);
  //   //print("provider my current location:: ${Provider.of<AppData>(context, listen: false).myStartLocation}");
  //
  //   Provider.of<MapsProvider>(context, listen: false)
  //       .updatePickUpLocationAddress(pickUpAddress);
  //   Provider.of<MapsProvider>(context, listen: false)
  //       .updateDropOffLocationAddress(dropOffAddress);
  //
  //   print("updated");
  //   print(
  //       "provider pickUp location:: ${Provider.of<MapsProvider>(context, listen: false).pickUpLocation}");
  //   print(
  //       "provider dropOff location:: ${Provider.of<MapsProvider>(context, listen: false).dropOffLocation}");
  //   print(
  //       "provider pickup latitude:: ${Provider.of<MapsProvider>(context, listen: false).pickUpLocation.latitude}");
  //   print(
  //       "provider pickup longitude:: ${Provider.of<MapsProvider>(context, listen: false).pickUpLocation.longitude}");
  //   print(
  //       "provider pickup place name:: ${Provider.of<MapsProvider>(context, listen: false).pickUpLocation.placeName}");
  //   print(
  //       "provider dropOff place name:: ${Provider.of<MapsProvider>(context, listen: false).dropOffLocation.placeName}");
  //   print(
  //       "provider dropOff latitude:: ${Provider.of<MapsProvider>(context, listen: false).dropOffLocation.latitude}");
  //   print(
  //       "provider dropOff longitude:: ${Provider.of<MapsProvider>(context, listen: false).dropOffLocation.longitude}");
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double WIDTH = double.maxFinite;
    return Consumer2<MapsProvider, WinchStateProvider>(
      builder: (context, MapsProvider, WinchStateProvider, child) => SafeArea(
        child: Scaffold(
          body: Stack(
            clipBehavior: Clip.hardEdge,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: size.height * 0.00,
                ),
                child: Container(
                  height: size.height * 0.91,
                  child: GoogleMap(
                    initialCameraPosition: _initialPosition,
                    mapType: MapType.normal,
                    myLocationButtonEnabled: true,
                    myLocationEnabled: true,
                    zoomGesturesEnabled: true,
                    zoomControlsEnabled: true,
                    mapToolbarEnabled: true,
                    onMapCreated: (GoogleMapController controller) async {
                      _completerGoogleMap.complete(controller);
                      MapsProvider.googleMapController = controller;
                      await MapsProvider.locatePosition();
                      await MapsProvider.getAddressNames(
                          pickUpAddress, dropOffAddress, context);
                      WinchStateProvider.getNearestClientRequestModel =
                          GetNearestClientRequestModel(
                              locationLat: MapsProvider.currentPosition.latitude
                                  .toString(),
                              locationLong: MapsProvider
                                  .currentPosition.longitude
                                  .toString());
                    },
                  ),
                ),
              ),

              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  height: size.height * 0.4,
                  width: MediaQuery.of(context).size.width * 1,
                  decoration: new BoxDecoration(
                    gradient: new LinearGradient(
                      end: Alignment.bottomCenter,
                      begin: Alignment.topCenter,
                      colors: <Color>[
                        Colors.white,
                        Colors.white.withOpacity(0)
                      ],
                    ),
                    borderRadius:
                        BorderRadiusDirectional.all(Radius.circular(10)),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  height: size.height * 0.9,
                  width: MediaQuery.of(context).size.width * 0.09,
                  decoration: new BoxDecoration(
                    gradient: new LinearGradient(
                      end: Alignment.centerRight,
                      begin: Alignment.centerLeft,
                      colors: <Color>[
                        Colors.white,
                        Colors.white.withOpacity(0.0)
                      ],
                    ),
                    borderRadius:
                        BorderRadiusDirectional.all(Radius.circular(10)),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  height: size.height * 0.9,
                  width: MediaQuery.of(context).size.width * 0.08,
                  decoration: new BoxDecoration(
                    gradient: new LinearGradient(
                      end: Alignment.centerLeft,
                      begin: Alignment.centerRight,
                      colors: <Color>[
                        Colors.white,
                        Colors.white.withOpacity(0.0)
                      ],
                    ),
                    borderRadius:
                        BorderRadiusDirectional.all(Radius.circular(10)),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: size.height * 0.13,
                  width: MediaQuery.of(context).size.width * 1,
                  decoration: new BoxDecoration(
                    gradient: new LinearGradient(
                      end: Alignment.topCenter,
                      begin: Alignment.bottomCenter,
                      colors: <Color>[
                        Colors.white,
                        Colors.white.withOpacity(0.0)
                      ],
                    ),
                    borderRadius:
                        BorderRadiusDirectional.all(Radius.circular(10)),
                  ),
                ),
              ),
              DriverStatusHeader()
              //RideRequest(),
            ],
          ),
        ),
      ),
    );
  }
}

import 'dart:async';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:winch_app/models/maps/address.dart';
import 'package:winch_app/provider/appData.dart';
import 'package:winch_app/screens/request_screens/hero_dialog_route.dart';
import 'package:winch_app/screens/request_screens/ride_request.dart';
import 'package:winch_app/services/Maps_Assistants/maps_services.dart';

class HomeBody extends StatefulWidget {
  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  Completer<GoogleMapController> _completerGoogleMap = Completer(); //////
  GoogleMapController _googleMapController;
  Position currentPosition;
  var geoLocator = Geolocator();

  void locatePosition(context) async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    currentPosition = position;
    print("Current position:: $currentPosition");
    LatLng latLatPosition = LatLng(position.latitude, position.longitude);
   // myStartAddress.latitude = position.latitude;
    //myStartAddress.longitude = position.longitude;

    CameraPosition cameraPosition =
        new CameraPosition(target: latLatPosition, zoom: 15.5);
    _googleMapController
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  bool buttonState = true;

  final CameraPosition _initialPosition = CameraPosition(
    target: LatLng(31.2001, 29.9187),
    zoom: 15.4746,
  );


  //Address myStartAddress = Address(latitude: null, longitude: null, placeName: null);
  Address pickUpAddress = Address(latitude: 31.20684069999999, longitude: 29.9237711, placeName: null);
  Address dropOffAddress = Address(latitude: 31.2181232, longitude: 29.9570564, placeName: null);

  getAddressNames() async
  {
    LatLng customerPosition = LatLng(pickUpAddress.latitude, pickUpAddress.longitude);
    LatLng destinationPosition = LatLng(dropOffAddress.latitude, dropOffAddress.longitude);
    //LatLng startPosition = LatLng(myStartAddress.latitude, myStartAddress.longitude);
    print(destinationPosition);
    pickUpAddress.placeName = await MapsApiService.searchCoordinateAddress(
        customerPosition, context);
    dropOffAddress.placeName = await MapsApiService.searchCoordinateAddress(
        destinationPosition, context);
    print("Customer pickUp location:: ${pickUpAddress.placeName}");
    print("Customer dropOff location:: ${dropOffAddress.placeName}");
    //myStartAddress.placeName = await MapsApiService.searchCoordinateAddress(
      //  startPosition, context);
    //Provider.of<AppData>(context, listen: false).updateMyStartLocationAddress(myStartAddress);
    //print("provider my current location:: ${Provider.of<AppData>(context, listen: false).myStartLocation}");

    Provider.of<AppData>(context, listen: false).updatePickUpLocationAddress(pickUpAddress);
    Provider.of<AppData>(context, listen: false).updateDropOffLocationAddress(dropOffAddress);

    print("updated");
    print("provider pickUp location:: ${Provider.of<AppData>(context, listen: false).pickUpLocation}");
    print("provider dropOff location:: ${Provider.of<AppData>(context, listen: false).dropOffLocation}");
    print("provider pickup latitude:: ${Provider.of<AppData>(context, listen: false).pickUpLocation.latitude}");
    print("provider pickup longitude:: ${Provider.of<AppData>(context, listen: false).pickUpLocation.longitude}");
    print("provider pickup place name:: ${Provider.of<AppData>(context, listen: false).pickUpLocation.placeName}");
    print("provider dropOff place name:: ${Provider.of<AppData>(context, listen: false).dropOffLocation.placeName}");
    print("provider dropOff latitude:: ${Provider.of<AppData>(context, listen: false).dropOffLocation.latitude}");
    print("provider dropOff longitude:: ${Provider.of<AppData>(context, listen: false).dropOffLocation.longitude}");

  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
    children: [

      Padding(
        padding: EdgeInsets.only(
          top: size.height * 0.03,
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
                onMapCreated: (GoogleMapController controller) {
                  _completerGoogleMap.complete(controller);
                  _googleMapController = controller;
                  locatePosition(context);
                  getAddressNames();
                },
              ),
            ),

      ),

      //RideRequest(),



  ]
    )
    );
  }
}

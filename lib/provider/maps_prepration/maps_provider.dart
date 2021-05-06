import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:winch_app/models/maps/address.dart';
import 'package:winch_app/services/Maps_Assistants/maps_services.dart';

class MapsProvider extends ChangeNotifier {
  Address customerPickUpLocation = Address(descriptor: "PickUp");
  Address customerDropOffLocation = Address(descriptor: "DropOff");
  Address currentLocation = Address(descriptor: "My current Position");
  GoogleMapController googleMapController;


  void updateCustomerPickUpLocationAddress(Address pickUpAddress) {
    customerPickUpLocation = pickUpAddress;
    notifyListeners();
  }

  void updateCustomerDropOffLocationAddress(Address dropOffAddress) {
    customerDropOffLocation = dropOffAddress;
    notifyListeners();
  }

  void updateCurrentLocationAddress(Address myStartAddress) {
    currentLocation = myStartAddress;
    notifyListeners();
  }

  void locatePosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    currentLocation.latitude = position.latitude;
    currentLocation.longitude = position.longitude;
    print("Current position:: ${currentLocation.placeName}");
    LatLng latLatPosition = LatLng(position.latitude, position.longitude);
    CameraPosition cameraPosition =
        new CameraPosition(target: latLatPosition, zoom: 15.5);
    googleMapController
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }


  getPickUpAddress(String pickUpPositionLatitude, String pickUpPositionLongitude, context) async {

    customerPickUpLocation.latitude = double.parse(pickUpPositionLatitude);
    customerPickUpLocation.longitude = double.parse(pickUpPositionLongitude);
    LatLng pickUpPosition = LatLng(customerPickUpLocation.latitude, customerPickUpLocation.longitude);
    customerPickUpLocation.placeName = await MapsApiService.searchCoordinateAddress(pickUpPosition, context);

    print("Customer pickUp location:: ${customerPickUpLocation.placeName}");
    print("updated");
    print("provider pickUp location:: $customerPickUpLocation");
    print("provider pickup latitude:: ${customerPickUpLocation.latitude}");
    print("provider pickup longitude:: ${customerPickUpLocation.longitude}");
    print("provider pickup place name:: ${customerPickUpLocation.placeName}");
    notifyListeners();
  }

  getDropOffAddress(String dropOffPositionLatitude, String dropOffPositionLongitude, context) async {
    customerDropOffLocation.latitude = double.parse(dropOffPositionLatitude);
    customerDropOffLocation.longitude = double.parse(dropOffPositionLongitude);
    LatLng dropOffPosition = LatLng(customerDropOffLocation.latitude, customerDropOffLocation.longitude);
    customerDropOffLocation.placeName = await MapsApiService.searchCoordinateAddress(dropOffPosition, context);

    print("updated");
    print("provider dropOff location:: $customerDropOffLocation");
    print("provider dropOff latitude:: ${customerDropOffLocation.latitude}");
    print("provider dropOff longitude:: ${customerDropOffLocation.longitude}");
    print("provider dropOff place name:: ${customerDropOffLocation.placeName}");
    notifyListeners();
  }

  getCurrentLocationAddress(String currentPositionLatitude, String currentPositionLongitude, context) async {
    currentLocation.latitude = double.parse(currentPositionLatitude);
    currentLocation.longitude = double.parse(currentPositionLongitude);
    LatLng currentPosition = LatLng(currentLocation.latitude, currentLocation.longitude);
    currentLocation.placeName = await MapsApiService.searchCoordinateAddress(currentPosition, context);

    print("updated");
    print("provider Current location:: $currentLocation");
    print("provider Current latitude:: ${currentLocation.latitude}");
    print("provider Current longitude:: ${currentLocation.longitude}");
    print("provider Current place name:: ${currentLocation.placeName}");
    notifyListeners();
  }

}

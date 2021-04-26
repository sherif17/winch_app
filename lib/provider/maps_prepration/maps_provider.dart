import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:winch_app/models/maps/address.dart';
import 'package:winch_app/services/Maps_Assistants/maps_services.dart';

class MapsProvider extends ChangeNotifier {
  Address pickUpLocation;
  Address dropOffLocation;
  Address myStartLocation;
  GoogleMapController googleMapController;
  Position currentPosition;

  void updatePickUpLocationAddress(Address pickUpAddress) {
    pickUpLocation = pickUpAddress;
    notifyListeners();
  }

  void updateDropOffLocationAddress(Address dropOffAddress) {
    dropOffLocation = dropOffAddress;
    notifyListeners();
  }

  void updateMyStartLocationAddress(Address myStartAddress) {
    myStartLocation = myStartAddress;
    notifyListeners();
  }

  void locatePosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    currentPosition = position;
    print("Current position:: $currentPosition");
    LatLng latLatPosition = LatLng(position.latitude, position.longitude);
    CameraPosition cameraPosition =
        new CameraPosition(target: latLatPosition, zoom: 15.5);
    googleMapController
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  getAddressNames(
      Address pickUpAddress, Address dropOffAddress, context) async {
    LatLng customerPosition =
        LatLng(pickUpAddress.latitude, pickUpAddress.longitude);
    LatLng destinationPosition =
        LatLng(dropOffAddress.latitude, dropOffAddress.longitude);
    print(destinationPosition);
    pickUpAddress.placeName =
        await MapsApiService.searchCoordinateAddress(customerPosition, context);
    dropOffAddress.placeName = await MapsApiService.searchCoordinateAddress(
        destinationPosition, context);
    print("Customer pickUp location:: ${pickUpAddress.placeName}");
    print("Customer dropOff location:: ${dropOffAddress.placeName}");

    updatePickUpLocationAddress(pickUpAddress);
    updateDropOffLocationAddress(dropOffAddress);

    print("updated");
    print("provider pickUp location:: $pickUpLocation");
    print("provider dropOff location:: $dropOffLocation");
    print("provider pickup latitude:: ${pickUpLocation.latitude}");
    print("provider pickup longitude:: ${pickUpLocation.longitude}");
    print("provider pickup place name:: ${pickUpLocation.placeName}");
    print("provider dropOff place name:: ${dropOffLocation.placeName}");
    print("provider dropOff latitude:: ${dropOffLocation.latitude}");
    print("provider dropOff longitude:: ${dropOffLocation.longitude}");
  }
}

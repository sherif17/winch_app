import 'package:flutter/cupertino.dart';
import 'package:winch_app/models/maps/address.dart';

class AppData extends ChangeNotifier
{
  Address pickUpLocation;
  Address dropOffLocation;
  Address myStartLocation;

  void updatePickUpLocationAddress(Address pickUpAddress)
  {
    pickUpLocation = pickUpAddress;
    notifyListeners();
  }

  void updateDropOffLocationAddress(Address dropOffAddress)
  {
    dropOffLocation = dropOffAddress;
    notifyListeners();
  }

  void updateMyStartLocationAddress(Address myStartAddress)
  {
    myStartLocation = myStartAddress;
    notifyListeners();
  }

}

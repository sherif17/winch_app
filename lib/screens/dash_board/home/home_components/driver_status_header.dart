import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_avatar/flutter_advanced_avatar.dart';
import 'package:fswitch/fswitch.dart';
import 'package:provider/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:winch_app/local_db/winch_driver_info_db.dart';
import 'package:winch_app/models/maps/address.dart';
import 'package:winch_app/provider/maps_prepration/maps_provider.dart';
import 'package:winch_app/provider/maps_prepration/polyLineProvider.dart';
import 'package:winch_app/provider/upcomming_winch_service/winch_request_provider.dart';

class DriverStatusHeader extends StatefulWidget {
  @override
  _DriverStatusHeaderState createState() => _DriverStatusHeaderState();
}

class _DriverStatusHeaderState extends State<DriverStatusHeader> {
  @override
  void initState() {
    super.initState();
    print(loadJwtTokenFromDB());
    setCustomMarker();
  }

  BitmapDescriptor winchMapMarker;
  BitmapDescriptor customerPickUpLocMarker;
  BitmapDescriptor dropOffLocMarker;
  BitmapDescriptor winchWithCarMapMarker;
  void setCustomMarker() async {
    winchMapMarker = await BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(0.1,0.1)), 'assets/icons/empty_winch.png');
    customerPickUpLocMarker = await BitmapDescriptor.fromAssetImage(ImageConfiguration(), 'assets/icons/Car.png');
    dropOffLocMarker = await BitmapDescriptor.fromAssetImage(ImageConfiguration(), 'assets/icons/google-maps-car-icon.png');
    winchWithCarMapMarker = await BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(0.1,0.1)), 'assets/icons/winch_with_car.png');
  }

  Timer z;

  @override
  Widget build(BuildContext context) {
    return Consumer<WinchRequestProvider>(
      builder: (context, val, child) => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          LinearProgressIndicator(
            backgroundColor: val.SEARCHING_FOR_CUSTOMER == true
                ? Colors.greenAccent
                : Colors.white,
          ),
          buildDriverInfo(context)
        ],
      ),
    );
  }

  buildDriverInfo(context) {
    return Consumer<WinchRequestProvider>(
      builder: (context, val, child) => Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.02,
            vertical: MediaQuery.of(context).size.height * 0.02),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AdvancedAvatar(
              image: AssetImage("assets/icons/profile.png"),
              size: MediaQuery.of(context).size.height * 0.045,
              statusColor:
                  val.currentState == true ? Colors.greenAccent : Colors.grey,
              decoration: BoxDecoration(
                border: Border.all(
                  color: val.currentState == true ? Colors.green : Colors.grey,
                  width: 3,
                ),
                color: Colors.indigoAccent,
                shape: BoxShape.circle,
              ),
            ),
            val.SEARCHING_FOR_CUSTOMER == true
                ? DefaultTextStyle(
                    style: Theme.of(context).textTheme.headline5,
                    child: AnimatedTextKit(
                      animatedTexts: [
                        ScaleAnimatedText(
                          'Online',
                          duration: const Duration(seconds: 3),
                        ),
                        ScaleAnimatedText(
                          'Searching....',
                          duration: const Duration(seconds: 3),
                        ),
                      ],
                      repeatForever: true,
                      pause: const Duration(milliseconds: 2),
                      displayFullTextOnTap: true,
                      stopPauseOnTap: true,
                    ),
                  )
                : val.CUSTOMER_FOUNDED == true
                    ? Text("Customer Founded")
                    : Text(val.currentState == true ? "Online" : "Offline"),
            FSwitch(
                open: val.currentState,
                openColor: Theme.of(context).primaryColorLight,
                shadowBlur: 3.0,
                openChild: Icon(Icons.done, color: Colors.white),
                closeChild: Icon(Icons.power_settings_new),
                width: MediaQuery.of(context).size.width * 0.15,
                height: MediaQuery.of(context).size.width * 0.05,
                onChanged: (bool v) async {
                  val.getWinchDriverCurrentState(v);
                  if (v == true) {
                    z = Timer.periodic(Duration(seconds: 20), (z) async {
                      print("start");
                      await val.getNearestClientToMe(context);
                      if (val.CUSTOMER_FOUNDED == true) {
                        z.cancel();
                        print("customer found");
                        print(
                            "CustomerPickUpLocation: Lat : ${val.getNearestClientResponseModel.nearestRidePickupLocation.lat} ,long : ${val.getNearestClientResponseModel.nearestRidePickupLocation.lng}");
                        print(
                            "CustomerDropOffLocation: Lat : ${val.getNearestClientResponseModel.nearestRideDistinationLocation.lat} ,long : ${val.getNearestClientResponseModel.nearestRideDistinationLocation.lng}");
                        Address finalPos = Address(descriptor: "PickUp ");
                        finalPos.latitude = double.parse(val
                            .getNearestClientResponseModel
                            .nearestRidePickupLocation
                            .lat);
                        finalPos.longitude = double.parse(val
                            .getNearestClientResponseModel
                            .nearestRidePickupLocation
                            .lng);
                        print(finalPos.latitude);
                        print(finalPos.latitude.runtimeType);
                        Address initial =
                            Provider.of<MapsProvider>(context, listen: false)
                                .currentLocation;
                        await Provider.of<PolyLineProvider>(context,
                                listen: false)
                            .getPlaceDirectionWithCustomMarker(context, initial, finalPos, Provider.of<MapsProvider>(context, listen: false).googleMapController, winchMapMarker, customerPickUpLocMarker );

                        val.isPopRequestDataReady = true;
                      } else if (val.ALREADY_HAVE_RIDE == true) {
                        z.cancel();
                        print(val.getNearestClientResponseModel.error);
                        print(val.getNearestClientResponseModel.requestId);
                      } else if (val.SEARCHING_FOR_CUSTOMER == true) {
                        print("still searching");
                        print(val.getNearestClientResponseModel.error);
                      }
                    });
                  } else {
                    z.cancel();
                    print("timer is cancelled");
                  }
                }),
          ],
        ),
      ),
    );
  }
}

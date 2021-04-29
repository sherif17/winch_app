import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_avatar/flutter_advanced_avatar.dart';
import 'package:fswitch/fswitch.dart';
import 'package:provider/provider.dart';
import 'package:winch_app/local_db/winch_driver_info_db.dart';
import 'package:winch_app/provider/maps_prepration/maps_provider.dart';
import 'package:winch_app/provider/upcomming_winch_service/winch_request_provider.dart';

class DriverStatusHeader extends StatefulWidget {
  @override
  _DriverStatusHeaderState createState() => _DriverStatusHeaderState();
}

class _DriverStatusHeaderState extends State<DriverStatusHeader> {
  @override
  void initState() {
    super.initState();
    //print(loadJwtTokenFromDB());
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
                      totalRepeatCount: 100000000000,
                      pause: const Duration(milliseconds: 2),
                      displayFullTextOnTap: true,
                      stopPauseOnTap: true,
                    ),
                  )
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
                      await val.getNearestClientToMe();
                      print(val.getNearestClientResponseModel.error);
                      if (val.CUSTOMER_FOUNDED == true) {
                        z.cancel();
                        print("customer found");
                        print(
                            "CustomerPickUpLocation: Lat : ${val.getNearestClientResponseModel.nearestRidePickupLocation.lat} ,long : ${val.getNearestClientResponseModel.nearestRidePickupLocation.lng}");
                        print(
                            "CustomerDropOffLocation: Lat : ${val.getNearestClientResponseModel.dropoffLocation.lat} ,long : ${val.getNearestClientResponseModel.dropoffLocation.lng}");
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

Timer timer;

startTimer() {
  timer = Timer.periodic(Duration(seconds: 30), (timer) {});
}

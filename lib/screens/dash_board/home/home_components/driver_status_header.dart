import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_avatar/flutter_advanced_avatar.dart';
import 'package:fswitch/fswitch.dart';
import 'package:provider/provider.dart';
import 'package:winch_app/provider/upcomming_winch_service/winch_state_provider.dart';

class DriverStatusHeader extends StatefulWidget {
  @override
  _DriverStatusHeaderState createState() => _DriverStatusHeaderState();
}

class _DriverStatusHeaderState extends State<DriverStatusHeader> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [buildDriverInfo(context)],
    );
  }

  buildDriverInfo(context) {
    return Padding(
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
            statusColor: Provider.of<WinchStateProvider>(context, listen: true)
                        .currentState ==
                    true
                ? Colors.greenAccent
                : Colors.grey,
            decoration: BoxDecoration(
              border: Border.all(
                color: Provider.of<WinchStateProvider>(context, listen: true)
                            .currentState ==
                        true
                    ? Colors.green
                    : Colors.grey,
                width: 3,
              ),
              color: Colors.indigoAccent,
              shape: BoxShape.circle,
            ),
          ),
          Text(Provider.of<WinchStateProvider>(context, listen: true)
                      .currentState ==
                  true
              ? "Online"
              : "Offline"),
          FSwitch(
              open: Provider.of<WinchStateProvider>(context).currentState,
              openColor: Theme.of(context).primaryColorLight,
              shadowBlur: 3.0,
              openChild: Icon(Icons.done, color: Colors.white),
              closeChild: Icon(Icons.power_settings_new),
              width: MediaQuery.of(context).size.width * 0.15,
              height: MediaQuery.of(context).size.width * 0.05,
              onChanged: (bool v) {
                Provider.of<WinchStateProvider>(context, listen: false)
                    .getWinchDriverCurrentState(v);
              }),
        ],
      ),
    );
  }
}

Timer timer;

startTimer() {
  timer = Timer.periodic(Duration(seconds: 30), (timer) {});
}

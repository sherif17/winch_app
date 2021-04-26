import 'dart:async';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:winch_app/screens/dash_board/home/home_components/rps_custom_painter.dart';
import 'package:winch_app/screens/request_screens/ride_request.dart';

import 'home_components/driver_status_header.dart';

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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double WIDTH = double.maxFinite;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          clipBehavior: Clip.hardEdge,
          //fit: StackFit.expand,
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
                  onMapCreated: (GoogleMapController controller) {
                    _completerGoogleMap.complete(controller);
                    _googleMapController = controller;
                    locatePosition(context);
                  },
                ),
              ),
            ),
            RideRequest(),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: size.height * 0.4,
                width: MediaQuery.of(context).size.width * 1,
                decoration: new BoxDecoration(
                  gradient: new LinearGradient(
                    end: Alignment.bottomCenter,
                    begin: Alignment.topCenter,
                    colors: <Color>[Colors.white, Colors.white.withOpacity(0)],
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
            // CustomPaint(
            //   child:
            //   size: Size(
            //       WIDTH,
            //       (WIDTH * 0.625)
            //           .toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
            //   painter: RPSCustomPainter(),
            // ),



          ],
        ),
      ),
    );
  }
}

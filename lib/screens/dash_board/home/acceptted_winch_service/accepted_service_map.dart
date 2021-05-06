import 'dart:async';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:winch_app/local_db/winch_driver_info_db.dart';
import 'package:winch_app/models/maps/direction_details.dart';
import 'package:winch_app/provider/maps_prepration/maps_provider.dart';
import 'package:winch_app/provider/maps_prepration/polyLineProvider.dart';
import 'package:winch_app/shared_prefrences/winch_user_model.dart';

import 'acceptted_serivce_sheet.dart';

class AcceptedServiceScreen extends StatefulWidget {
  static String routeName = '/AcceptedServiceScreen';
  @override
  _AcceptedServiceScreenState createState() => _AcceptedServiceScreenState();
}

class _AcceptedServiceScreenState extends State<AcceptedServiceScreen> {
  String currentLang = loadCurrentLangFromDB();
  String fname = loadFirstNameFromDB();
  String jwtToken = loadJwtTokenFromDB();

  @override
  void initState() {
    super.initState();
    //getCurrentPrefData();
  }

  void getCurrentPrefData() {
    getPrefCurrentLang().then((value) {
      setState(() {
        currentLang = value;
      });
    });
    getPrefFirstName().then((value) {
      setState(() {
        fname = value;
      });
    });
    getPrefJwtToken().then((value) {
      jwtToken = value;
    });
  }

  Completer<GoogleMapController> _completerGoogleMap = Completer();
  GoogleMapController _googleMapController;

  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  DirectionDetails tripDirectionDetails;

  List<LatLng> pLineCoordinates = [];
  Set<Polyline> polylineSet = {};
  Set<Marker> markersSet = {};
  Set<Circle> circlesSet = {};


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    var initialPos = Provider
        .of<MapsProvider>(context, listen: false)
        .currentLocation;

    final CameraPosition _initialPosition = CameraPosition(
      target: LatLng(initialPos.latitude, initialPos.longitude),
      zoom: 15.4746,
    );

    return Consumer2<PolyLineProvider, MapsProvider>(
      builder: (context, PolyLineProvider, MapsProvider, child) =>
          Scaffold(
            key: scaffoldKey,
            body: Stack(
              children: [
                // Map
                Padding(
                  padding: EdgeInsets.only(
                    top: size.height * 0.04,
                    bottom: 180.0,
                  ),
                  child: Container(
                    //height: size.height * 0.77,
                    height: size.height - (size.height * 0.04),
                    child: GoogleMap(
                        initialCameraPosition: _initialPosition,
                        mapType: MapType.normal,
                        myLocationButtonEnabled: true,
                        myLocationEnabled: true,
                        zoomGesturesEnabled: true,
                        zoomControlsEnabled: true,
                        mapToolbarEnabled: true,
                        polylines: PolyLineProvider.polylineSet,
                        markers: PolyLineProvider.markersSet,
                        circles: PolyLineProvider.circlesSet,
                        onMapCreated: (GoogleMapController controller) {
                          _completerGoogleMap.complete(controller);
                          MapsProvider.googleMapController = controller;
                          PolyLineProvider.getPlaceDirectionWithNav(
                              context, MapsProvider.currentLocation,
                              MapsProvider.customerPickUpLocation,
                              MapsProvider.googleMapController);
                          //getPlaceDirection(context);

                        }),
                  ),
                ),

                AcceptedServiceSheet(),
              ],
            ),
          ),
    );
  }
}
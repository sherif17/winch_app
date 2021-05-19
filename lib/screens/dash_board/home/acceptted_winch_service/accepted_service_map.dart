import 'dart:async';
import 'dart:ui';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mapbox_navigation/library.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:winch_app/local_db/winch_driver_info_db.dart';
import 'package:winch_app/models/maps/direction_details.dart';
import 'package:winch_app/provider/maps_prepration/maps_provider.dart';
import 'package:winch_app/provider/maps_prepration/polyLineProvider.dart';
import 'package:winch_app/provider/upcomming_winch_service/winch_request_provider.dart';
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
    Provider.of<WinchRequestProvider>(context, listen: false)
        .trackWinchDriver(context);
    super.initState();
    //getCurrentPrefData();
  }

  @override
  void didChangeDependencies() {
    //beginNavigation();

    super.didChangeDependencies();
  }

  Completer<GoogleMapController> _completerGoogleMap = Completer();

  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var initialPos =
        Provider.of<MapsProvider>(context, listen: false).currentLocation;

    final CameraPosition _initialPosition = CameraPosition(
      //target: LatLng(31.2062, 29.9249),
      target: LatLng(initialPos.latitude, initialPos.longitude),
      zoom: 15.4746,
    );

    return Consumer2<PolyLineProvider, MapsProvider>(
      builder: (context, PolyLineProvider, MapsProvider, child) => Stack(
        children: [
          Scaffold(
            key: scaffoldKey,
            body: SafeArea(
              child: Stack(
                children: [
                  // Map
                  Stack(
                    children: [
                      GoogleMap(
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
                            PolyLineProvider.getPlaceDirection(
                                context,
                                MapsProvider.currentLocation,
                                MapsProvider.customerPickUpLocation,
                                MapsProvider.googleMapController);
                            //getPlaceDirection(context);
                          }),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: EdgeInsets.only(top: size.height * 0.01),
                          child: Container(
                            height: size.height * 0.17,
                            width: size.width * 0.95,
                            decoration: BoxDecoration(
                              color: Color(0xFF4F5266),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Column(
                              children: [
                                Expanded(
                                    flex: 2,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Column(
                                            children: [
                                              Icon(
                                                Icons.trending_up_rounded,
                                                color: Colors.white,
                                                size: 50,
                                              ),
                                              Text(
                                                PolyLineProvider
                                                    .tripDirectionDetails
                                                    .distanceText,
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 4,
                                          child: Text(
                                              "${MapsProvider.customerPickUpLocation.placeName ?? "Customer Pick Up Location Place Name"}",
                                              style: TextStyle(
                                                  color: Colors.white)),
                                        )
                                      ],
                                    )),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: size.width * 0.03),
                                  child: Divider(
                                    color: Colors.white,
                                    thickness: 2,
                                  ),
                                ),
                                Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: size.width * 0.07),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            height: size.height * 0.01,
                                            width: size.width * 0.02,
                                            decoration: BoxDecoration(
                                              color: Colors
                                                  .green, //Color(0xFF4F5266),
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                            ),
                                          ),
                                          SizedBox(
                                            width: size.width * 0.03,
                                          ),
                                          Expanded(
                                            flex: 25,
                                            child: Text(
                                                "Detailed Pickup Location Location",
                                                style: TextStyle(
                                                    color: Colors.white)),
                                          ),
                                        ],
                                      ),
                                    )),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            //floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
            floatingActionButton: FabCircularMenu(
                alignment: Alignment(-1.05, 0.7),
                ringDiameter: 300,
                animationDuration: Duration(seconds: 1),
                ringColor: Colors.white.withOpacity(0.8),
                fabOpenIcon: Icon(
                  Icons.navigation_sharp,
                  color: Colors.white,
                  size: 30,
                ),
                fabCloseIcon: Icon(
                  Icons.close_rounded,
                  color: Colors.white,
                  size: 30,
                ),
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      MapsProvider.beginMapBoxNavigationFromWinchToCustomer();
                      print("mapbox selected");
                    },
                    child: SvgPicture.asset(
                      "assets/icons/map.svg",
                      height: 50,
                    ),
                  ),
                  Text("Navigate\n       with"),
                  GestureDetector(
                    onTap: () {
                      MapsProvider.launchGMapFromWinchToCustomer();
                      print("Gmaps selected");
                    },
                    child: SvgPicture.asset(
                      "assets/icons/google-maps.svg",
                      height: 50,
                    ),
                  )
                ]),
          ),
          AcceptedServiceSheet(),
        ],
      ),
    );
  }
}

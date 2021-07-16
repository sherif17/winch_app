// import 'dart:async';
// import 'dart:ui';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/painting.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_mapbox_navigation/library.dart';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:provider/provider.dart';
// import 'package:winch_app/models/maps/address.dart';
// import 'package:winch_app/models/maps/direction_details.dart';
// import 'package:winch_app/models/up_comming_requests/get_nearest_clients_model.dart';
// import 'package:winch_app/provider/maps_prepration/maps_provider.dart';
// import 'package:winch_app/provider/maps_prepration/polyLineProvider.dart';
// import 'package:winch_app/provider/upcomming_winch_service/winch_request_provider.dart';
// import 'package:winch_app/screens/dash_board/home/home_components/upcomming_request_pop_up.dart';
// import 'package:winch_app/screens/dash_board/profile/profile_body.dart';
// import 'package:winch_app/services/Maps_Assistants/maps_services.dart';
// import 'package:winch_app/widgets/progress_Dialog.dart';
// import 'home_components/driver_status_header.dart';
// import 'package:flutter/scheduler.dart';
//
// class HomeBody extends StatefulWidget {
//   @override
//   _HomeBodyState createState() => _HomeBodyState();
//   final double size;
//   final Color color;
//   final Widget child;
//   final VoidCallback onPressed;
//
//   const HomeBody({
//     Key key,
//     this.size = 80.0,
//     this.color = Colors.red,
//     this.onPressed,
//     @required this.child,
//   }) : super(key: key);
// }
//
// class _HomeBodyState extends State<HomeBody> with TickerProviderStateMixin {
//   Completer<GoogleMapController> _completerGoogleMap = Completer(); //////
//   final CameraPosition _initialPosition = CameraPosition(
//     target: LatLng(31.2001, 29.9187),
//     zoom: 15.4746,
//   );
//
//   DirectionDetails tripDirectionDetails;
//   String _platformVersion = 'Unknown';
//   String _instruction = "";
//   final _origin = WayPoint(
//       name: "Way Point 1",
//       latitude: 38.9111117447887,
//       longitude: -77.04012393951416);
//   final _stop1 = WayPoint(
//       name: "Way Point 2",
//       latitude: 38.91113678979344,
//       longitude: -77.03847169876099);
//   final _stop2 = WayPoint(
//       name: "Way Point 3",
//       latitude: 38.91040213277608,
//       longitude: -77.03848242759705);
//   final _stop3 = WayPoint(
//       name: "Way Point 4",
//       latitude: 38.909650771013034,
//       longitude: -77.03850388526917);
//   final _stop4 = WayPoint(
//       name: "Way Point 5",
//       latitude: 38.90894949285854,
//       longitude: -77.03651905059814);
//
//   MapBoxNavigation _directions;
//   MapBoxOptions _options;
//
//   bool _isMultipleStop = false;
//   double _distanceRemaining, _durationRemaining;
//   MapBoxNavigationViewController _controller;
//   bool _routeBuilt = false;
//   bool _isNavigating = false;
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     initialize();
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//   }
//
//   // Platform messages are asynchronous, so we initialize in an async method.
//   Future<void> initialize() async {
//     // If the widget was removed from the tree while the asynchronous platform
//     // message was in flight, we want to discard the reply rather than calling
//     // setState to update our non-existent appearance.
//     if (!mounted) return;
//
//     _directions = MapBoxNavigation(onRouteEvent: _onEmbeddedRouteEvent);
//     _options = MapBoxOptions(
//         //initialLatitude: 36.1175275,
//         //initialLongitude: -115.1839524,
//         zoom: 15.0,
//         tilt: 0.0,
//         bearing: 0.0,
//         enableRefresh: false,
//         alternatives: true,
//         voiceInstructionsEnabled: true,
//         bannerInstructionsEnabled: true,
//         allowsUTurnAtWayPoints: true,
//         mode: MapBoxNavigationMode.driving,
//         units: VoiceUnits.imperial,
//         simulateRoute: false,
//         animateBuildRoute: true,
//         longPressDestinationEnabled: true,
//         language: "en");
//
//     String platformVersion;
//     // Platform messages may fail, so we use a try/catch PlatformException.
//     try {
//       platformVersion = await _directions.platformVersion;
//     } on PlatformException {
//       platformVersion = 'Failed to get platform version.';
//     }
//
//     setState(() {
//       _platformVersion = platformVersion;
//     });
//   }
//
//   @override
//   Widget build(BuildContext ctx) {
//     Size size = MediaQuery.of(context).size;
//     double WIDTH = double.maxFinite;
//     return Consumer3<MapsProvider, WinchRequestProvider, PolyLineProvider>(
//       builder: (context, MapsProvider, WinchRequestProvider, PolyLineProvider,
//               child) =>
//           Scaffold(
//         body: SafeArea(
//           child: Stack(
//             clipBehavior: Clip.hardEdge,
//             children: [
//               Column(children: <Widget>[
//                 Expanded(
//                   child: SingleChildScrollView(
//                     child: Column(
//                       children: [
//                         SizedBox(
//                           height: 10,
//                         ),
//                         Text('Running on: $_platformVersion\n'),
//                         Container(
//                           color: Colors.grey,
//                           width: double.infinity,
//                           child: Padding(
//                             padding: EdgeInsets.all(10),
//                             child: (Text(
//                               "Full Screen Navigation",
//                               style: TextStyle(color: Colors.white),
//                               textAlign: TextAlign.center,
//                             )),
//                           ),
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             ElevatedButton(
//                               child: Text("Start A to B"),
//                               onPressed: () async {
//                                 var wayPoints = <WayPoint>[];
//                                 wayPoints.add(_origin);
//                                 wayPoints.add(_stop1);
//
//                                 await _directions.startNavigation(
//                                     wayPoints: wayPoints,
//                                     options: MapBoxOptions(
//                                         mode: MapBoxNavigationMode
//                                             .drivingWithTraffic,
//                                         simulateRoute: false,
//                                         language: "en",
//                                         units: VoiceUnits.metric));
//                               },
//                             ),
//                             SizedBox(
//                               width: 10,
//                             ),
//                             ElevatedButton(
//                               child: Text("Start Multi Stop"),
//                               onPressed: () async {
//                                 _isMultipleStop = true;
//                                 var wayPoints = <WayPoint>[];
//                                 wayPoints.add(_origin);
//                                 wayPoints.add(_stop1);
//                                 wayPoints.add(_stop2);
//                                 wayPoints.add(_stop3);
//                                 wayPoints.add(_stop4);
//                                 wayPoints.add(_origin);
//
//                                 await _directions.startNavigation(
//                                     wayPoints: wayPoints,
//                                     options: MapBoxOptions(
//                                         mode: MapBoxNavigationMode.driving,
//                                         simulateRoute: true,
//                                         language: "en",
//                                         allowsUTurnAtWayPoints: true,
//                                         units: VoiceUnits.metric));
//                               },
//                             )
//                           ],
//                         ),
//                         Container(
//                           color: Colors.grey,
//                           width: double.infinity,
//                           child: Padding(
//                             padding: EdgeInsets.all(10),
//                             child: (Text(
//                               "Embedded Navigation",
//                               style: TextStyle(color: Colors.white),
//                               textAlign: TextAlign.center,
//                             )),
//                           ),
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             ElevatedButton(
//                               child: Text(_routeBuilt && !_isNavigating
//                                   ? "Clear Route"
//                                   : "Build Route"),
//                               onPressed: _isNavigating
//                                   ? null
//                                   : () {
//                                       if (_routeBuilt) {
//                                         _controller.clearRoute();
//                                       } else {
//                                         var wayPoints = <WayPoint>[];
//                                         wayPoints.add(_origin);
//                                         wayPoints.add(_stop1);
//                                         wayPoints.add(_stop2);
//                                         wayPoints.add(_stop3);
//                                         wayPoints.add(_stop4);
//                                         wayPoints.add(_origin);
//                                         _isMultipleStop = wayPoints.length > 2;
//                                         _controller.buildRoute(
//                                             wayPoints: wayPoints);
//                                       }
//                                     },
//                             ),
//                             SizedBox(
//                               width: 10,
//                             ),
//                             ElevatedButton(
//                               child: Text("Start "),
//                               onPressed: _routeBuilt && !_isNavigating
//                                   ? () {
//                                       _controller.startNavigation();
//                                     }
//                                   : null,
//                             ),
//                             SizedBox(
//                               width: 10,
//                             ),
//                             ElevatedButton(
//                               child: Text("Cancel "),
//                               onPressed: _isNavigating
//                                   ? () {
//                                       _controller.finishNavigation();
//                                     }
//                                   : null,
//                             )
//                           ],
//                         ),
//                         Center(
//                           child: Padding(
//                             padding: EdgeInsets.all(10),
//                             child: Text(
//                               "Long-Press Embedded Map to Set Destination",
//                               textAlign: TextAlign.center,
//                             ),
//                           ),
//                         ),
//                         Container(
//                           color: Colors.grey,
//                           width: double.infinity,
//                           child: Padding(
//                             padding: EdgeInsets.all(10),
//                             child: (Text(
//                               _instruction == null || _instruction.isEmpty
//                                   ? "Banner Instruction Here"
//                                   : _instruction,
//                               style: TextStyle(color: Colors.white),
//                               textAlign: TextAlign.center,
//                             )),
//                           ),
//                         ),
//                         Padding(
//                           padding: EdgeInsets.only(
//                               left: 20.0, right: 20, top: 20, bottom: 10),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: <Widget>[
//                               Row(
//                                 children: <Widget>[
//                                   Text("Duration Remaining: "),
//                                   Text(_durationRemaining != null
//                                       ? "${(_durationRemaining / 60).toStringAsFixed(0)} minutes"
//                                       : "---")
//                                 ],
//                               ),
//                               Row(
//                                 children: <Widget>[
//                                   Text("Distance Remaining: "),
//                                   Text(_distanceRemaining != null
//                                       ? "${(_distanceRemaining * 0.000621371).toStringAsFixed(1)} miles"
//                                       : "---")
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                         Divider()
//                       ],
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   flex: 1,
//                   child: Container(
//                     color: Colors.grey,
//                     child: MapBoxNavigationView(
//                         options: _options,
//                         onRouteEvent: _onEmbeddedRouteEvent,
//                         onCreated:
//                             (MapBoxNavigationViewController controller) async {
//                           //MapsProvider.googleMapController = controller;
//                           // MapsProvider.locatePosition(context);
//                           _controller = controller;
//                           controller.initialize();
//                         }),
//                   ),
//                 )
//               ]),
//
//               // MapBoxNavigationView(
//               //     options: _options,
//               //     onRouteEvent: _onEmbeddedRouteEvent,
//               //     onCreated: (MapBoxNavigationViewController controller) async {
//               //       _controller = controller;
//               //       controller.initialize();
//               //     }),
//
//               // GoogleMap(
//               //   initialCameraPosition: _initialPosition,
//               //   mapType: MapType.normal,
//               //   myLocationButtonEnabled: true,
//               //   myLocationEnabled: true,
//               //   zoomGesturesEnabled: true,
//               //   zoomControlsEnabled: true,
//               //   mapToolbarEnabled: true,
//               //   polylines: PolyLineProvider.polylineSet,
//               //   markers: PolyLineProvider.markersSet,
//               //   circles: PolyLineProvider.circlesSet,
//               //   onMapCreated: (GoogleMapController controller) async {
//               //     _completerGoogleMap.complete(controller);
//               //     MapsProvider.googleMapController = controller;
//               //     MapsProvider.locatePosition(context);
//               //     // WinchRequestProvider.getNearestClientRequestModel =
//               //     //     GetNearestClientRequestModel(
//               //     //         locationLat:
//               //     //             MapsProvider.currentLocation.latitude.toString(),
//               //     //         locationLong: MapsProvider.currentLocation.longitude
//               //     //             .toString());
//               //     //getPlaceDirection(context);
//               //   },
//               // ),
//               /*
//               Align(
//                 alignment: Alignment.topCenter,
//                 child: Container(
//                   height: size.height * 0.4,
//                   width: MediaQuery.of(context).size.width * 1,
//                   decoration: new BoxDecoration(
//                     gradient: new LinearGradient(
//                       end: Alignment.bottomCenter,
//                       begin: Alignment.topCenter,
//                       colors: <Color>[
//                         Colors.white,
//                         Colors.white.withOpacity(0)
//                       ],
//                     ),
//                     borderRadius:
//                         BorderRadiusDirectional.all(Radius.circular(10)),
//                   ),
//                 ),
//               ),
//               Align(
//                 alignment: Alignment.centerLeft,
//                 child: Container(
//                   height: size.height * 0.9,
//                   width: MediaQuery.of(context).size.width * 0.09,
//                   decoration: new BoxDecoration(
//                     gradient: new LinearGradient(
//                       end: Alignment.centerRight,
//                       begin: Alignment.centerLeft,
//                       colors: <Color>[
//                         Colors.white,
//                         Colors.white.withOpacity(0.0)
//                       ],
//                     ),
//                     borderRadius:
//                         BorderRadiusDirectional.all(Radius.circular(10)),
//                   ),
//                 ),
//               ),
//               Align(
//                 alignment: Alignment.centerRight,
//                 child: Container(
//                   height: size.height * 0.9,
//                   width: MediaQuery.of(context).size.width * 0.08,
//                   decoration: new BoxDecoration(
//                     gradient: new LinearGradient(
//                       end: Alignment.centerLeft,
//                       begin: Alignment.centerRight,
//                       colors: <Color>[
//                         Colors.white,
//                         Colors.white.withOpacity(0.0)
//                       ],
//                     ),
//                     borderRadius:
//                         BorderRadiusDirectional.all(Radius.circular(10)),
//                   ),
//                 ),
//               ),
//               Align(
//                 alignment: Alignment.bottomCenter,
//                 child: Container(
//                   height: size.height * 0.13,
//                   width: MediaQuery.of(context).size.width * 1,
//                   decoration: new BoxDecoration(
//                     gradient: new LinearGradient(
//                       end: Alignment.topCenter,
//                       begin: Alignment.bottomCenter,
//                       colors: <Color>[
//                         Colors.white,
//                         Colors.white.withOpacity(0.0)
//                       ],
//                     ),
//                     borderRadius:
//                         BorderRadiusDirectional.all(Radius.circular(10)),
//                   ),
//                 ),
//               ),
//               */
//               DriverStatusHeader(),
//               WinchRequestProvider.CUSTOMER_FOUNDED == true &&
//                       WinchRequestProvider.isPopRequestDataReady == true
//                   ? buildUpCommingRequest(size: size)
//                   : SizedBox(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Future<void> _onEmbeddedRouteEvent(e) async {
//     _distanceRemaining = await _directions.distanceRemaining;
//     _durationRemaining = await _directions.durationRemaining;
//
//     switch (e.eventType) {
//       case MapBoxEvent.progress_change:
//         var progressEvent = e.data as RouteProgressEvent;
//         if (progressEvent.currentStepInstruction != null)
//           _instruction = progressEvent.currentStepInstruction;
//         break;
//       case MapBoxEvent.route_building:
//       case MapBoxEvent.route_built:
//         setState(() {
//           _routeBuilt = true;
//         });
//         break;
//       case MapBoxEvent.route_build_failed:
//         setState(() {
//           _routeBuilt = false;
//         });
//         break;
//       case MapBoxEvent.navigation_running:
//         setState(() {
//           _isNavigating = true;
//         });
//         break;
//       case MapBoxEvent.on_arrival:
//         if (!_isMultipleStop) {
//           await Future.delayed(Duration(seconds: 3));
//           await _controller.finishNavigation();
//         } else {}
//         break;
//       case MapBoxEvent.navigation_finished:
//       case MapBoxEvent.navigation_cancelled:
//         setState(() {
//           _routeBuilt = false;
//           _isNavigating = false;
//         });
//         break;
//       default:
//         break;
//     }
//     setState(() {});
//   }
// }

import 'dart:async';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:winch_app/models/maps/address.dart';
import 'package:winch_app/models/maps/direction_details.dart';
import 'package:winch_app/models/up_comming_requests/get_nearest_clients_model.dart';
import 'package:winch_app/provider/maps_prepration/maps_provider.dart';
import 'package:winch_app/provider/maps_prepration/polyLineProvider.dart';
import 'package:winch_app/provider/upcomming_winch_service/winch_request_provider.dart';
import 'package:winch_app/screens/dash_board/home/home_components/upcomming_request_pop_up.dart';
import 'package:winch_app/screens/dash_board/profile/profile_body.dart';
import 'package:winch_app/services/Maps_Assistants/maps_services.dart';
import 'package:winch_app/widgets/progress_Dialog.dart';
import 'home_components/driver_status_header.dart';
import 'package:flutter/scheduler.dart';

class HomeBody extends StatefulWidget {
  @override
  _HomeBodyState createState() => _HomeBodyState();
  final double size;
  final Color color;
  final Widget child;
  final VoidCallback onPressed;

  const HomeBody({
    Key key,
    this.size = 80.0,
    this.color = Colors.red,
    this.onPressed,
    @required this.child,
  }) : super(key: key);
}

class _HomeBodyState extends State<HomeBody> with TickerProviderStateMixin {
  Completer<GoogleMapController> _completerGoogleMap = Completer(); //////
  final CameraPosition _initialPosition = CameraPosition(
    target: LatLng(31.2001, 29.9187),
    zoom: 15.4746,
  );
  AnimationController _controller;

  DirectionDetails tripDirectionDetails;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
      vsync: this,
      lowerBound: 0.5,
      duration: Duration(seconds: 3),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Timer timer;

  @override
  Widget build(BuildContext ctx) {
    Size size = MediaQuery.of(ctx).size;
    double WIDTH = double.maxFinite;
    return Consumer3<MapsProvider, WinchRequestProvider, PolyLineProvider>(
      builder: (context, MapsProvider, WinchRequestProvider, PolyLineProvider,
              child) =>
          Scaffold(
        body: SafeArea(
          child: Stack(
            clipBehavior: Clip.hardEdge,
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
                onMapCreated: (GoogleMapController controller) async {
                  _completerGoogleMap.complete(controller);
                  MapsProvider.googleMapController = controller;
                  MapsProvider.locatePosition(context);
                  timer = Timer.periodic(Duration(seconds: 5), (timer) async {
                    //val.locatePosition2(context,startMapMarker);
                    MapsProvider.locatePosition(context);
                  });
                  // WinchRequestProvider.getNearestClientRequestModel =
                  //     GetNearestClientRequestModel(
                  //         locationLat:
                  //             MapsProvider.currentLocation.latitude.toString(),
                  //         locationLong: MapsProvider.currentLocation.longitude
                  //             .toString());
                  //getPlaceDirection(context);
                },
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  height: size.height * 0.4,
                  width: MediaQuery.of(context).size.width * 1,
                  decoration: new BoxDecoration(
                    gradient: new LinearGradient(
                      end: Alignment.bottomCenter,
                      begin: Alignment.topCenter,
                      colors: <Color>[
                        Colors.white,
                        Colors.white.withOpacity(0)
                      ],
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
              DriverStatusHeader(),
              WinchRequestProvider.CUSTOMER_FOUNDED == true &&
                      WinchRequestProvider.isPopRequestDataReady == true
                  ? buildUpCommingRequest(size: size, context: context)
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}

import 'dart:async';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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

  @override
  Widget build(BuildContext ctx) {
    Size size = MediaQuery.of(context).size;
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
                  ? buildUpCommingRequest(size: size)
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}

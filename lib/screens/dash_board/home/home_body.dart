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
 // Address pickUpAddress = Address(latitude: 31.20684069999999, longitude: 29.9237711, placeName: null);
 // Address dropOffAddress = Address(latitude: 31.2181232, longitude: 29.9570564, placeName: null);

  DirectionDetails tripDirectionDetails;

  List<LatLng> pLineCoordinates = [];
  Set<Polyline> polylineSet = {};
  Set<Marker> markersSet = {};
  Set<Circle> circlesSet = {};


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
      builder: (context, MapsProvider, WinchRequestProvider, PolyLineProvider, child) => SafeArea(
        child: Scaffold(
          body: Stack(
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
                  await MapsProvider.locatePosition();
                  WinchRequestProvider.getNearestClientRequestModel =
                      GetNearestClientRequestModel(
                          locationLat:
                              MapsProvider.currentLocation.latitude.toString(),
                          locationLong: MapsProvider.currentLocation.longitude
                              .toString());
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
              WinchRequestProvider.CUSTOMER_FOUNDED == true
                  ? buildUpCommingRequest(size: size)
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }




  Future<void> getPlaceDirection(context) async {
    var initialPos =
        Provider.of<MapsProvider>(context, listen: false).currentLocation;
var finalPos =
        Provider.of<MapsProvider>(context, listen: false).customerPickUpLocation;

    var winchLatLng = LatLng(initialPos.latitude, initialPos.longitude);
    var pickUpLatLng = LatLng(finalPos.latitude, finalPos.longitude);

    showDialog(
        context: context,
        builder: (BuildContext context) => ProgressDialog(
            message:
            currentLang == "en" ? "Please wait.." : "انتظر قليلا...."));

    var details = await MapsApiService.obtainPlaceDirectionDetails(
        winchLatLng, pickUpLatLng);

    setState(() {
      tripDirectionDetails = details;
    });

    Navigator.pop(context);

    print("This is Encoded Points ::");
    print(details.encodedPoints);

    PolylinePoints polylinePoints = PolylinePoints();
    List<PointLatLng> decodedPolylinePointsResult =
    polylinePoints.decodePolyline(details.encodedPoints);

    pLineCoordinates.clear();

    if (decodedPolylinePointsResult.isNotEmpty) {
      decodedPolylinePointsResult.forEach((PointLatLng pointLatLng) {
        pLineCoordinates
            .add(LatLng(pointLatLng.latitude, pointLatLng.longitude));
      });
    }
    polylineSet.clear();

    setState(() {
      Polyline polyline = Polyline(
        color: Theme.of(context).primaryColor,
        polylineId: PolylineId("PolylineID"),
        jointType: JointType.round,
        points: pLineCoordinates,
        width: 5,
        startCap: Cap.roundCap,
        endCap: Cap.roundCap,
        geodesic: true,
      );
      polylineSet.add(polyline);
    });

    LatLngBounds latLngBounds;

    if (winchLatLng.latitude > pickUpLatLng.latitude &&
        winchLatLng.longitude > pickUpLatLng.longitude) {
      latLngBounds =
          LatLngBounds(southwest: pickUpLatLng, northeast: winchLatLng);
    } else if (winchLatLng.longitude > pickUpLatLng.longitude) {
      latLngBounds = LatLngBounds(
          southwest: LatLng(winchLatLng.latitude, pickUpLatLng.longitude),
          northeast: LatLng(pickUpLatLng.latitude, winchLatLng.longitude));
    } else if (winchLatLng.latitude > pickUpLatLng.latitude) {
      latLngBounds = LatLngBounds(
          southwest: LatLng(pickUpLatLng.latitude, winchLatLng.longitude),
          northeast: LatLng(winchLatLng.latitude, pickUpLatLng.longitude));
    } else {
      latLngBounds =
          LatLngBounds(southwest: winchLatLng, northeast: pickUpLatLng);
    }

    Provider.of<MapsProvider>(context, listen: false).googleMapController
        .animateCamera(CameraUpdate.newLatLngBounds(latLngBounds, 70));

    String initialPosition = await MapsApiService.searchCoordinateAddress(winchLatLng, context);
    String finalPosition = await MapsApiService.searchCoordinateAddress(pickUpLatLng, context);

    Marker winchLocMarker = Marker(
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
        infoWindow:
        InfoWindow(title: initialPosition, snippet: "Winch location"),
        position: winchLatLng,
        markerId: MarkerId("winchId"));



    Marker pickUpLocMarker = Marker(
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
        infoWindow:
        InfoWindow(title: finalPosition, snippet: "PickUp location"),
        position: pickUpLatLng,
        markerId: MarkerId("pickUpId"));

    setState(() {
      markersSet.add(winchLocMarker);
      markersSet.add(pickUpLocMarker);
    });

    Circle winchLocCircle = Circle(
      fillColor: Colors.blue,
      center: winchLatLng,
      radius: 12.0,
      strokeWidth: 4,
      strokeColor: Colors.blue,
      circleId: CircleId("winchId"),
    );

    Circle pickUpLocCircle = Circle(
      fillColor: Theme.of(context).hintColor,
      center: pickUpLatLng,
      radius: 12.0,
      strokeWidth: 4,
      strokeColor: Theme.of(context).hintColor,
      circleId: CircleId("pickUpId"),
    );

    setState(() {
      circlesSet.add(winchLocCircle);
      circlesSet.add(pickUpLocCircle);
    });
  }
}

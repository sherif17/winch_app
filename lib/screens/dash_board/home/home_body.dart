import 'dart:async';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:winch_app/models/maps/address.dart';
import 'package:winch_app/models/up_comming_requests/get_nearest_clients_model.dart';
import 'package:winch_app/provider/maps_prepration/maps_provider.dart';
import 'package:winch_app/provider/upcomming_winch_service/winch_request_provider.dart';
import 'package:winch_app/screens/request_screens/custom_rect_tween.dart';
import 'package:winch_app/screens/request_screens/hero_dialog_route.dart';
import 'package:winch_app/services/Maps_Assistants/maps_services.dart';
import 'home_components/driver_status_header.dart';
import 'package:flutter/scheduler.dart';

class HomeBody extends StatefulWidget {
  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  Completer<GoogleMapController> _completerGoogleMap = Completer(); //////
  final CameraPosition _initialPosition = CameraPosition(
    target: LatLng(31.2001, 29.9187),
    zoom: 15.4746,
  );

  Address pickUpAddress = Address(
      latitude: 31.20684069999999, longitude: 29.9237711, placeName: null);
  Address dropOffAddress =
      Address(latitude: 31.2181232, longitude: 29.9570564, placeName: null);

  @override
  Widget build(BuildContext ctx) {
    Size size = MediaQuery.of(context).size;
    double WIDTH = double.maxFinite;
    return Consumer2<MapsProvider, WinchRequestProvider>(
      builder: (context, MapsProvider, WinchRequestProvider, child) => SafeArea(
        child: Scaffold(
          body: Stack(
            clipBehavior: Clip.hardEdge,
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
                    onMapCreated: (GoogleMapController controller) async {
                      _completerGoogleMap.complete(controller);
                      MapsProvider.googleMapController = controller;
                      await MapsProvider.locatePosition();
                      await MapsProvider.getAddressNames(
                          pickUpAddress, dropOffAddress, context);
                      WinchRequestProvider.getNearestClientRequestModel =
                          GetNearestClientRequestModel(
                              locationLat: MapsProvider.currentPosition.latitude
                                  .toString(),
                              locationLong: MapsProvider
                                  .currentPosition.longitude
                                  .toString());
                    },
                  ),
                ),
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
              // WinchRequestProvider.CUSTOMER_FOUNDED == true
              //     ?
              //         // Future.delayed(Duration(milliseconds: 50));
              //         // Navigator.of(ctx).push(HeroDialogRoute(builder: (ctx) {
              //         //   return const _AddTodoPopupCard();
              //         // }));
              //
              //     : SizedBox(),
              //RideRequest(),
            ],
          ),
        ),
      ),
    );
  }
}

/// Tag-value used for the add todo popup button.
const String _heroAddTodo = 'add-todo-hero';

class _AddTodoPopupCard extends StatelessWidget {
  /// {@macro add_todo_popup_card}
  const _AddTodoPopupCard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Hero(
          tag: _heroAddTodo,
          createRectTween: (begin, end) {
            return CustomRectTween(begin: begin, end: end);
          },
          child: Material(
            color: Colors.greenAccent,
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const TextField(
                      decoration: InputDecoration(
                        hintText: 'New todo',
                        border: InputBorder.none,
                      ),
                      cursorColor: Colors.white,
                    ),
                    const Divider(
                      color: Colors.white,
                      thickness: 0.2,
                    ),
                    const TextField(
                      decoration: InputDecoration(
                        hintText: 'Write a note',
                        border: InputBorder.none,
                      ),
                      cursorColor: Colors.white,
                      maxLines: 6,
                    ),
                    const Divider(
                      color: Colors.white,
                      thickness: 0.2,
                    ),
                    FlatButton(
                      onPressed: () {},
                      child: const Text('Add'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

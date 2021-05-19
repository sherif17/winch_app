import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:winch_app/models/maps/address.dart';
import 'package:winch_app/provider/maps_prepration/maps_provider.dart';
import 'package:winch_app/provider/maps_prepration/maps_provider.dart';
import 'package:winch_app/provider/maps_prepration/polyLineProvider.dart';
import 'package:winch_app/provider/upcomming_winch_service/winch_request_provider.dart';
import 'package:winch_app/screens/dash_board/home/acceptted_winch_service/accepted_service_map.dart';
import 'package:winch_app/screens/dash_board/home/acceptted_winch_service/acceptted_serivce_sheet.dart';

class buildUpCommingRequest extends StatefulWidget {
  BuildContext context;
  // const buildUpCommingRequest({
  //
  //   Key key,
  //   @required this.size,
  // }) : super(key: key);

  buildUpCommingRequest({this.context, this.size});

  final Size size;

  @override
  _buildUpCommingRequestState createState() => _buildUpCommingRequestState();
}

class _buildUpCommingRequestState extends State<buildUpCommingRequest> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.bottomCenter,
        child: Consumer3<WinchRequestProvider, MapsProvider, PolyLineProvider>(
          builder: (context, WinchRequestProvider, MapsProvider,
                  PolyLineProvider, child) =>
              Container(
            height: widget.size.height * 0.25,
            width: double.infinity,
            margin: EdgeInsets.fromLTRB(widget.size.width * 0.1, 0,
                widget.size.width * 0.1, widget.size.height * 0.05),
            child: Material(
              color: Colors.white,
              elevation: 15,
              borderRadius: BorderRadius.circular(15),
              shadowColor: Theme.of(context).primaryColorLight.withOpacity(0.1),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("New Winch Request"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      PolyLineProvider.tripDirectionDetails.distanceText != null
                          ? Text(PolyLineProvider
                              .tripDirectionDetails.distanceText)
                          : CircularProgressIndicator(),
                      SvgPicture.asset("assets/icons/car.svg",
                          width: widget.size.width * 0.08),
                      TextButton.icon(
                          label: Text("4.9",
                              style: Theme.of(context).textTheme.subtitle1),
                          icon: Icon(
                            Icons.star_half_outlined,
                            size: widget.size.width * 0.05,
                            color: Colors.yellowAccent,
                          )),
                    ],
                  ),
                  Text(PolyLineProvider.tripDirectionDetails.durationText +
                      " away"),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: widget.size.width * 0.07,
                        vertical: widget.size.height * 0.009),
                    child: Divider(
                      color: Colors.grey.withOpacity(0.3),
                      thickness: 2,
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            child: Text("accept".toUpperCase(),
                                style: TextStyle(fontSize: 18)),
                            style: ButtonStyle(
                                padding: MaterialStateProperty.all<EdgeInsets>(
                                    EdgeInsets.all(15)),
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.green),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        side:
                                            BorderSide(color: Colors.green)))),
                            onPressed: () async {
                              // MapsProvider.getPickUpAddress(
                              //     WinchRequestProvider
                              //         .getNearestClientResponseModel
                              //         .nearestRidePickupLocation
                              //         .lat,
                              //     WinchRequestProvider
                              //         .getNearestClientResponseModel
                              //         .nearestRidePickupLocation
                              //         .lng,
                              //     context);
                              // MapsProvider.getDropOffAddress(
                              //     WinchRequestProvider
                              //         .getNearestClientResponseModel
                              //         .nearestRideDistinationLocation
                              //         .lat,
                              //     WinchRequestProvider
                              //         .getNearestClientResponseModel
                              //         .nearestRideDistinationLocation
                              //         .lng,
                              //     context);
                              await WinchRequestProvider.acceptUpcomingRequest(
                                  context);
                              if (WinchRequestProvider.RIDE_ACCEPTED == true) {
                                Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    AcceptedServiceScreen.routeName,
                                    (route) => false);
                              }
                            },
                          ),
                          SizedBox(width: widget.size.width * 0.1),
                          TextButton(
                              child: Text("Decline".toUpperCase(),
                                  style: TextStyle(fontSize: 17.5)),
                              style: ButtonStyle(
                                  padding:
                                      MaterialStateProperty.all<EdgeInsets>(
                                          EdgeInsets.all(15)),
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.red),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          side: BorderSide(
                                              width: 0.7, color: Colors.red)))),
                              onPressed: () {
                                WinchRequestProvider.cancelUpcomingRequest(
                                    widget.context);
                              }),
                        ]),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}

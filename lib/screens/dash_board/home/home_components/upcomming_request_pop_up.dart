import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:winch_app/provider/maps_prepration/maps_provider.dart';
import 'package:winch_app/provider/upcomming_winch_service/winch_request_provider.dart';
import 'package:winch_app/screens/dash_board/home/acceptted_winch_service/acceptted_serivce_sheet.dart';

class buildUpCommingRequest extends StatelessWidget {
  const buildUpCommingRequest({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.bottomCenter,
        child: Consumer2<WinchRequestProvider, MapsProvider>(
          builder: (context, WinchRequestProvider, MapsProvider, child) =>
              Container(
            height: size.height * 0.25,
            width: double.infinity,
            margin: EdgeInsets.fromLTRB(
                size.width * 0.1, 0, size.width * 0.1, size.height * 0.05),
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
                      Text("0.5 KM"),
                      SvgPicture.asset("assets/icons/car.svg",
                          width: size.width * 0.08),
                      TextButton.icon(
                          label: Text("4.9",
                              style: Theme.of(context).textTheme.subtitle1),
                          icon: Icon(
                            Icons.star_half_outlined,
                            size: size.width * 0.05,
                            color: Colors.yellowAccent,
                          )),
                    ],
                  ),
                  Text("10 Min apart"),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.07,
                        vertical: size.height * 0.009),
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
                                WinchRequestProvider.cancelUpcomingRequest();
                              }),
                          SizedBox(width: size.width * 0.1),
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
                            onPressed: () {
                              Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  AcceptedServiceSheet.routeName,
                                  (route) => false);
                              // WinchRequestProvider.acceptUpcomingRequest();
                              // if (WinchRequestProvider.RIDE_ACCEPTED == true) {
                              //
                              // }
                            },
                          )
                        ]),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}

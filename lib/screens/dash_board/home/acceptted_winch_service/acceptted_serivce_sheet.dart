import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:slider_button/slider_button.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:winch_app/provider/maps_prepration/maps_provider.dart';
import 'package:winch_app/provider/upcomming_winch_service/winch_request_provider.dart';

class AcceptedServiceSheet extends StatelessWidget {
  static String routeName = '/AcceptedServiceSheet';
  BuildContext ctx;

  AcceptedServiceSheet(this.ctx);

  void _launchDial(String number) async => await canLaunch("tel:$number")
      ? await launch("tel:$number")
      : throw 'Could not launch tel:$number';
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Consumer2<MapsProvider, WinchRequestProvider>(
        builder: (context, MapsProvider, WinchRequestProvider, child) =>
            DraggableScrollableSheet(
          initialChildSize: 0.1,
          minChildSize: 0.1,
          maxChildSize: 0.32,
          builder: (BuildContext myContext, controller) {
            const colorizeColors = [Colors.white, Colors.white, Colors.grey];

            const colorizeTextStyle = TextStyle(
              fontSize: 30,
              fontFamily: 'Horizon',
              decoration: TextDecoration.none,
            );

            return SingleChildScrollView(
              controller: controller,
              child: Column(
                children: [
                  Stack(
                    // alignment: Alignment.bottomCenter,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.32,
                        decoration: BoxDecoration(
                            color: Color(
                                0xFF4F5266), //Theme.of(context).primaryColorDark,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5),
                              topRight: Radius.circular(5),
                            )),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          // mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height *
                                      0.015),
                              child: Container(
                                height: 6,
                                width: 90,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.6),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: MediaQuery.of(context).size.height *
                                      0.005),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: GestureDetector(
                                        onTap: () {
                                          _launchDial(WinchRequestProvider
                                                  .upcomingRequestResponseModel
                                                  .phoneNumber ??
                                              "0000");
                                        },
                                        child: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.06,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.08,
                                          decoration: new BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle,
                                          ),
                                          child: Icon(
                                            Icons.call,
                                            size: 23,
                                            color: Colors.green,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  //  Text("no"),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top:
                                            MediaQuery.of(context).size.height *
                                                0.01),
                                    child: Expanded(
                                      flex: 5,
                                      child: AnimatedTextKit(
                                        animatedTexts: [
                                          ColorizeAnimatedText(
                                            "${WinchRequestProvider.upcomingRequestResponseModel.carBrand ?? "Car Brand"}-${WinchRequestProvider.upcomingRequestResponseModel.carModel ?? "Model"}",
                                            textStyle: colorizeTextStyle,
                                            colors: colorizeColors,
                                          ),
                                          ColorizeAnimatedText(
                                            'Meet ${WinchRequestProvider.upcomingRequestResponseModel.firstName ?? "FName"} at 2:30',
                                            textStyle: TextStyle(
                                              fontSize: 20,
                                              fontFamily: 'Horizon',
                                              decoration: TextDecoration.none,
                                            ), //colorizeTextStyle,
                                            colors: colorizeColors,
                                          ),
                                        ],
                                        repeatForever: true,
                                        isRepeatingAnimation: true,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Align(
                                      alignment: Alignment.topRight,
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.06,
                                        width:
                                            MediaQuery.of(context).size.height *
                                                0.08,
                                        decoration: new BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(Icons.chat,
                                            size: 23,
                                            color:
                                                Color(0xFF4F5266) //Colors.grey,
                                            ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: MediaQuery.of(context).size.height * 0.1,
                        //right: 5,
                        child: Container(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Theme.of(context).accentColor,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              )),
                          child: Column(
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.03,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                      "${WinchRequestProvider.upcomingRequestResponseModel.firstName ?? "FName"} ${WinchRequestProvider.upcomingRequestResponseModel.lastName ?? "LName"}",
                                      style: TextStyle(
                                          color: Colors.black54,
                                          decoration: TextDecoration.none,
                                          fontSize: 18)),
                                  Stack(
                                    children: [
                                      SvgPicture.asset(
                                          "assets/icons/sport-car.svg",
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.12),
                                      Positioned(
                                        top: 20,
                                        // right: 25,
                                        child: SvgPicture.asset(
                                            "assets/icons/profile.svg",
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.07),
                                      ),
                                    ],
                                  ),
                                  Text(
                                      "${WinchRequestProvider.upcomingRequestResponseModel.carPlates ?? "CarPlates"}",
                                      style: TextStyle(
                                          color: Colors.black54,
                                          decoration: TextDecoration.none,
                                          fontSize: 20)),
                                ],
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.02,
                              ),
                              WinchRequestProvider.DriverARRIVED == false
                                  ? SliderButton(
                                      //dismissible: false,
                                      action: () async {
                                        await WinchRequestProvider
                                            .arrivedToCustomerLocation(ctx);
                                        if (WinchRequestProvider
                                                .DriverARRIVED ==
                                            true) {
                                          print("slided");
                                          await WinchRequestProvider
                                              .startingWinchService(ctx);
                                          // WinchRequestProvider.returnToDashBoard(context);
                                        }

                                        ///Do something here
                                        //Navigator.of(context).pop();
                                      },
                                      label: Text(
                                        "Slide When Arrive To Start Trip",
                                        style: TextStyle(
                                            color: Color(0xff4a4a4a),
                                            fontWeight: FontWeight.w500,
                                            decoration: TextDecoration.none,
                                            fontSize: 15),
                                      ),
                                      icon: Icon(
                                        Icons.arrow_right_alt_rounded,
                                        color: Colors.white,
                                        size: 60,
                                      ),
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
                                      radius: 20,
                                      buttonColor: Colors.green.withOpacity(
                                          0.9), //Color(0xffd60000),
                                      backgroundColor: Colors.grey.withOpacity(
                                          0.2), //Color(0xff534bae),
                                      highlightedColor: Colors.greenAccent,
                                      baseColor: Colors.green,
                                    )
                                  : CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.green,
                                      ),
                                    )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  /*             Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      children: [
                        Column(
                          children: <Widget>[
                            CircleAvatar(
                              radius: 40.0,
                              //backgroundImage: exist ? NetworkImage(profilePhoto) : AssetImage("assets/icons/profile.png"),
                              backgroundImage:
                                  AssetImage("assets/icons/profile.png"),
                              backgroundColor: Theme.of(context).primaryColor,
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.width * 0.05,
                            ),
                            Row(children: [
                              Text(
                                  WinchRequestProvider
                                          .upcomingRequestResponseModel
                                          .firstName ??
                                      "",
                                  style: Theme.of(context).textTheme.subtitle1),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                  WinchRequestProvider
                                          .upcomingRequestResponseModel
                                          .lastName ??
                                      "",
                                  style: Theme.of(context).textTheme.subtitle1),
                            ]),
                          ],
                        ),
                        Expanded(child: Container()),
                      ],
                    ),
                  ),

                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Row(
                    children: [
                      OutlinedButton(
                        onPressed: () {
                          print("call winch driver");
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.phone,
                            color: Theme.of(context).primaryColorDark,
                            size: 26.0,
                          ),
                        ),
                      ),
                      Expanded(child: Container()),
                      OutlinedButton(
                        onPressed: () {
                          print("message winch driver");
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.message,
                            color: Theme.of(context).primaryColorDark,
                            size: 26.0,
                          ),
                        ),
                      ),
                      Expanded(child: Container()),
                      OutlinedButton(
                        onPressed: () {
                          print("Cancel");
                        },
                        child: Padding(
                          padding: EdgeInsets.all(17.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              //Text("Cancel", style: Theme.of(context).textTheme.headline2,),
                              Icon(
                                Icons.close,
                                color: Theme.of(context).primaryColorDark,
                                size: 26.0,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  //Expanded(child: Container()),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: Row(
                        children: [
                          Text(WinchRequestProvider
                                  .upcomingRequestResponseModel.carBrand ??
                              ""),
                          Text(
                            WinchRequestProvider
                                    .upcomingRequestResponseModel.carModel ??
                                "",
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                          Expanded(child: Container()),
                          Text(
                            WinchRequestProvider
                                    .upcomingRequestResponseModel.carPlates ??
                                "",
                            style: Theme.of(context).textTheme.headline2,
                          ),
                          Expanded(child: Container()),
                          Text(
                            "EGP ${WinchRequestProvider.upcomingRequestResponseModel.estimatedFare ?? ""}",
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).accentColor,
                        borderRadius: BorderRadius.circular(5.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black54,
                            blurRadius: 6.0,
                            spreadRadius: 0.5,
                            offset: Offset(0.7, 0.7),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: Row(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05,
                          ),
                          Icon(
                            Icons.location_history,
                            color: Theme.of(context).hintColor,
                          ),
                          //SizedBox(width: MediaQuery.of(context).size.width * 0.2,),
                          //Text("Estimated arrival time", style: Theme.of(context).textTheme.bodyText2,),
                          Expanded(child: Container()),
                          Text(
                            MapsProvider.customerPickUpLocation.placeName ?? "",
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05,
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).accentColor,
                        borderRadius: BorderRadius.circular(5.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black54,
                            blurRadius: 6.0,
                            spreadRadius: 0.5,
                            offset: Offset(0.7, 0.7),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: Row(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05,
                          ),
                          Icon(
                            Icons.location_pin,
                            color: Theme.of(context).hintColor,
                          ),
                          //SizedBox(width: MediaQuery.of(context).size.width * 0.2,),
                          //Text("Estimated arrival time", style: Theme.of(context).textTheme.bodyText2,),
                          Expanded(child: Container()),
                          Text(
                            MapsProvider.customerDropOffLocation.placeName ??
                                "",
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05,
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).accentColor,
                        borderRadius: BorderRadius.circular(5.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black54,
                            blurRadius: 6.0,
                            spreadRadius: 0.5,
                            offset: Offset(0.7, 0.7),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: Row(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05,
                          ),
                          Text(
                            "Estimated arrival time",
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                          //SizedBox(width: MediaQuery.of(context).size.width * 0.2,),
                          Expanded(child: Container()),
                          Text(
                            WinchRequestProvider.upcomingRequestResponseModel
                                    .estimatedTime ??
                                "",
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05,
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).accentColor,
                        borderRadius: BorderRadius.circular(5.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black54,
                            blurRadius: 6.0,
                            spreadRadius: 0.5,
                            offset: Offset(0.7, 0.7),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),

/*
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: Row(
                            children: [
                              SizedBox(
                                height: MediaQuery.of(context).size.height * 0.05,
                              ),
                              Text("Estimated fare", style: Theme.of(context).textTheme.bodyText2,),
                              SizedBox(width: MediaQuery.of(context).size.width * 0.2,),
                              Expanded(child: Container()),
                              Text("EGP $estimatedFare" , style: Theme.of(context).textTheme.bodyText2,),
                              SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
                            ],
                          ),

                          decoration: BoxDecoration(
                            color: Theme.of(context).accentColor,
                            borderRadius: BorderRadius.circular(5.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black54,
                                blurRadius: 6.0,
                                spreadRadius: 0.5,
                                offset: Offset(0.7, 0.7),
                              ),
                            ],
                          ),
                        ),
                      ),

 */

                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: Row(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05,
                          ),
                          Text(
                            "Estimated trip duration to dropOff",
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                          //SizedBox(width: MediaQuery.of(context).size.width * 0.2,),
                          Expanded(child: Container()),
                          Text(
                            WinchRequestProvider.upcomingRequestResponseModel
                                    .estimatedTime ??
                                "",
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05,
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).accentColor,
                        borderRadius: BorderRadius.circular(5.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black54,
                            blurRadius: 6.0,
                            spreadRadius: 0.5,
                            offset: Offset(0.7, 0.7),
                          ),
                        ],
                      ),
                    ),
                  ),*/
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:winch_app/provider/maps_prepration/maps_provider.dart';
import 'package:winch_app/provider/upcomming_winch_service/winch_request_provider.dart';

class AcceptedServiceSheet extends StatelessWidget {
  static String routeName = '/AcceptedServiceSheet';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Consumer2<MapsProvider,WinchRequestProvider>(
        builder: (context, MapsProvider,WinchRequestProvider, child) => DraggableScrollableSheet(
          initialChildSize: 0.3,
          minChildSize: 0.22,
          maxChildSize: 1.0,
          builder: (BuildContext myContext, controller) {
            return SingleChildScrollView(
              controller: controller,
              child: Container(
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: Theme.of(context).accentColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16.0),
                    topRight: Radius.circular(16.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 16.0,
                      spreadRadius: 0.5,
                      offset: Offset(0.7, 0.7),
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 17.0,
                    horizontal: 15.0,
                  ),
                  child: Column(
                    children: [
                      Center(
                        child: Container(
                          height: 6,
                          width: 90,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),

                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),


                      Padding(
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
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.width * 0.05,
                                ),
                                Row(children: [
                                  Text(WinchRequestProvider.acceptingWinchServiceResponseModel.firstName?? "" ,
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(WinchRequestProvider.acceptingWinchServiceResponseModel.lastName ?? "",
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                              Text(
                                WinchRequestProvider.acceptingWinchServiceResponseModel.carBrand?? "" ),
                            Text(WinchRequestProvider.acceptingWinchServiceResponseModel.carModel?? "",
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                              Expanded(child: Container()),
                              Text(
                                WinchRequestProvider.acceptingWinchServiceResponseModel.carPlates?? "",
                                style: Theme.of(context).textTheme.headline2,
                              ),
                              Expanded(child: Container()),
                              Text(
                                "EGP ${WinchRequestProvider.acceptingWinchServiceResponseModel.estimatedFare ?? ""}",
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
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                              ),
                              Icon(
                                Icons.location_history,
                                color: Theme.of(context).hintColor,
                              ),
                              //SizedBox(width: MediaQuery.of(context).size.width * 0.2,),
                              //Text("Estimated arrival time", style: Theme.of(context).textTheme.bodyText2,),
                              Expanded(child: Container()),
                              Text(
                                MapsProvider.customerPickUpLocation.placeName??"",
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
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
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                              ),
                              Icon(
                                Icons.location_pin,
                                color: Theme.of(context).hintColor,
                              ),
                              //SizedBox(width: MediaQuery.of(context).size.width * 0.2,),
                              //Text("Estimated arrival time", style: Theme.of(context).textTheme.bodyText2,),
                              Expanded(child: Container()),
                              Text(
                                MapsProvider.customerDropOffLocation.placeName??"",
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
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
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                              ),
                              Text(
                                "Estimated arrival time",
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                              //SizedBox(width: MediaQuery.of(context).size.width * 0.2,),
                              Expanded(child: Container()),
                              Text(
                                WinchRequestProvider.acceptingWinchServiceResponseModel.estimatedTime??"",
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
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
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                              ),
                              Text(
                                "Estimated trip duration to dropOff",
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                              //SizedBox(width: MediaQuery.of(context).size.width * 0.2,),
                              Expanded(child: Container()),
                              Text(
                                WinchRequestProvider.acceptingWinchServiceResponseModel.estimatedTime??"",
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
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
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

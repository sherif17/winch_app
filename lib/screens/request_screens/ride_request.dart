import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:winch_app/services/Maps_Assistants/maps_services.dart';

class RideRequest extends StatefulWidget {
  @override
  _RideRequestState createState() => _RideRequestState();
}

class _RideRequestState extends State<RideRequest> {

  @override
  Widget build(BuildContext context) {

    double customerLat = 31.20684069999999;
    double customerLng = 29.9237711;
    LatLng customerPosition = LatLng(customerLat, customerLng);

    double destinationLat = 31.2181232;
    double destinationLng = 29.9570564;
    LatLng destinationPosition = LatLng(destinationLat, destinationLng);
    String customerAddress = " ";
    String destinationAddress = " ";

    getAddressNames() async
    {
      customerAddress = await MapsApiService.searchCoordinateAddress(
          customerPosition, context);
      destinationAddress = await MapsApiService.searchCoordinateAddress(
          destinationPosition, context);

      print(customerAddress);
      print(destinationAddress);
    }

    String customerFirstName = "Mohamed";
    String customerLastName = "Mahmoud";
    String estimatedDuration = "25 min" ;
    double estimatedFare = 234.0;
    String estimatedArrivalTime = "12:56";
    String carPlates= "س ن ت 1234";
    String carType= "BMW X6";


    return Padding(

      padding: const EdgeInsets.only(top: 10.0),
      child: DraggableScrollableSheet(
          initialChildSize: 0.4,
          minChildSize: 0.22,
          maxChildSize: 1.0,
          builder: (BuildContext myContext, controller) {
            getAddressNames();
            print(customerAddress);
            print(destinationAddress);
            return SingleChildScrollView(
              controller: controller,
              child: Container(
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: Theme.of(context).accentColor,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(16.0), topRight: Radius.circular(16.0),),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 16.0,
                      spreadRadius: 0.5,
                      offset: Offset(0.7,0.7),
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 17.0, horizontal: 15.0,),
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

                      SizedBox(height: MediaQuery.of(context).size.height * 0.02,),


                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          children: [

                            Column(
                              children: <Widget>[
                                CircleAvatar(
                                  radius: 40.0,
                                  //backgroundImage: exist ? NetworkImage(profilePhoto) : AssetImage("assets/icons/profile.png"),
                                  backgroundImage: AssetImage("assets/icons/profile.png"),
                                  backgroundColor: Theme.of(context).primaryColor,
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context).size.width * 0.05,
                                ),

                                Row(
                                    children: [
                                      Text(customerFirstName,
                                          style:
                                          Theme.of(context).textTheme.subtitle1),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(customerLastName,
                                          style:
                                          Theme.of(context).textTheme.subtitle1),

                                    ]),
                              ],),
                            Expanded(child: Container()),

                          ],),
                      ),

                      SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                      Row(
                        children: [

                          OutlinedButton(
                            onPressed:() {
                              print("call winch driver");
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(Icons.phone, color: Theme.of(context).primaryColorDark, size: 26.0,),
                            ),
                          ),

                          Expanded(child: Container()),


                          OutlinedButton(
                            onPressed:() {
                              print("message winch driver");
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(Icons.message, color: Theme.of(context).primaryColorDark, size: 26.0,),
                            ),
                          ),

                          Expanded(child: Container()),

                          OutlinedButton(
                            onPressed: ()
                            {
                              print("Cancel");
                            },
                            child: Padding(
                              padding: EdgeInsets.all(17.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  //Text("Cancel", style: Theme.of(context).textTheme.headline2,),
                                  Icon(Icons.close, color: Theme.of(context).primaryColorDark, size: 26.0,)
                                ],
                              ),
                            ),
                          ),


                        ],),
                      //Expanded(child: Container()),




                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: Row(
                            children: [
                              Text(carType, style: Theme.of(context).textTheme.bodyText2,),
                              Expanded(child: Container()),
                              Text(carPlates, style: Theme.of(context).textTheme.headline2,),
                              Expanded(child: Container()),
                              Text("EGP $estimatedFare" , style: Theme.of(context).textTheme.bodyText2,),
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
                              ),],
                          ),
                        ),
                      ),

                      SizedBox(height: MediaQuery.of(context).size.height * 0.02,),


                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: Row(
                            children: [
                              SizedBox(
                                height: MediaQuery.of(context).size.height * 0.05,
                              ),
                              Icon(Icons.location_history, color: Theme.of(context).hintColor,),
                              //SizedBox(width: MediaQuery.of(context).size.width * 0.2,),
                              //Text("Estimated arrival time", style: Theme.of(context).textTheme.bodyText2,),
                              Expanded(child: Container()),
                              Text(customerAddress, style: Theme.of(context).textTheme.bodyText2,),
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
                              ),],
                          ),
                        ),
                      ),

                      SizedBox(height: MediaQuery.of(context).size.height * 0.02,),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: Row(
                            children: [
                              SizedBox(
                                height: MediaQuery.of(context).size.height * 0.05,
                              ),
                              Icon(Icons.location_pin, color: Theme.of(context).hintColor,),
                              //SizedBox(width: MediaQuery.of(context).size.width * 0.2,),
                              //Text("Estimated arrival time", style: Theme.of(context).textTheme.bodyText2,),
                              Expanded(child: Container()),
                              Text(destinationAddress, style: Theme.of(context).textTheme.bodyText2,),
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
                              ),],
                          ),
                        ),
                      ),

                      SizedBox(height: MediaQuery.of(context).size.height * 0.02,),



                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: Row(
                            children: [
                              SizedBox(
                                height: MediaQuery.of(context).size.height * 0.05,
                              ),
                              Text("Estimated arrival time", style: Theme.of(context).textTheme.bodyText2,),
                              //SizedBox(width: MediaQuery.of(context).size.width * 0.2,),
                              Expanded(child: Container()),
                              Text(estimatedArrivalTime, style: Theme.of(context).textTheme.bodyText2,),
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
                              ),],
                          ),
                        ),
                      ),

                      SizedBox(height: MediaQuery.of(context).size.height * 0.02,),


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

                      SizedBox(height: MediaQuery.of(context).size.height * 0.02,),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: Row(
                            children: [
                              SizedBox(
                                height: MediaQuery.of(context).size.height * 0.05,
                              ),
                              Text("Estimated trip duration to dropOff", style: Theme.of(context).textTheme.bodyText2,),
                              //SizedBox(width: MediaQuery.of(context).size.width * 0.2,),
                              Expanded(child: Container()),
                              Text(estimatedDuration, style: Theme.of(context).textTheme.bodyText2,),
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



                    ],),
                ),
              ),
            );
          },
      ),

    );
  }
}

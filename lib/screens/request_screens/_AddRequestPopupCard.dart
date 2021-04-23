import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:winch_app/screens/request_screens/hero_dialog_route.dart';
import 'package:winch_app/services/Maps_Assistants/maps_services.dart';

class Earnings extends StatefulWidget {
  @override
  _EarningsState createState() => _EarningsState();
}

class _EarningsState extends State<Earnings> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Earnnings',
            style: TextStyle(
                color: Colors.indigoAccent,
                fontWeight: FontWeight.bold,
                fontSize: 30)),
      ),
      body: Align(
        alignment: Alignment.center,
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(HeroDialogRoute(
              builder: (context) {
                return const _AddRequestPopupCard();
              },
            ));
          },

          child: Hero(
            tag: _heroAddTodo,
            child: SvgPicture.asset(
              "assets/illustrations/Money-back guarantee (1).svg",
              height: size.height * 0.35,
            ),
          ),
        ),
      ),
    );
  }
}




const String _heroAddTodo = 'add-todo-hero';

class _AddRequestPopupCard extends StatelessWidget {
  /// {@macro add_todo_popup_card}
  const _AddRequestPopupCard({Key key}) : super(key: key);

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
    String carPlates= "حهت 1234";
    String carType= "BMW X6";

    getAddressNames();
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Hero(
          tag: _heroAddTodo,
          child: Material(
            color: Theme.of(context).accentColor,
            elevation: 2,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            child: SingleChildScrollView(
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
                        ],),
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
                            SizedBox(width: MediaQuery.of(context).size.width * 0.2,),
                            //Text("Estimated arrival time", style: Theme.of(context).textTheme.bodyText2,),
                            //Expanded(child: Container()),
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
                            Text(carPlates, style: Theme.of(context).textTheme.headline2,),
                            Expanded(child: Container()),
                            Text(carType, style: Theme.of(context).textTheme.bodyText2,),
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
                            SizedBox(width: MediaQuery.of(context).size.width * 0.2,),
                            //Text("Estimated arrival time", style: Theme.of(context).textTheme.bodyText2,),
                            //Expanded(child: Container()),
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
          ),
        ),
      ),
    );
  }
}
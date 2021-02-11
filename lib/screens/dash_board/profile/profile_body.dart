import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:winch_app/screens/login_screens/confirm_user/confirm_body.dart';
import 'package:winch_app/screens/login_screens/otp/componants/navigation_args.dart';
import 'package:winch_app/shared_prefrences/winch_user_model.dart';

class ProfileBody extends StatefulWidget {
  @override
  _ProfileBodyState createState() => _ProfileBodyState();
}

String token;
String ID;
String Fname;
String Lname;
String Phone;
String WinchPlates;
String currentLang;
String WorkingCity;
String profilePhoto;
String email;
String iat;

class _ProfileBodyState extends State<ProfileBody> {
  @override
  void initState() {
    // getCurrentPrefData();
    super.initState();
    loadAllWinchUserData();
  }

  Widget _greenColors() {
    return Positioned(
      top: 0,
      child: Container(
        color: Theme.of(context).primaryColorLight,
        height: 250,
        width: MediaQuery.of(context).size.width,
      ),
    );
  }

  Widget _getInfo(ID, Fname, Lname, Phone, iat, token, profilePhoto, email) {
    bool exist;
    if (profilePhoto != null)
      exist = true;
    else
      exist = false;
    return Positioned(
      top: 75,
      child: Container(
        margin: const EdgeInsets.all(20),
        height: 500,
        width: MediaQuery.of(context).size.width * 0.90,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.9,
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text("Winch Driver information",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  textAlign: TextAlign.end),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.05,
              ),
              Row(
                //crossAxisAlignment: CrossAxisAlignment.,
                children: <Widget>[
                  CircleAvatar(
                    radius: 40.0,
                    backgroundImage: exist
                        ? NetworkImage(profilePhoto)
                        : AssetImage("assets/icons/profile.png"),
                    backgroundColor: Colors.red,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.1,
                  ),
                  Text(Fname,
                      style:
                          TextStyle(fontWeight: FontWeight.w900, fontSize: 20)),
                  SizedBox(
                    width: 5,
                  ),
                  Text(Lname,
                      style:
                          TextStyle(fontWeight: FontWeight.w900, fontSize: 20)),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text("Phone ",
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: Colors.red,
                          fontSize: 15)),
                  SizedBox(
                    width: 10,
                  ),
                  Text(Phone)
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text("Working City",
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: Colors.red,
                          fontSize: 15)),
                  SizedBox(
                    width: 10,
                  ),
                  Text(workingCity)
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text("Winch Plates",
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: Colors.red,
                          fontSize: 15)),
                  SizedBox(
                    width: 10,
                  ),
                  Text(WinchPlates),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text("Current Language",
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: Colors.red,
                          fontSize: 15)),
                  SizedBox(
                    width: 10,
                  ),
                  Text(currentLang),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _userAdress(ID, Fname, Lname, Phone, iat, token, profilePhoto, email) {
    bool exist;
    if (email != null)
      exist = true;
    else
      exist = false;
    return Positioned(
      top: 400,
      child: Container(
        margin: EdgeInsets.all(20),
        height: 1000,
        width: MediaQuery.of(context).size.width * 0.90,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "Detailed Info",
                style: Theme.of(context).textTheme.headline1,
              ),
              SizedBox(
                height: 40,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("User ID",
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: Colors.red,
                          fontSize: 15)),
                  SizedBox(
                    width: 10,
                  ),
                  Text(ID),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Divider(
                color: Colors.grey,
                height: 5,
                thickness: 1,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Email",
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: Colors.red,
                          fontSize: 15)),
                  SizedBox(
                    width: 10,
                  ),
                  Text(exist ? email : "N/A"),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Divider(
                color: Colors.grey,
                height: 5,
                thickness: 1,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("IAT",
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: Colors.red,
                          fontSize: 15)),
                  SizedBox(
                    width: 10,
                  ),
                  Text(iat),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Divider(
                color: Colors.grey,
                height: 5,
                thickness: 1,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Jwt :",
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: Colors.red,
                          fontSize: 12)),
                  SizedBox(
                    width: 5,
                  ),
                  Container(
                      height: 20,
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: Text(
                        token,
                        overflow: TextOverflow.visible,
                        maxLines: null,
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        title: Text(
          "Profile",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30),
        ),
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColorLight,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
        actions: <Widget>[],
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
            ),
            _greenColors(),
            _getInfo(ID, Fname, Lname, Phone, iat, token, profilePhoto, email),
            SizedBox(),
            _userAdress(
                ID, Fname, Lname, Phone, iat, token, profilePhoto, email),
          ],
        ),
      ),
    );
  }

  loadAllWinchUserData() {
    getPrefBackendID().then((value) {
      setState(() {
        ID = value;
      });
    });
    getPrefFirstName().then((value) {
      setState(() {
        Fname = value;
      });
    });
    getPrefLastName().then((value) {
      setState(() {
        Lname = value;
      });
    });
    getPrefPhoneNumber().then((value) {
      setState(() {
        Phone = value;
      });
    });
    getPrefWinchPlates().then((value) {
      setState(() {
        WinchPlates = value;
      });
    });
    getPrefJwtToken().then((value) {
      setState(() {
        token = value;
      });
    });
    getPrefIAT().then((value) {
      setState(() {
        iat = value;
      });
    });
    getPrefCurrentLang().then((value) {
      setState(() {
        currentLang = value;
      });
    });
    getPrefWorkingCity().then((value) {
      setState(() {
        workingCity = value;
      });
    });
    getPrefSocialImage().then((value) {
      setState(() {
        profilePhoto = value;
      });
    });
    getPrefSocialEmail().then((value) {
      setState(() {
        email = value;
      });
    });
  }
}

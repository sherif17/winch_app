import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:winch_app/local_db/winch_driver_info_db.dart';
import 'package:winch_app/localization/localization_constants.dart';
import 'package:winch_app/screens/dash_board/dash_board.dart';
import 'package:winch_app/screens/dash_board/profile/profile_body.dart';
import 'package:winch_app/screens/login_screens/common_widgets/background.dart';
import 'package:winch_app/screens/login_screens/otp/componants/navigation_args.dart';
import 'package:winch_app/shared_prefrences/winch_user_model.dart';
import 'package:winch_app/widgets/borderd_buttons.dart';
import 'package:winch_app/widgets/rounded_button.dart';

import 'components/user_avatar.dart';
import 'confirm_user_form.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

String prefFName = loadFirstNameFromDB();
String prefLName = loadLastNameFromDB();
String prefJwtToken = loadJwtTokenFromDB();
String prefPhone = loadPhoneNumberFromDB();
String winchPlates = loadWinchPlatesFromDB();
String prefWinchPlatesChar = winchPlates.substring(0, 3).trim();
String prefWinchPlatesNum = winchPlates.substring(3).trim();
String currentLang = loadCurrentLangFromDB();
String workingCity = loadWorkingCityFromDB();
//String prefWinchPlates;

class _BodyState extends State<Body> {
  otpNavData otpResponse;

  @override
  void initState() {
    //  getCurrentPrefData();

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    otpResponse = ModalRoute.of(context).settings.arguments;
    return Background(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            prefFName.toUpperCase() + getTranslated(context, "Is That You ?"),
            style: Theme.of(context).textTheme.headline1,
          ),
          UserAvatar(
              imgSrc: 'assets/icons/profile_bordered.svg',
              size: size,
              color: Theme.of(context).primaryColor),
          Text(
            "$prefFName  $prefLName",
            style: Theme.of(context).textTheme.headline2,
          ),
          Text(
            getTranslated(context, "Winch Plates :") + winchPlates.trimRight(),
            style: Theme.of(context).textTheme.headline6,
          ),
          Text(
            getTranslated(context, "Working City"),
            /* workingCity.trim()*/
            style: Theme.of(context).textTheme.headline6,
          ),
          RoundedButton(
              text: getTranslated(context, "Yes, its Me"),
              color: Theme.of(context).primaryColor,
              press: () {
                Map<String, dynamic> decodedToken =
                    JwtDecoder.decode(prefJwtToken);
                setPrefBackendID(decodedToken["_id"]);
                saveBackendIBInDB(decodedToken["_id"]);
                saveVerificationStateInDB(decodedToken["verified"].toString());
                saveIATInDB(decodedToken["iat"].toString());
                setPrefIAT(decodedToken["iat"].toString());
                printAllWinchDriverSavedInfoInDB();
                printAllWinchUserCurrentData();
                Navigator.pushReplacementNamed(context, DashBoard.routeName);
              }),
          borderedRoundedButton(
              text: getTranslated(context, "No, Edit Info"),
              CornerRadius: 10,
              press: () async {
                await buildStepperShowModalBottomSheet(context, size);
                //ConfirmUserForm();
              })
        ],
      ),
    );
  }

  /* _showModalBottomSheet(context, size) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      enableDrag: true,
      builder: (context) =>
          StatefulBuilder(builder: (BuildContext context, setState) {
        return SingleChildScrollView(
          child: Container(
            height: size,
            /*padding:
                EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),*/
            margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: ConfirmUserForm(),
          ),
        );
      }),
    );
  }*/

  void getCurrentPrefData() {
    getPrefFirstName().then((value) {
      setState(() {
        prefFName = value;
      });
    });
    getPrefLastName().then((value) {
      setState(() {
        prefLName = value;
      });
    });
    getPrefPhoneNumber().then((value) {
      setState(() {
        prefPhone = value;
      });
    });
    getPrefWinchPlates().then((value) {
      setState(() {
        winchPlates = value;
        String part2 = value.substring(0, 3).trim();
        String part1 = value.substring(3).trim();
        //String part2 = value.substring(4, 7);
        prefWinchPlatesChar = part2;
        prefWinchPlatesNum = part1;
        print(prefWinchPlatesChar);
        print(prefWinchPlatesNum);
      });
    });
    getPrefJwtToken().then((value) {
      setState(() {
        prefJwtToken = value;
      });
    });
    getPrefCurrentLang().then((value) {
      setState(() {
        currentLang = value;
      });
    });
    getPrefWorkingCity().then((value) {
      workingCity = value;
    });
  }
}

Future buildStepperShowModalBottomSheet(BuildContext context, Size size) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    enableDrag: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return StatefulBuilder(
        builder: (BuildContext context, setState) {
          return Stack(
            // fit: StackFit.expand,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            overflow: Overflow.visible,
            children: [
              Container(
                height: size.height * 0.6,
                /*padding:
                EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),*/
                margin: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: ConfirmUserForm(
                    prefFName,
                    prefLName,
                    prefJwtToken,
                    prefPhone,
                    prefWinchPlatesNum,
                    prefWinchPlatesChar,
                    currentLang,
                    workingCity),
              ),
              Positioned(
                top: size.height * -0.03,
                left: size.width * 0.4,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    // margin: EdgeInsets.symmetric(horizontal: size.width * 0.09),
                    //padding: EdgeInsets.all(30),
                    child: SvgPicture.asset(
                      'assets/icons/profile.svg',
                      height: size.height * 0.1,
                      width: size.width * 0.08,
                      //color: Theme.of(context),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      );
    },
  );
}

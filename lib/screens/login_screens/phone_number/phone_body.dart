import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:winch_app/local_db/winch_driver_info_db.dart';
import 'package:winch_app/localization/localization_constants.dart';
import 'package:winch_app/screens/login_screens/phone_number/phone_form.dart';
import 'package:winch_app/shared_prefrences/winch_user_model.dart';

import 'componants/country_code_field.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String phoneNumber = "";
  String currentLang = loadCurrentLangFromDB();

  @override
  void initState() {
    super.initState();
    // getCurrentPrefData();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: size.height * 0.1,
              right: size.width * 0.03,
              left: size.width * 0.03,
            ),
            child: Align(
              alignment: currentLang == "en"
                  ? Alignment.centerLeft
                  : Alignment.centerRight,
              child: Text(getTranslated(context, 'Enter Mobile Number:'),
                  style: Theme.of(context).textTheme.headline1),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              right: size.width * 0.05,
              left: size.width * 0.05,
            ),
            child: Align(
              alignment: currentLang == "en"
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
              child: SvgPicture.asset(
                "assets/illustrations/undraw_confirmed_81ex.svg",
                height: size.height * 0.08,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: size.width * 0.05,
                top: size.height * 0.04,
                right: size.width * 0.05),
            child: Text(
              getTranslated(context,
                  'Enter your mobile number ,to create an account or to log in to existing one.'),
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          SizedBox(
            height: size.height * 0.05,
          ),
          PhoneForm(),
        ],
      ),
    );
  }
}

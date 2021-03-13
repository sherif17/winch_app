import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:winch_app/localization/localization_constants.dart';
import 'package:winch_app/screens/login_screens/user_register/register_body.dart';

class RegisterNewUser extends StatelessWidget {
  static String routeName = '/RegisterNewUser';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          getTranslated(context, "Register New Winch Driver"),
          style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w900,
              color: Theme.of(context).primaryColorDark),
        ),
      ),
      body: Body(),
    );
  }
}
// Helped Resources https://youtu.be/ExKYjqgswJg

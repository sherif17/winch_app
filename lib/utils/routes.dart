import 'package:flutter/widgets.dart';
import 'package:winch_app/screens/home_screen/nav_bar/home.dart';
import 'package:winch_app/screens/login_screens/confirm_user/confirm_is_that_user.dart';
import 'package:winch_app/screens/login_screens/file_upload/main_stepper.dart';
import 'package:winch_app/screens/login_screens/otp/phone_verification.dart';
import 'package:winch_app/screens/login_screens/phone_number/enter_phone_number.dart';
import 'package:winch_app/screens/login_screens/user_register/register_new_user.dart';
import 'package:winch_app/screens/onboarding_screens/intro_screens/intro.dart';

final Map<String, WidgetBuilder> routes = {
  Intro.routeName: (context) => Intro(),
  EnterPhoneNumber.routeName: (context) => EnterPhoneNumber(),
  VerifyPhoneNumber.routeName: (context) => VerifyPhoneNumber(),
  ConfirmThisUser.routeName: (context) => ConfirmThisUser(),
  RegisterNewUser.routeName: (context) => RegisterNewUser(),
  HomeScreen.routeName: (context) => HomeScreen(),
  MainStepper.routeName: (context) => MainStepper(),
};

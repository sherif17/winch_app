import 'package:flutter/material.dart';
import 'package:winch_app/screens/login_screens/file_upload/lang_model.dart';
import 'package:winch_app/screens/login_screens/file_upload/stepper_body.dart';

class MainStepper extends StatelessWidget {
  static String routeName = '/FilesStepper';

  @override
  Widget build(BuildContext context) {
    LangModel res = ModalRoute.of(context).settings.arguments;
    return Scaffold(body: StepperBody(res.language));
  }
}

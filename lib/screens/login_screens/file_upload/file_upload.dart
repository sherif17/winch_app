import 'package:flutter/material.dart';
import 'package:winch_app/screens/login_screens/file_upload/stepper_body.dart';

class FileUpload extends StatelessWidget {
  static String routeName = '/fileUpload';

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: StepperBody());
  }
}

import 'package:flutter/material.dart';
import 'package:winch_app/utils/size_config.dart';

import 'intro_body.dart';

class Intro extends StatelessWidget {
  static String routeName = '/intro';
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: IntroBody(),
    );
  }
}

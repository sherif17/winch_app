import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:winch_app/localization/localization_constants.dart';
import 'package:winch_app/shared_prefrences/winch_user_model.dart';

class OrDivider extends StatefulWidget {
  @override
  _OrDividerState createState() => _OrDividerState();
}

class _OrDividerState extends State<OrDivider> {
  String currentLang;

  @override
  void initState() {
    super.initState();
    getCurrentPrefData();
  }

  void getCurrentPrefData() {
    getPrefCurrentLang().then((value) {
      setState(() {
        currentLang = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: size.height * 0.02),
      width: size.width * 0.8,
      child: Row(
        children: <Widget>[
          buildExpanded(context),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(getTranslated(context, "OR")),
          ),
          buildExpanded(context),
        ],
      ),
    );
  }

  Expanded buildExpanded(BuildContext context) {
    return Expanded(
      child: Divider(
        color: Theme.of(context).primaryColor,
        height: 1.5,
        thickness: 2.5,
      ),
    );
  }
}

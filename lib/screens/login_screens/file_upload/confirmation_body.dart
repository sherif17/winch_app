import 'package:flutter/material.dart';
import 'confirmationcode.dart';

class Body extends StatelessWidget {
  final bool islogin = false;
  final otpInput = InputDecoration(
      contentPadding: const EdgeInsets.symmetric(vertical: 40),
      counter: Offstage(),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.black),
      ));
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          buildTimer(),
          confirmationcode(),
        ],
      ),
    );
  }

  Row buildTimer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("This code Will Expire in "),
        TweenAnimationBuilder(
          tween: Tween(begin: 40.0, end: 0.0),
          duration: Duration(seconds: 30),
          builder: (context, value, child) => Text(
            "00:${value.toInt()}",
            style: Theme.of(context).textTheme.headline4,
          ),
          onEnd: () {},
        ),
      ],
    );
  }
}

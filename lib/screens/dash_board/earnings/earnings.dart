import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


class Earnings extends StatefulWidget {
  @override
  _EarningsState createState() => _EarningsState();
}

class _EarningsState extends State<Earnings> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Earnings',
            style: TextStyle(
                color: Colors.indigoAccent,
                fontWeight: FontWeight.bold,
                fontSize: 30)),
      ),
      body: Align(
        alignment: Alignment.center,
            child: SvgPicture.asset(
              "assets/illustrations/Money-back guarantee (1).svg",
              height: size.height * 0.35,
            ),
      ),
    );
  }
}

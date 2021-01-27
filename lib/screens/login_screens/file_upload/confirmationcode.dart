import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class confirmationcode extends StatefulWidget {
  const confirmationcode({
    Key key,
  }) : super(key: key);

  @override
  _confirmationcode createState() => _confirmationcode();
}

class _confirmationcode extends State<confirmationcode> {
  FocusNode pin2FocusNode;
  FocusNode pin3FocusNode;
  FocusNode pin4FocusNode;
  FocusNode pin5FocusNode;
  FocusNode pin6FocusNode;

  @override
  void initState() {
    super.initState();
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();
    pin5FocusNode = FocusNode();
    pin6FocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    pin2FocusNode.dispose();
    pin3FocusNode.dispose();
    pin4FocusNode.dispose();
    pin5FocusNode.dispose();
    pin6FocusNode.dispose();
  }

  void nextField(String value, FocusNode focusNode) {
    if (value.length == 1) {
      focusNode.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Form(
      child: Column(
        children: [
          SizedBox(height: size.height * 0.08),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              children: [
                SizedBox(
                  width: size.width * 0.13,
                  child: TextFormField(
                    autofocus: true,
                    //obscureText: true,
                    style: TextStyle(fontSize: 24),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: otpInputDecoration,
                    onChanged: (value) {
                      nextField(value, pin2FocusNode);
                    },
                  ),
                ),
                SizedBox(
                  width: size.width * 0.13,
                  child: TextFormField(
                    focusNode: pin2FocusNode,
                    //  obscureText: true,
                    style: TextStyle(fontSize: 24),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: otpInputDecoration,
                    onChanged: (value) => nextField(value, pin3FocusNode),
                  ),
                ),
                SizedBox(
                  width: size.width * 0.13,
                  child: TextFormField(
                    focusNode: pin3FocusNode,
                    //  obscureText: true,
                    style: TextStyle(fontSize: 24),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: otpInputDecoration,
                    onChanged: (value) => nextField(value, pin4FocusNode),
                  ),
                ),
                SizedBox(
                  width: size.width * 0.13,
                  child: TextFormField(
                    focusNode: pin4FocusNode,
                    //  obscureText: true,
                    style: TextStyle(fontSize: 24),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: otpInputDecoration,
                    onChanged: (value) => nextField(value, pin5FocusNode),
                  ),
                ),
                SizedBox(
                  width: size.width * 0.13,
                  child: TextFormField(
                    focusNode: pin5FocusNode,
                    //  obscureText: true,
                    style: TextStyle(fontSize: 24),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: otpInputDecoration,
                    onChanged: (value) => nextField(value, pin6FocusNode),
                  ),
                ),
                SizedBox(
                  width: size.width * 0.13,
                  child: TextFormField(
                    focusNode: pin6FocusNode,
                    // obscureText: true,
                    style: TextStyle(fontSize: 24),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: otpInputDecoration,
                    onChanged: (value) {
                      if (value.length == 1) {
                        pin6FocusNode.unfocus();
                        // Then you need to check is the code is correct or not
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: size.height * 0.13),
        ],
      ),
    );
  }
}

final otpInputDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 30),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(20),
    borderSide: BorderSide(color: Colors.blue),
  );
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CompleteProfile extends StatefulWidget {
  GlobalKey<FormState> firstStepFormKey = GlobalKey<FormState>();
  CompleteProfile({this.firstStepFormKey});
  @override
  _CompleteProfileState createState() => _CompleteProfileState();
}

class _CompleteProfileState extends State<CompleteProfile> {
  final charPlatController = TextEditingController();
  final numPlatController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    charPlatController.dispose();
    numPlatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.01,
              bottom: MediaQuery.of(context).size.height * 0.03),
          child: Text(
            "Complete Your Profile",
            style: Theme.of(context).textTheme.headline2,
          ),
        ),
        Form(
          key: widget.firstStepFormKey,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: BuildCharPlateTextFormField(),
                  ),
                  Expanded(child: BuildNumPlateTextFormField()),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  static final translators = {'#': new RegExp(r'(?<!^)(\B|b)(?!$)')};
  var maskFormatter = new MaskTextInputFormatter(
      filter: {'A': new RegExp(r'(?<!^)(\B|b)(?!$)')});
  var controller =
      new MaskedTextController(mask: '000.000.000-00', translator: translators);

  TextFormField BuildCharPlateTextFormField() {
    return TextFormField(
      //maxLength: 3,
      controller: charPlatController,
      inputFormatters: [
        FilteringTextInputFormatter.deny(new RegExp(r'(?<!^)(\B|b)(?!$)'))
      ],
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
        labelText: "Characters",
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueAccent, width: 2),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10), topLeft: Radius.circular(10)),
        ),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.blueAccent,
            ),
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10), topLeft: Radius.circular(10))),
        /* errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),*/
      ),
      onChanged: (value) {
        if (value.isNotEmpty) {
          setState(() {
            value = value + "";
          });
        }
      },
    );
  }

  TextFormField BuildNumPlateTextFormField() {
    return TextFormField(
      maxLength: 4,
      controller: numPlatController,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: "Numbers",
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blueAccent,
            width: 2,
          ),
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(10), topRight: Radius.circular(10)),
        ),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.blueAccent,
            ),
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(10),
                topRight: Radius.circular(10))),
      ),
    );
  }
}

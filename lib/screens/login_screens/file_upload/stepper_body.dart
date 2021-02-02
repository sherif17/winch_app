import 'dart:io';
import 'dart:ui';
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:winch_app/screens/login_screens/file_upload/confirmationcode.dart';
import 'package:winch_app/widgets/rounded_button.dart';

class StepperBody extends StatefulWidget {
  @override
  _StepperBodyState createState() => _StepperBodyState();
}

class _StepperBodyState extends State<StepperBody> {
  final _firstStepFormKey = GlobalKey<FormState>();
  final charPlatController = TextEditingController();
  final numPlatController = TextEditingController();
  File file;
  String title = 'Stepper';
  int _currentstep = 0;

  Future pickCamera() async {
    final myfile = await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      if (myfile != null) {
        file = File(file.path);
      } else {
        print('No image selected.');
      }
    });
  }

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
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
        height: size.height,
        width: size.width,
        child: Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 5),
          child: Column(
            children: [
              Expanded(
                flex: 17,
                child: Container(
                  child: Stepper(
                    steps: _stepper(),
                    type: StepperType.horizontal,
                    //  physics: ClampingScrollPhysics(),
                    currentStep: this._currentstep,
                    onStepTapped: (step) {
                      setState(() {
                        _currentstep = step;
                      });
                    },
                    controlsBuilder: (BuildContext context,
                        {VoidCallback onStepContinue,
                        VoidCallback onStepCancel}) {
                      return Row(
                        children: <Widget>[
                          Container(
                            child: null,
                          ),
                          Container(
                            child: null,
                          ),
                        ],
                      );
                    },
                    /* onStepContinue: () {
                      setState(() {
                        if (this._currentstep < _stepper().length - 1) {
                          this._currentstep = this._currentstep + 1;
                        } else {
                          print('complete');
                        }
                      });
                    },*/
                    /* onStepCancel: () {
                      setState(() {
                        if (this._currentstep > 0) {
                          this._currentstep = this._currentstep - 1;
                        } else {
                          this._currentstep = 0;
                        }
                      });
                    },*/
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: RoundedButton(
                  text: "Next",
                  color: Theme.of(context).primaryColor,
                  textColor: Theme.of(context).accentColor,
                  press: () {
                    print(_currentstep + 1);

                    setState(() {
                      if (this._currentstep < _stepper().length - 1) {
                        this._currentstep = this._currentstep + 1;
                      } else {
                        print('complete');
                      }
                    });
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  List<Step> _stepper() {
    List<Step> _steps = [
      Step(
        title: Text(""),
        content: Column(
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
              key: _firstStepFormKey,
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
        ),
        isActive: true,
        state: StepState.indexed,
      ),
      Step(
        title: Text(""),
        content: Column(
          children: <Widget>[
            SingleChildScrollView(
              child: Container(
                  //_BuildListPanel(),
                  child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.01,
                        bottom: MediaQuery.of(context).size.height * 0.03),
                    child: Text(
                      "Upload Required Files",
                      style: Theme.of(context).textTheme.headline2,
                    ),
                  ),
                  BuildFileUpload('Personal Photo', "Please upload clear photo",
                      "assets/icons/profile.png", true),
                  BuildFileUpload(
                      'Driver License',
                      "Please upload your licence ",
                      "assets/icons/profile.png",
                      true),
                  BuildFileUpload(
                      'Winch License : Front',
                      "upload your winch licence,front image",
                      "assets/icons/profile.png",
                      true),
                  BuildFileUpload(
                      'Winch License : Back ',
                      "upload your winch licence,back image",
                      "assets/icons/profile.png",
                      true),
                  BuildFileUpload(
                      'Criminal Record',
                      "upload Criminal record about you",
                      "assets/icons/profile.png",
                      true),
                  BuildFileUpload(
                      'Drugs Analysis',
                      "upload Drug analysis report form X Laboratory",
                      "assets/icons/profile.png",
                      true),
                  BuildFileUpload(
                      'Winch Check Report',
                      "upload your winch check Report,from X Center",
                      "assets/icons/profile.png",
                      true)
                ],
              )),
            ),
          ],
        ),
        isActive: _currentstep >= 2,
        state: StepState.indexed,
      ),
      Step(
        title: Text(""),
        content: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                top: 80.0,
                left: 10.0,
                bottom: 20.0,
              ),
              child: Text(
                'Please Enter Your Confirmation Code Provided by the administration',
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 0.5),
              child: Text(
                'These process of confirmation may take from 1 to 3 weeks to check your files',
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
            confirmationcode(),
          ],
        ),
        isActive: _currentstep >= 3,
        state: StepState.indexed,
      ),
      Step(
          title: Text(""),
          content: Column(
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.only(top: 60.0, left: 10.0, bottom: 10.0),
                child: Text(
                  'Please Watch this Tutorial How to use our App to start Earring Money',
                  style: Theme.of(context).textTheme.headline1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 50.0,
                  left: 10.0,
                ),
                child: Container(
                  height: 250.0,
                  width: 380.0,
                  decoration: BoxDecoration(
                      border:
                          Border.all(color: Theme.of(context).primaryColorDark),
                      color: Theme.of(context).accentColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      )),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 30.0, top: 20.0),
                    child: Container(
                      child: FlatButton(
                        onPressed: () {
                          /*...*/
                        },
                        child: Image.asset('assets/new.png'),
                        height: 60.0,
                        minWidth: 60.0,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          isActive: _currentstep >= 4,
          state: StepState.indexed),
    ];
    return _steps;
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

  Card BuildFileUpload(title, content, imgSrc, isExpanded) {
    bool x = false;
    return Card(
      elevation: 0,
      semanticContainer: true,
      shape: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: Theme.of(context).primaryColorDark),
          gapPadding: 100),
      borderOnForeground: true,
      margin: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.01,
      ),
      child: ExpansionTile(
        title: Text(title, style: Theme.of(context).textTheme.headline2),
        backgroundColor: Theme.of(context).accentColor,
        //trailing: Icon(x ? Icons.copyright_rounded : Icons.height),
        children: [
          Container(
            color: Theme.of(context).accentColor,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                        flex: 3,
                        child: Padding(
                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.04),
                            child: Text(
                              content,
                              style: TextStyle(
                                  color: Colors.deepOrangeAccent, fontSize: 17),
                            ))),
                    Expanded(
                        flex: 1,
                        child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Image.asset(imgSrc)))
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.25),
                  child: FlatButton(
                      height: MediaQuery.of(context).size.height *
                          0.05, //minWidth: MediaQuery.of(context).size.width * 0.05,
                      color: Theme.of(context).primaryColorDark,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Upload"),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.03),
                          SvgPicture.asset(
                            "assets/icons/upload-cloud.svg",
                            color: Theme.of(context).accentColor,
                            width: MediaQuery.of(context).size.width * 0.035,
                            height: MediaQuery.of(context).size.height * 0.03,
                          )
                        ],
                      ),
                      onPressed: pickCamera),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Item {
  String expandedValue;
  String headerValue;
  bool isExpanded;
  Item({this.expandedValue, this.headerValue, this.isExpanded = false});
}

List<Item> generateItems(int numOfItems) {
  return List.generate(numOfItems, (index) {
    return Item(
      headerValue: "Panel $index",
      expandedValue: "this is item number $index",
    );
  });
}

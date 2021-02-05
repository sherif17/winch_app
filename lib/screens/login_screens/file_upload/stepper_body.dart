import 'dart:io';
import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:winch_app/screens/login_screens/file_upload/step_four/watch_tutorial.dart';
import 'package:winch_app/screens/login_screens/file_upload/step_one/complete_profile.dart';
import 'package:winch_app/screens/login_screens/file_upload/step_three/confirmation_body.dart';
import 'package:winch_app/screens/login_screens/file_upload/step_two/required_files.dart';
import 'package:winch_app/shared_prefrences/winch_user_model.dart';
import 'package:winch_app/widgets/rounded_button.dart';

class StepperBody extends StatefulWidget {
  @override
  _StepperBodyState createState() => _StepperBodyState();
}

class _StepperBodyState extends State<StepperBody> {
  GlobalKey<FormState> firstStepFormKey = GlobalKey<FormState>();
  // String title = 'Stepper';
  int _currentstep = 0;
  List<String> filesList = List<String>();
  List<String> filesPathList = List<String>();
  File personalPhoto;
  File driverLicense;
  File winchLicenseFront;
  File winchLicenseBack;
  File criminalRecord;
  File drugsAnalysis;
  File winchCheckReport;
  FormData formData;

  uploadAllFiles() async {
    formData = FormData();
    for (int img = 0; img < filesPathList.length; img++) {
      formData.files.addAll([
        MapEntry(
            "DriverImages",
            await MultipartFile.fromFile(this.filesPathList[img],
                filename: filesList[img])),
      ]);
      //print(formData.files);
    }
    return formData;
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
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: RoundedButton(
                  text: "Next",
                  color: Theme.of(context).primaryColor,
                  textColor: Theme.of(context).accentColor,
                  press: () async {
                    print("current lang: ${await getPrefCurrentLang()}");
                    //print(_currentstep + 1);
                    // print(formData.files);
                    setState(() {
                      if (this._currentstep < _stepper().length - 1) {
                        this._currentstep = this._currentstep + 1;
                        print(filesList.length);
                        for (int i = 0; i < filesList.length; i++) {
                          if (i == 0)
                            print(
                                'personalPhoto : ${filesList[i]},${filesPathList[i]}');
                          if (i == 1) print('driverLicense : ${filesList[i]}');
                          if (i == 2)
                            print('winchLicenseFront : ${filesList[i]}');
                          if (i == 3)
                            print('winchLicenseBack : ${filesList[i]}');
                          if (i == 4) print('criminalRecord : ${filesList[i]}');
                          if (i == 5) print('drugsAnalysis : ${filesList[i]}');
                          if (i == 6)
                            print('winchCheckReport : ${filesList[i]}');
                        }
                        print(uploadAllFiles());
                      } else {}
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
      ////////////////////Step 1//////////////////
      Step(
        title: Text(""),
        content: CompleteProfile(firstStepFormKey: this.firstStepFormKey),
        isActive: true,
        state: StepState.indexed,
      ),
      ////////////////////Step 2//////////////////
      Step(
        title: Text(""),
        content: SingleChildScrollView(
            child: RequiredFiles(
                filesList: this.filesList,
                filesPathList: this.filesPathList,
                personalPhoto: this.personalPhoto,
                driverLicense: this.driverLicense,
                winchLicenseFront: this.winchLicenseFront,
                winchLicenseBack: this.winchLicenseBack,
                criminalRecord: this.criminalRecord,
                drugsAnalysis: this.drugsAnalysis,
                winchCheckReport: this.winchCheckReport)),
        isActive: _currentstep >= 2,
        state: StepState.indexed,
      ),
      ////////////////////Step 3//////////////////
      Step(
        title: Text(""),
        content: ConfirmationBody(),
        isActive: _currentstep >= 3,
        state: StepState.indexed,
      ),
      ////////////////////Step 4//////////////////
      Step(
          title: Text(""),
          content: WatchTutorial(),
          isActive: _currentstep >= 4,
          state: StepState.indexed),
    ];
    return _steps;
  }
}
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

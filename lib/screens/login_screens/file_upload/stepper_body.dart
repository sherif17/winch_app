import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:winch_app/models/files_upload_model.dart';
import 'package:winch_app/models/user_register_model.dart';
import 'package:winch_app/screens/dash_board/dash_board.dart';
import 'package:winch_app/screens/login_screens/file_upload/step_four/watch_tutorial.dart';
import 'package:winch_app/screens/login_screens/file_upload/step_one/complete_profile.dart';
import 'package:winch_app/screens/login_screens/file_upload/step_three/confirmation_body.dart';
import 'package:winch_app/screens/login_screens/file_upload/step_two/required_files.dart';
import 'package:winch_app/screens/login_screens/otp/componants/progress_bar.dart';
import 'package:winch_app/services/api_services.dart';
import 'package:winch_app/shared_prefrences/winch_user_model.dart';
import 'package:winch_app/widgets/rounded_button.dart';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;

class StepperBody extends StatefulWidget {
  @override
  _StepperBodyState createState() => _StepperBodyState();
}

class _StepperBodyState extends State<StepperBody> {
  GlobalKey<FormState> firstStepFormKey = GlobalKey<FormState>();
  WinchRegisterRequestModel winchRegisterRequestModel;
  String charPlate;
  String numPlate;
  String JwtToken;
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
  bool isApiCallProcess = false;
  @override
  void initState() {
    super.initState();
    winchRegisterRequestModel = new WinchRegisterRequestModel();
  }

  uploadAllFiles() async {
    formData = FormData();
    for (int img = 0; img < filesPathList.length; img++) {
      formData.files.addAll([
        MapEntry(
            "DriverImages",
            MultipartFile.fromFileSync(this.filesPathList[img],
                filename: filesList[img],
                contentType: new MediaType("image", "jpg"))),
      ]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      child: completeProfile_build(context),
      inAsyncCall: isApiCallProcess,
      opacity: 0.5,
      color: Theme.of(context).primaryColorLight,
    );
  }

  @override
  Widget completeProfile_build(BuildContext context) {
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
                    text: _currentstep == 3 ? "Let's Start" : "Next",
                    color: Theme.of(context).primaryColor,
                    textColor: Theme.of(context).accentColor,
                    press: () async {
                      print("current lang: ${await getPrefCurrentLang()}");
                      String currentLang = await getPrefCurrentLang();
                      String currentJwtToken = await getPrefJwtToken();
                      print(currentLang);
                      print(currentJwtToken);
                      //print(_currentstep + 1);
                      // print(formData.files);
                      print(_currentstep);
                      if (_currentstep == 0) {
                        if (completeProfileValidateAndSave()) {
                          setState(() {
                            isApiCallProcess = true;
                          });
                          setPrefWinchPlates(await getPrefWinchPlatesChars() +
                              await getPrefWinchPlatesNum());
                          winchRegisterRequestModel.firstName =
                              await getPrefFirstName();
                          winchRegisterRequestModel.lastName =
                              await getPrefLastName();
                          winchRegisterRequestModel.winchPlates =
                              await getPrefWinchPlates();
                          winchRegisterRequestModel.governorate =
                              await getPrefWorkingCity();
                          print(
                              "Request body: ${winchRegisterRequestModel.toJson()}.");
                          ApiService apiService = new ApiService();
                          apiService
                              .registerUser(winchRegisterRequestModel,
                                  currentJwtToken, currentLang)
                              .then((value) {
                            if (value != null) {
                              // setPrefJwtToken(value.token);
                              print(value.token);
                              print(value.error);
                              JwtToken = value.token;
                              setState(() {
                                isApiCallProcess = false;
                                setState(() {
                                  if (this._currentstep <
                                      _stepper().length - 1) {
                                    this._currentstep = this._currentstep + 1;
                                  }
                                });
                              });
                            }
                          });
                        }
                      }
                      //String currentToken = await getPrefJwtToken();
                      else if (_currentstep == 1) {
                        print("new token ${JwtToken}");
                        print(filesList.length);
                        if (filesPathList.length == 7) {
                          setState(() {
                            isApiCallProcess = true;
                          });
                          var headers = {'x-auth-token': JwtToken};
                          var request = http.MultipartRequest(
                              'POST',
                              Uri.parse(
                                  'http://161.97.155.244/api/winchDriver/me/UploadImages'));
                          request.files.add(await http.MultipartFile.fromPath(
                              'DriverImages', filesPathList[0]));
                          request.files.add(await http.MultipartFile.fromPath(
                              'DriverImages', filesPathList[1]));
                          request.files.add(await http.MultipartFile.fromPath(
                              'DriverImages', filesPathList[2]));
                          request.files.add(await http.MultipartFile.fromPath(
                              'DriverImages', filesPathList[3]));
                          request.files.add(await http.MultipartFile.fromPath(
                              'DriverImages', filesPathList[4]));
                          request.files.add(await http.MultipartFile.fromPath(
                              'DriverImages', filesPathList[5]));
                          request.files.add(await http.MultipartFile.fromPath(
                              'DriverImages', filesPathList[6]));
                          request.headers.addAll(headers);
                          http.StreamedResponse response = await request.send();
                          if (response.statusCode == 200) {
                            dynamic jsonResponse =
                                await response.stream.bytesToString();
                            print(jsonResponse);
                            FilesUploadResponseModel value =
                                FilesUploadResponseModel.fromJson(
                                    json.decode(jsonResponse));
                            if (value.token != null) {
                              setState(() {
                                isApiCallProcess = false;
                              });
                              print(value.token);
                              setPrefJwtToken(value.token);
                              Map<String, dynamic> decodedToken =
                                  JwtDecoder.decode((value.token));
                              String responseID = decodedToken["_id"];
                              String responseFName = decodedToken["firstName"];
                              String responseLName = decodedToken["lastName"];
                              String winchPlates = decodedToken["winchPlates"];
                              String governorate = decodedToken["governorate"];
                              String personalPicture =
                                  decodedToken["personalPicture"];
                              String driverLicensePicture =
                                  decodedToken["driverLicensePicture"];
                              String winchLicenseFrontPicture =
                                  decodedToken["winchLicenseFrontPicture"];
                              String winchLicenseRearPicture =
                                  decodedToken["winchLicenseRearPicture"];
                              String driverDrugAnalysisPicture =
                                  decodedToken["driverDrugAnalysisPicture"];
                              String winchCheckReportPicture =
                                  decodedToken["winchCheckReportPicture"];
                              var responseIat = decodedToken["iat"];
                              print(responseID);
                              setPrefBackendID(responseID);
                              print(responseFName);
                              setPrefFirstName(responseFName);
                              print(responseLName);
                              setPrefLastName(responseLName);
                              print(winchPlates);
                              setPrefWinchPlates(winchPlates);
                              print(governorate);
                              setPrefWorkingCity(governorate);
                              print(personalPicture);
                              print(driverLicensePicture);
                              print(winchLicenseFrontPicture);
                              print(winchLicenseRearPicture);
                              print(driverDrugAnalysisPicture);
                              print(winchCheckReportPicture);
                              print(responseIat);
                              setPrefIAT(responseIat.toString());
                              setState(() {
                                isApiCallProcess = false;
                                if (this._currentstep < _stepper().length - 1) {
                                  this._currentstep = this._currentstep + 2;
                                }
                              });
                            } else
                              print("value of token is null");
                          } else
                            print(response.reasonPhrase);
                        }
                      } else
                        Navigator.pushNamed(context, DashBoard.routeName);
                      /* setState(() {
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
                    });*/
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }

  bool completeProfileValidateAndSave() {
    final completeFormKey = firstStepFormKey.currentState;
    if (completeFormKey.validate()) {
      completeFormKey.save();
      return true;
    } else
      return false;
  }

  List<Step> _stepper() {
    List<Step> _steps = [
      ////////////////////Step 1//////////////////
      Step(
        title: Text(""),
        content: CompleteProfile(
          firstStepFormKey: this.firstStepFormKey,
        ),
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

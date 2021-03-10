import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:winch_app/models/user_register_model.dart';
import 'package:winch_app/screens/dash_board/dash_board.dart';
import 'package:winch_app/screens/login_screens/otp/componants/navigation_args.dart';
import 'package:winch_app/screens/login_screens/otp/componants/progress_bar.dart';
import 'package:winch_app/services/api_services.dart';
import 'package:winch_app/shared_prefrences/winch_user_model.dart';
import 'package:winch_app/utils/constants.dart';
import 'package:winch_app/widgets/form_error.dart';
import 'package:winch_app/widgets/rounded_button.dart';

class ConfirmUserForm extends StatefulWidget {
  String prefFName;
  String prefLName;
  String prefJwtToken;
  String prefPhone;
  String prefWinchPlatesNum;
  String prefWinchPlatesChar;
  String prefWinchPlates;
  String currentLang;
  String workingCity;

  ConfirmUserForm(
      this.prefFName,
      this.prefLName,
      this.prefJwtToken,
      this.prefPhone,
      this.prefWinchPlatesNum,
      this.prefWinchPlatesChar,
      this.currentLang,
      this.workingCity);

  @override
  _ConfirmUserFormState createState() => _ConfirmUserFormState();
}

class _ConfirmUserFormState extends State<ConfirmUserForm> {
  final _formKey = GlobalKey<FormState>();
  WinchRegisterRequestModel winchRegisterRequestModel;
  bool isApiCallProcess = false;

  String jwtToken;
  String responseID;
  String responseFName;
  String responseLName;
  int responseIat;
  String responseWinchPlates;
  String responseGovernorate;

  bool FName_Changed = false;
  bool LName_changed = false;
  bool WinchPlateNum_changed = false;
  bool WinchPlateChar_changed = false;

  @override
  void initState() {
    // getCurrentPrefData();
    super.initState();
    winchRegisterRequestModel = new WinchRegisterRequestModel();
  }

  void addError({String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  final List<String> errors = [];
  Widget build(BuildContext context) {
    return ProgressHUD(
      child: confirm_build(context),
      inAsyncCall: isApiCallProcess,
      opacity: 0,
    );
  }

  Widget confirm_build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Form(
      key: _formKey,
      child: Container(
        height: size.height,
        margin: EdgeInsets.only(top: size.height * 0.01, left: 5, right: 5),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: size.height * 0.1,
              width: size.width * 0.6,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              children: [
                SizedBox(
                    height: size.height * 0.1,
                    width: size.width * 0.45,
                    child: DecoratedEditFNameTextField()),
                SizedBox(
                  width: size.width * 0.03,
                ),
                SizedBox(
                    height: size.height * 0.1,
                    width: size.width * 0.45,
                    child: DecoratedEditLNameTextField())
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              children: [
                Expanded(
                  child: BuildCharPlateTextFormField(),
                ),
                Expanded(child: BuildNumPlateTextFormField()),
              ],
            ),
            SizedBox(
                width: size.height * 0.1,
                child: FormError(size: size, errors: errors)),
            SizedBox(
                height: size.height * 0.1,
                width: size.width * 0.5,
                child: DecoratedPhoneTField()),
            RoundedButton(
                text: "Edit my info",
                color: Theme.of(context).primaryColor,
                press: () async {
                  if (confirmValidateAndSave()) {
                    if (FName_Changed == true ||
                        LName_changed == true ||
                        WinchPlateChar_changed == true ||
                        WinchPlateNum_changed == true) {
                      String part1 = await getPrefWinchPlatesNum();
                      String part2 = await getPrefWinchPlatesChars();
                      String newWinchPlates = part1 + part2;
                      winchRegisterRequestModel.governorate =
                          widget.workingCity;
                      winchRegisterRequestModel.winchPlates = newWinchPlates;
                      print(
                          "Request body: ${winchRegisterRequestModel.toJson()}.");
                      print("hii ${widget.prefJwtToken}");
                      setState(() {
                        isApiCallProcess = true;
                      });
                      ApiService apiService = new ApiService();
                      apiService
                          .registerUser(winchRegisterRequestModel,
                              widget.prefJwtToken, widget.currentLang)
                          .then(
                        (value) {
                          if (value.error == null) {
                            jwtToken = value.token;
                            print(jwtToken);
                            setPrefJwtToken(jwtToken);
                            Map<String, dynamic> decodedToken =
                                JwtDecoder.decode(jwtToken);
                            responseID = decodedToken["_id"];
                            setPrefBackendID(responseID);
                            responseFName = decodedToken["firstName"];
                            setPrefFirstName(responseFName);
                            responseLName = decodedToken["lastName"];
                            setPrefLastName(responseLName);
                            responseWinchPlates = decodedToken["winchPlates"];
                            setPrefWinchPlates(responseWinchPlates);
                            responseGovernorate = decodedToken["governorate"];
                            setPrefWorkingCity(responseGovernorate);
                            responseIat = decodedToken["iat"];
                            setPrefIAT(responseIat.toString());
                            setState(() {
                              isApiCallProcess = false;
                            });
                            printAllWinchUserCurrentData();
                            Navigator.pushNamedAndRemoveUntil(
                                context, DashBoard.routeName, (route) => false);
                          } else
                            print(value.error);
                        },
                      );
                    } else {
                      setState(() {
                        Navigator.pop(context);
                      });
                    }
                  } else {
                    print("Validation error");
                  }
                }),
          ],
        ),
      ),
    );
  }

  bool confirmValidateAndSave() {
    final registerFormKey = _formKey.currentState;
    if (registerFormKey.validate()) {
      registerFormKey.save();
      return true;
    } else
      return false;
  }

  TextFormField DecoratedEditFNameTextField() {
    return TextFormField(
      keyboardType: TextInputType.name,
      initialValue: widget.prefFName,
      style: Theme.of(context).textTheme.bodyText2,
      decoration: InputDecoration(
        labelText: 'First Name',
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      onSaved: (newValue) {
        if (newValue != widget.prefFName) {
          FName_Changed = true;
        }
        winchRegisterRequestModel.firstName = newValue;
      },
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: NullFirstNameError);
          removeError(error: SmallFirstNameError);
          return "";
        }
        if (value.length > 1) {
          removeError(error: SmallFirstNameError);
          return "";
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: NullFirstNameError);
          return "";
        } else if (value.length == 1) {
          addError(error: SmallFirstNameError);
          return "";
        }
        return null;
      },
    );
  }

  TextFormField DecoratedEditLNameTextField() {
    return TextFormField(
      keyboardType: TextInputType.name,
      initialValue: widget.prefLName,
      style: Theme.of(context).textTheme.bodyText2,
      decoration: InputDecoration(
        labelText: 'Last Name',
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      onSaved: (newValue) {
        if (newValue != widget.prefLName) {
          LName_changed = true;
          print("two");
        }
        winchRegisterRequestModel.lastName = newValue;
      },
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: NullLastNameError);
          removeError(error: SmallLastNameError);
          return "";
        }
        if (value.length > 1) {
          removeError(error: SmallLastNameError);
          return "";
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: NullLastNameError);
          return "";
        } else if (value.length == 1) {
          addError(error: SmallLastNameError);
          return "";
        }
        return null;
      },
    );
  }

  TextFormField BuildCharPlateTextFormField() {
    return TextFormField(
      maxLength: 3,
      maxLengthEnforced: true,
      initialValue: widget.prefWinchPlatesChar,
      inputFormatters: [
        // FilteringTextInputFormatter.deny(new RegExp(r'(?<!^)(\B|b)(?!$)'))
      ],
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
        labelText: "Characters",
        focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: Theme.of(context).primaryColor, width: 2),
          borderRadius: widget.currentLang == 'en'
              ? BorderRadius.only(
                  bottomLeft: Radius.circular(10), topLeft: Radius.circular(10))
              : BorderRadius.only(
                  bottomRight: Radius.circular(10),
                  topRight: Radius.circular(10)),
        ),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
            ),
            borderRadius: widget.currentLang == 'en'
                ? BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    topLeft: Radius.circular(10))
                : BorderRadius.only(
                    bottomRight: Radius.circular(10),
                    topRight: Radius.circular(10))),
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.redAccent,
            ),
            borderRadius: widget.currentLang == 'en'
                ? BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    topLeft: Radius.circular(10))
                : BorderRadius.only(
                    bottomRight: Radius.circular(10),
                    topRight: Radius.circular(10))),
      ),
      onSaved: (newValue) {
        //firstName = newValue;
        //winchRegisterRequestModel.firstName = newValue;
        // setPrefFirstName(newValue);
        if (newValue != widget.prefWinchPlatesChar) {
          WinchPlateChar_changed = true;
          print("three");
        }

        setPrefWinchPlatesChars(newValue);
      },
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: NullCharPlateError);
          removeError(error: SmallCharPlateError);
          return "";
        }
        if (value.length > 1 && value.length < 3) {
          removeError(error: SmallCharPlateError);
          removeError(error: LargeCharPlateError);
          return "";
        }
        if (value.length > 3) {
          addError(error: LargeCharPlateError);
          return "";
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: NullCharPlateError);
          return "";
        } else if (value.length == 1) {
          addError(error: SmallCharPlateError);
          return "";
        } else if (value.length > 3) {
          addError(error: LargeCharPlateError);
          return "";
        }
        return null;
      },
    );
  }

  TextFormField BuildNumPlateTextFormField() {
    return TextFormField(
      maxLength: 4,
      keyboardType: TextInputType.number,
      initialValue: widget.prefWinchPlatesNum,
      decoration: InputDecoration(
        labelText: "Numbers",
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 2,
          ),
          borderRadius: widget.currentLang == 'en'
              ? BorderRadius.only(
                  bottomRight: Radius.circular(10),
                  topRight: Radius.circular(10))
              : BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  topLeft: Radius.circular(10)),
        ),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
            ),
            borderRadius: widget.currentLang == 'en'
                ? BorderRadius.only(
                    bottomRight: Radius.circular(10),
                    topRight: Radius.circular(10))
                : BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    topLeft: Radius.circular(10))),
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.redAccent,
            ),
            borderRadius: widget.currentLang == 'en'
                ? BorderRadius.only(
                    bottomRight: Radius.circular(10),
                    topRight: Radius.circular(10))
                : BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    topLeft: Radius.circular(10))),
      ),
      onSaved: (newValue) {
        //firstName = newValue;
        //winchRegisterRequestModel.firstName = newValue;
        // setPrefFirstName(newValue);
        //numPlatController.text = newValue;
        if (newValue != widget.prefWinchPlatesNum) {
          WinchPlateNum_changed = true;
          print("four");
        }
        setPrefWinchPlatesNum(newValue);
      },
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: NullNumPlateError);
          removeError(error: SmallNumPlateError);
          return "";
        }
        if (value.length > 1) {
          removeError(error: SmallCharPlateError);
          return "";
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: NullNumPlateError);
          return "";
        } else if (value.length < 3) {
          addError(error: SmallNumPlateError);
          return "";
        } else if (value.length > 4) {
          addError(error: LargeCharPlateError);
          return "";
        }
        return null;
      },
    );
  }

  TextFormField DecoratedPhoneTField() {
    return TextFormField(
      keyboardType: TextInputType.name,
      enabled: false,
      initialValue: widget.prefPhone,
      style: Theme.of(context).textTheme.bodyText2,
      decoration: InputDecoration(
        labelText: 'Phone',
        //disabledBorder: disableInputBorder(),
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }
}

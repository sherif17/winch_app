import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:winch_app/local_db/winch_driver_info_db.dart';
import 'package:winch_app/localization/localization_constants.dart';
import 'package:winch_app/screens/login_screens/file_upload/step_one/city_modal_list.dart';
import 'package:winch_app/shared_prefrences/winch_user_model.dart';
import 'package:winch_app/utils/constants.dart';
import 'package:winch_app/widgets/form_error.dart';

class CompleteProfile extends StatefulWidget {
  GlobalKey<FormState> firstStepFormKey = GlobalKey<FormState>();
  String Lang, Fname;
  CompleteProfile({this.firstStepFormKey, this.Fname, this.Lang});
  @override
  _CompleteProfileState createState() => _CompleteProfileState();
}

class _CompleteProfileState extends State<CompleteProfile> {
  // String Lang;
  List<CityItem> _cities;
  List<DropdownMenuItem<CityItem>> _dropdownMenuItems;
  CityItem _selectedCity;
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    setState(() {
      _cities = widget.Lang == 'ar'
          ? CityItem.getArabCompanies()
          : CityItem.getEngCompanies();
    });

    _dropdownMenuItems = buildDropdownMenuItems(_cities);
    _selectedCity = _dropdownMenuItems[0].value;
    // TODO: implement initState
    super.initState();
  }

  List<DropdownMenuItem<CityItem>> buildDropdownMenuItems(List companies) {
    List<DropdownMenuItem<CityItem>> items = List();
    for (CityItem city in _cities) {
      items.add(
        DropdownMenuItem(
          value: city,
          child: Text(city.city),
        ),
      );
    }
    return items;
  }

  onChangeDropdownItem(CityItem selectedCity) {
    setState(() {
      _selectedCity = selectedCity;
      setPrefWorkingCity(selectedCity.city);
      saveWorkingCityInDB(selectedCity.city);
    });
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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.01,
                bottom: MediaQuery.of(context).size.height * 0.03),
            child: FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(
                getTranslated(context, "Let's Complete Your Profile") +
                    widget.Fname,
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
          ),
        ),
        SizedBox(
          height: size.height * 0.05,
        ),
        Text(getTranslated(context, "Please Enter Winch Plates information")),
        SizedBox(
          height: size.height * 0.04,
        ),
        Form(
          key: widget.firstStepFormKey,
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Expanded(
                    child: BuildCharPlateTextFormField(),
                  ),
                  Expanded(child: BuildNumPlateTextFormField()),
                ],
              ),
              FormError(size: size, errors: errors),
            ],
          ),
        ),
        SizedBox(
          height: size.height * 0.05,
        ),
        Text(getTranslated(context, "Select Desired Working City")),
        SizedBox(
          height: size.height * 0.05,
        ),
        Align(
          alignment: Alignment.center,
          child: Container(
            width: size.width * 0.6,
            decoration: BoxDecoration(
                border: Border.all(
                    color: Theme.of(context).primaryColorDark, width: 1.2),
                // color: Colors.red.withOpacity(0.8),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: DropdownButtonHideUnderline(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: size.height * 0.05),
                child: DropdownButton(
                  hint: Text("Select City"),
                  value: _selectedCity,
                  items: _dropdownMenuItems,
                  onChanged: onChangeDropdownItem,
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        //Text('Selected: ${_selectedCity.city}'),
      ],
    );
  }

  static final translators = {'#': new RegExp(r'(?<!^)(\B|b)(?!$)')};
  var maskFormatter = new MaskTextInputFormatter(
      filter: {'A': new RegExp(r'(?<!^)(\B|b)(?!$)')});
  /* var controller =
      new MaskedTextController(mask: '000.000.000-00', translator: translators);
*/
  TextFormField BuildCharPlateTextFormField() {
    return TextFormField(
      maxLength: 3,
      maxLengthEnforced: true,
      inputFormatters: [
        // FilteringTextInputFormatter.deny(new RegExp(r'(?<!^)(\B|b)(?!$)'))
      ],
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
        labelText: widget.Lang == "en" ? "Characters" : "الحروف",
        focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: Theme.of(context).primaryColor, width: 2),
          borderRadius: widget.Lang == 'en'
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
            borderRadius: widget.Lang == 'en'
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
            borderRadius: widget.Lang == 'en'
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
        setPrefWinchPlatesChars(newValue);
        saveWinchPlatesCharInDB(newValue);
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
      decoration: InputDecoration(
        labelText: widget.Lang == "en" ? "Numbers" : "الارقام",
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 2,
          ),
          borderRadius: widget.Lang == 'en'
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
            borderRadius: widget.Lang == 'en'
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
            borderRadius: widget.Lang == 'en'
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
        setPrefWinchPlatesNum(newValue);
        saveWinchPlatesNumInDB(newValue);
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
}

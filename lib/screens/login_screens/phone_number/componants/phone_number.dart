import 'package:flutter/material.dart';
import 'package:winch_app/models/winch_driver_register/phone_num_model.dart';

class phoneNum {
  PhoneRequestModel phoneRequestModel;
  String phoneNumber;
  String Fname;
  String LName;
  String info;
  ScaffoldState scafoldKey;
  phoneNum(
      {this.phoneNumber,
      this.phoneRequestModel,
      this.Fname,
      this.LName,
      this.info});
}

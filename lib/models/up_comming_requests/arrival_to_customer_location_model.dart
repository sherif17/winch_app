// To parse this JSON data, do
//
//     final arrivalOfWinchDriverRequestModel = arrivalOfWinchDriverRequestModelFromJson(jsonString);

import 'dart:convert';

ArrivalOfWinchDriverRequestModel arrivalOfWinchDriverRequestModelFromJson(
        String str) =>
    ArrivalOfWinchDriverRequestModel.fromJson(json.decode(str));

String arrivalOfWinchDriverRequestModelToJson(
        ArrivalOfWinchDriverRequestModel data) =>
    json.encode(data.toJson());

class ArrivalOfWinchDriverRequestModel {
  ArrivalOfWinchDriverRequestModel({
    this.driverResponse,
  });

  String driverResponse;

  factory ArrivalOfWinchDriverRequestModel.fromJson(
          Map<String, dynamic> json) =>
      ArrivalOfWinchDriverRequestModel(
        driverResponse: json["driverResponse"],
      );

  Map<String, dynamic> toJson() => {
        "driverResponse": driverResponse,
      };
}
// To parse this JSON data, do
//
//     final arrivalOfWinchDriverResponseModel = arrivalOfWinchDriverResponseModelFromJson(jsonString);

ArrivalOfWinchDriverResponseModel arrivalOfWinchDriverResponseModelFromJson(
        String str) =>
    ArrivalOfWinchDriverResponseModel.fromJson(json.decode(str));

String arrivalOfWinchDriverResponseModelToJson(
        ArrivalOfWinchDriverResponseModel data) =>
    json.encode(data.toJson());

class ArrivalOfWinchDriverResponseModel {
  ArrivalOfWinchDriverResponseModel({
    this.msg,
    this.error,
  });

  String msg;
  String error;

  factory ArrivalOfWinchDriverResponseModel.fromJson(
          Map<String, dynamic> json) =>
      ArrivalOfWinchDriverResponseModel(
        msg: json["msg"],
        error: json["Error"],
      );

  Map<String, dynamic> toJson() => {
        "msg": msg,
        "Error": error,
      };
}

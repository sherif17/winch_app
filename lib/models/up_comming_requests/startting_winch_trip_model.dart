// To parse this JSON data, do
//
//     final startingOfWinchTripRequestModel = startingOfWinchTripRequestModelFromJson(jsonString);

import 'dart:convert';

StartingOfWinchTripRequestModel startingOfWinchTripRequestModelFromJson(
        String str) =>
    StartingOfWinchTripRequestModel.fromJson(json.decode(str));

String startingOfWinchTripRequestModelToJson(
        StartingOfWinchTripRequestModel data) =>
    json.encode(data.toJson());

class StartingOfWinchTripRequestModel {
  StartingOfWinchTripRequestModel({
    this.driverResponse,
  });

  String driverResponse;

  factory StartingOfWinchTripRequestModel.fromJson(Map<String, dynamic> json) =>
      StartingOfWinchTripRequestModel(
        driverResponse: json["driverResponse"],
      );

  Map<String, dynamic> toJson() => {
        "driverResponse": driverResponse,
      };
}

// To parse this JSON data, do
//
//     final startingOfWinchTripResponseModel = startingOfWinchTripResponseModelFromJson(jsonString);
StartingOfWinchTripResponseModel startingOfWinchTripResponseModelFromJson(
        String str) =>
    StartingOfWinchTripResponseModel.fromJson(json.decode(str));

String startingOfWinchTripResponseModelToJson(
        StartingOfWinchTripResponseModel data) =>
    json.encode(data.toJson());

class StartingOfWinchTripResponseModel {
  StartingOfWinchTripResponseModel({
    this.msg,
    this.error,
  });

  String msg;
  String error;

  factory StartingOfWinchTripResponseModel.fromJson(
          Map<String, dynamic> json) =>
      StartingOfWinchTripResponseModel(
        msg: json["msg"],
        error: json["Error"],
      );

  Map<String, dynamic> toJson() => {
        "msg": msg,
        "Error": error,
      };
}

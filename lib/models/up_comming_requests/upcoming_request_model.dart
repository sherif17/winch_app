// To parse this JSON data, do
//
//     final upcommingRequestRequestModel = upcommingRequestRequestModelFromJson(jsonString);

import 'dart:convert';

// To parse this JSON data, do
//
//     final upcomingRequestRequestModel = upcomingRequestRequestModelFromJson(jsonString);

import 'dart:convert';

UpcomingRequestRequestModel upcomingRequestRequestModelFromJson(String str) =>
    UpcomingRequestRequestModel.fromJson(json.decode(str));

String upcomingRequestRequestModelToJson(UpcomingRequestRequestModel data) =>
    json.encode(data.toJson());

class UpcomingRequestRequestModel {
  UpcomingRequestRequestModel({
    this.driverResponse,
  });

  String driverResponse;

  factory UpcomingRequestRequestModel.fromJson(Map<String, dynamic> json) =>
      UpcomingRequestRequestModel(
        driverResponse: json["driverResponse"],
      );

  Map<String, dynamic> toJson() => {
        "driverResponse": driverResponse,
      };
}

// To parse this JSON data, do
//
//     final upcomingRequestResponseModel = upcomingRequestResponseModelFromJson(jsonString);

UpcomingRequestResponseModel upcomingRequestResponseModelFromJson(String str) =>
    UpcomingRequestResponseModel.fromJson(json.decode(str));

String upcomingRequestResponseModelToJson(UpcomingRequestResponseModel data) =>
    json.encode(data.toJson());

class UpcomingRequestResponseModel {
  UpcomingRequestResponseModel({
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.estimatedTime,
    this.estimatedDistance,
    this.estimatedFare,
    this.carBrand,
    this.carModel,
    this.msg,
    this.carPlates,
  });

  String firstName;
  String lastName;
  String phoneNumber;
  String estimatedTime;
  String estimatedDistance;
  String estimatedFare;
  String carBrand;
  String carModel;
  String msg;
  String carPlates;

  factory UpcomingRequestResponseModel.fromJson(Map<String, dynamic> json) =>
      UpcomingRequestResponseModel(
        firstName: json["firstName"],
        lastName: json["lastName"],
        phoneNumber: json["phoneNumber"],
        estimatedTime: json["EstimatedTime"],
        estimatedDistance: json["EstimatedDistance"],
        estimatedFare: json["EstimatedFare"],
        carBrand: json["CarBrand"],
        carModel: json["CarModel"],
        msg: json["msg"],
        carPlates: json["CarPlates"],
      );

  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "phoneNumber": phoneNumber,
        "EstimatedTime": estimatedTime,
        "EstimatedDistance": estimatedDistance,
        "EstimatedFare": estimatedFare,
        "CarBrand": carBrand,
        "CarModel": carModel,
        "msg": msg,
        "CarPlates": carPlates,
      };
}

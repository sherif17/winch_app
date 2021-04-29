// To parse this JSON data, do
//
//     final acceptingWinchServiceRequestModel = acceptingWinchServiceRequestModelFromJson(jsonString);

import 'dart:convert';

AcceptingWinchServiceRequestModel acceptingWinchServiceRequestModelFromJson(
        String str) =>
    AcceptingWinchServiceRequestModel.fromJson(json.decode(str));

String acceptingWinchServiceRequestModelToJson(
        AcceptingWinchServiceRequestModel data) =>
    json.encode(data.toJson());

class AcceptingWinchServiceRequestModel {
  AcceptingWinchServiceRequestModel({
    this.driverResponse,
  });

  String driverResponse;

  factory AcceptingWinchServiceRequestModel.fromJson(
          Map<String, dynamic> json) =>
      AcceptingWinchServiceRequestModel(
        driverResponse: json["driverResponse"],
      );

  Map<String, dynamic> toJson() => {
        "driverResponse": driverResponse,
      };
}
// To parse this JSON data, do
//
//     final acceptingWinchServiceResponseModel = acceptingWinchServiceResponseModelFromJson(jsonString);

AcceptingWinchServiceResponseModel acceptingWinchServiceResponseModelFromJson(
        String str) =>
    AcceptingWinchServiceResponseModel.fromJson(json.decode(str));

String acceptingWinchServiceResponseModelToJson(
        AcceptingWinchServiceResponseModel data) =>
    json.encode(data.toJson());

class AcceptingWinchServiceResponseModel {
  AcceptingWinchServiceResponseModel({
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.estimatedTime,
    this.estimatedDistance,
    this.estimatedFare,
    this.carBrand,
    this.carModel,
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
  String carPlates;

  factory AcceptingWinchServiceResponseModel.fromJson(
          Map<String, dynamic> json) =>
      AcceptingWinchServiceResponseModel(
        firstName: json["firstName"],
        lastName: json["lastName"],
        phoneNumber: json["phoneNumber"],
        estimatedTime: json["EstimatedTime"],
        estimatedDistance: json["EstimatedDistance"],
        estimatedFare: json["EstimatedFare"],
        carBrand: json["CarBrand"],
        carModel: json["CarModel"],
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
        "CarPlates": carPlates,
      };
}

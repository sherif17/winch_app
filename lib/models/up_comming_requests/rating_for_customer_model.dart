// To parse this JSON data, do
//
//     final ratingForCustomerRequestModel = ratingForCustomerRequestModelFromJson(jsonString);

import 'dart:convert';

RatingForCustomerRequestModel ratingForCustomerRequestModelFromJson(
        String str) =>
    RatingForCustomerRequestModel.fromJson(json.decode(str));

String ratingForCustomerRequestModelToJson(
        RatingForCustomerRequestModel data) =>
    json.encode(data.toJson());

class RatingForCustomerRequestModel {
  RatingForCustomerRequestModel({
    this.stars,
  });

  String stars;

  factory RatingForCustomerRequestModel.fromJson(Map<String, dynamic> json) =>
      RatingForCustomerRequestModel(
        stars: json["Stars"],
      );

  Map<String, dynamic> toJson() => {
        "Stars": stars,
      };
}

// To parse this JSON data, do
//
//     final ratingForCustomerResponseModel = ratingForCustomerResponseModelFromJson(jsonString);

RatingForCustomerResponseModel ratingForCustomerResponseModelFromJson(
        String str) =>
    RatingForCustomerResponseModel.fromJson(json.decode(str));

String ratingForCustomerResponseModelToJson(
        RatingForCustomerResponseModel data) =>
    json.encode(data.toJson());

class RatingForCustomerResponseModel {
  RatingForCustomerResponseModel({
    this.msg,
  });

  String msg;

  factory RatingForCustomerResponseModel.fromJson(Map<String, dynamic> json) =>
      RatingForCustomerResponseModel(
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "msg": msg,
      };
}

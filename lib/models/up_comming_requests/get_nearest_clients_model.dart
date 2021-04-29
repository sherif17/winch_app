// To parse this JSON data, do
//
//     final getNearestClientRequestModel = getNearestClientRequestModelFromJson(jsonString);

import 'dart:convert';

GetNearestClientRequestModel getNearestClientRequestModelFromJson(String str) =>
    GetNearestClientRequestModel.fromJson(json.decode(str));

String getNearestClientRequestModelToJson(GetNearestClientRequestModel data) =>
    json.encode(data.toJson());

class GetNearestClientRequestModel {
  GetNearestClientRequestModel({
    this.locationLat,
    this.locationLong,
  });

  String locationLat;
  String locationLong;

  factory GetNearestClientRequestModel.fromJson(Map<String, dynamic> json) =>
      GetNearestClientRequestModel(
        locationLat: json["Location_Lat"],
        locationLong: json["Location_Long"],
      );

  Map<String, dynamic> toJson() => {
        "Location_Lat": locationLat,
        "Location_Long": locationLong,
      };
}
// To parse this JSON data, do
//
//     final getNearestClientResponseModel = getNearestClientResponseModelFromJson(jsonString);

GetNearestClientResponseModel getNearestClientResponseModelFromJson(
        String str) =>
    GetNearestClientResponseModel.fromJson(json.decode(str));

String getNearestClientResponseModelToJson(
        GetNearestClientResponseModel data) =>
    json.encode(data.toJson());

class GetNearestClientResponseModel {
  GetNearestClientResponseModel({
    this.error,
    this.requestId,
    this.nearestRidePickupLocation,
    this.nearestRideDistinationLocation,
  });

  String error;
  String requestId;
  NearestRideLocation nearestRidePickupLocation;
  NearestRideLocation nearestRideDistinationLocation;

  factory GetNearestClientResponseModel.fromJson(Map<String, dynamic> json) =>
      GetNearestClientResponseModel(
        error: json["error"],
        requestId: json["requestId"],
        nearestRidePickupLocation: json["Nearest Ride: Pickup Location"] != null
            ? NearestRideLocation.fromJson(
                json["Nearest Ride: Pickup Location"])
            : null,
        nearestRideDistinationLocation:
            json["Nearest Ride: Distination Location"] != null
                ? NearestRideLocation.fromJson(
                    json["Nearest Ride: Distination Location"])
                : null,
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "requestId": requestId,
        "Nearest Ride: Pickup Location": nearestRidePickupLocation.toJson(),
        "Nearest Ride: Distination Location":
            nearestRideDistinationLocation.toJson(),
      };
}

class NearestRideLocation {
  NearestRideLocation({
    this.lat,
    this.lng,
  });

  String lat;
  String lng;

  factory NearestRideLocation.fromJson(Map<String, dynamic> json) =>
      NearestRideLocation(
        lat: json["lat"],
        lng: json["lng"],
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lng": lng,
      };
}

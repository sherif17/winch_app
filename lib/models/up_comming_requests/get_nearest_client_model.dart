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
    this.nearestRide,
    this.error,
    this.requestId,
  });

  NearestRide nearestRide;
  String error;
  String requestId;

  factory GetNearestClientResponseModel.fromJson(Map<String, dynamic> json) =>
      GetNearestClientResponseModel(
        nearestRide: NearestRide.fromJson(json["Nearest Ride: "]),
        error: json["error"],
        requestId: json["requestId"],
      );

  Map<String, dynamic> toJson() => {
        "Nearest Ride: ": nearestRide.toJson(),
        "error": error,
        "requestId": requestId,
      };
}

class NearestRide {
  NearestRide({
    this.searchScope,
    this.creationTimeStamp,
    this.lastScopeIncrease,
    this.pickupLocation,
    this.dropOffLocation,
    this.requesterId,
  });

  int searchScope;
  int creationTimeStamp;
  int lastScopeIncrease;
  Location pickupLocation;
  Location dropOffLocation;
  String requesterId;

  factory NearestRide.fromJson(Map<String, dynamic> json) => NearestRide(
        searchScope: json["searchScope"],
        creationTimeStamp: json["creationTimeStamp"],
        lastScopeIncrease: json["lastScopeIncrease"],
        pickupLocation: Location.fromJson(json["pickupLocation"]),
        dropOffLocation: Location.fromJson(json["dropOffLocation"]),
        requesterId: json["requesterId"],
      );

  Map<String, dynamic> toJson() => {
        "searchScope": searchScope,
        "creationTimeStamp": creationTimeStamp,
        "lastScopeIncrease": lastScopeIncrease,
        "pickupLocation": pickupLocation.toJson(),
        "dropOffLocation": dropOffLocation.toJson(),
        "requesterId": requesterId,
      };
}

class Location {
  Location({
    this.lat,
    this.lng,
  });

  String lat;
  String lng;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        lat: json["lat"],
        lng: json["lng"],
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lng": lng,
      };
}

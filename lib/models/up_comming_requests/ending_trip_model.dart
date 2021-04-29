// To parse this JSON data, do
//
//     final endingWinchServiceRequestModel = endingWinchServiceRequestModelFromJson(jsonString);

import 'dart:convert';

EndingWinchServiceRequestModel endingWinchServiceRequestModelFromJson(
        String str) =>
    EndingWinchServiceRequestModel.fromJson(json.decode(str));

String endingWinchServiceRequestModelToJson(
        EndingWinchServiceRequestModel data) =>
    json.encode(data.toJson());

class EndingWinchServiceRequestModel {
  EndingWinchServiceRequestModel({
    this.finalLocationLat,
    this.finalLocationLong,
  });

  String finalLocationLat;
  String finalLocationLong;

  factory EndingWinchServiceRequestModel.fromJson(Map<String, dynamic> json) =>
      EndingWinchServiceRequestModel(
        finalLocationLat: json["finalLocation_Lat"],
        finalLocationLong: json["finalLocation_Long"],
      );

  Map<String, dynamic> toJson() => {
        "finalLocation_Lat": finalLocationLat,
        "finalLocation_Long": finalLocationLong,
      };
}

// To parse this JSON data, do
//
//     final endingWinchServiceResponseModel = endingWinchServiceResponseModelFromJson(jsonString);
EndingWinchServiceResponseModel endingWinchServiceResponseModelFromJson(
        String str) =>
    EndingWinchServiceResponseModel.fromJson(json.decode(str));

String endingWinchServiceResponseModelToJson(
        EndingWinchServiceResponseModel data) =>
    json.encode(data.toJson());

class EndingWinchServiceResponseModel {
  EndingWinchServiceResponseModel({
    this.status,
    this.fare,
    this.totalTimeForTrip,
  });

  String status;
  int fare;
  TotalTimeForTrip totalTimeForTrip;

  factory EndingWinchServiceResponseModel.fromJson(Map<String, dynamic> json) =>
      EndingWinchServiceResponseModel(
        status: json["STATUS"],
        fare: json["Fare"],
        totalTimeForTrip: TotalTimeForTrip.fromJson(json["TotalTimeForTrip"]),
      );

  Map<String, dynamic> toJson() => {
        "STATUS": status,
        "Fare": fare,
        "TotalTimeForTrip": totalTimeForTrip.toJson(),
      };
}

class TotalTimeForTrip {
  TotalTimeForTrip({
    this.days,
    this.hours,
    this.minutes,
    this.seconds,
  });

  int days;
  int hours;
  int minutes;
  double seconds;

  factory TotalTimeForTrip.fromJson(Map<String, dynamic> json) =>
      TotalTimeForTrip(
        days: json["days"],
        hours: json["hours"],
        minutes: json["minutes"],
        seconds: json["seconds"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "days": days,
        "hours": hours,
        "minutes": minutes,
        "seconds": seconds,
      };
}

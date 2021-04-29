import 'dart:convert';
import 'package:winch_app/models/up_comming_requests/accepting_trip_model.dart';
import 'package:winch_app/models/up_comming_requests/arrival_to_customer_location_model.dart';
import 'package:winch_app/models/up_comming_requests/ending_trip_model.dart';
import 'package:http/http.dart' as http;
import 'package:winch_app/models/up_comming_requests/get_nearest_clients_model.dart';

import 'package:winch_app/models/up_comming_requests/live_tracker_model.dart';
import 'package:winch_app/models/up_comming_requests/rating_for_customer_model.dart';
import 'package:winch_app/models/up_comming_requests/startting_winch_trip_model.dart';

class WinchRequestService {
  Future<GetNearestClientResponseModel> getNearestClient(
      GetNearestClientRequestModel getNearestClientRequestModel, token) async {
    print("Request body : ${getNearestClientRequestModel.toJson()}");
    var url =
        Uri.parse('http://161.97.155.244/api/driverMatching/getNearestClient');
    final response = await http.post(url,
        headers: {"x-auth-token": "$token"},
        body: getNearestClientRequestModel.toJson());
    print("response.body:${response.body}");
    if (response.statusCode == 200) {
      print("response.body:${response.statusCode}");
      print("response.body:${response.reasonPhrase}");
      return GetNearestClientResponseModel.fromJson(json.decode(response.body));
    } else if (response.statusCode == 400) {
      return GetNearestClientResponseModel.fromJson(json.decode(response.body));
    } else {
      throw Exception("failed to load Data");
    }
  }

  Future<AcceptingWinchServiceResponseModel> acceptCustomerRequest(
      AcceptingWinchServiceRequestModel acceptingWinchServiceRequestModel,
      token) async {
    var url =
        Uri.parse('http://161.97.155.244/api/driverMatching/driverResponse');
    final response = await http.post(url,
        headers: {"x-auth-token": "$token"},
        body: acceptingWinchServiceRequestModel.toJson());
    if (response.statusCode == 200 || response.statusCode == 400) {
      print("response.body:${response.body}");
      return AcceptingWinchServiceResponseModel.fromJson(
          json.decode(response.body));
    } else {
      throw Exception("failed to load Data");
    }
  }

  Future<EndingWinchServiceResponseModel> endCustomerTrip(
      EndingWinchServiceRequestModel endingWinchServiceRequestModel,
      token) async {
    var url = Uri.parse('http://161.97.155.244/api/driverMatching/EndRide');
    final response = await http.post(url,
        headers: {"x-auth-token": "$token"},
        body: endingWinchServiceRequestModel.toJson());
    if (response.statusCode == 200 || response.statusCode == 400) {
      print("response.body:${response.body}");
      return EndingWinchServiceResponseModel.fromJson(
          json.decode(response.body));
    } else {
      throw Exception("failed to load Data");
    }
  }

  Future<RatingForCustomerResponseModel> ratingForCustomer(
      RatingForCustomerRequestModel ratingForCustomerRequestModel,
      token) async {
    var url = Uri.parse('http://161.97.155.244/api/driverMatching/Rate');
    final response = await http.post(url,
        headers: {"x-auth-token": "$token"},
        body: ratingForCustomerRequestModel.toJson());
    if (response.statusCode == 200 || response.statusCode == 400) {
      print("response.body:${response.body}");
      return RatingForCustomerResponseModel.fromJson(
          json.decode(response.body));
    } else {
      throw Exception("failed to load Data");
    }
  }

  Future<LiveTrackerResponseModel> liveTracker(
      LiveTrackerRequestModel liveTrackerRequestModel, token) async {
    var url = Uri.parse('http://161.97.155.244/api/driverMatching/liveTracker');
    final response = await http.post(url,
        headers: {"x-auth-token": "$token"},
        body: liveTrackerRequestModel.toJson());
    if (response.statusCode == 200 || response.statusCode == 400) {
      print("response.body:${response.body}");
      return LiveTrackerResponseModel.fromJson(json.decode(response.body));
    } else {
      throw Exception("failed to load Data");
    }
  }

  Future<ArrivalOfWinchDriverResponseModel> arrivalToCustomerLocation(
      ArrivalOfWinchDriverRequestModel arrivalOfWinchDriverRequestModel,
      token) async {
    var url =
        Uri.parse('http://161.97.155.244/api/driverMatching/driverArrival');
    final response = await http.post(url,
        headers: {"x-auth-token": "$token"},
        body: arrivalOfWinchDriverRequestModel.toJson());
    if (response.statusCode == 200 || response.statusCode == 400) {
      print("response.body:${response.body}");
      return ArrivalOfWinchDriverResponseModel.fromJson(
          json.decode(response.body));
    } else {
      throw Exception("failed to load Data");
    }
  }

  Future<StartingOfWinchTripResponseModel> startingWinchTrip(
      StartingOfWinchTripRequestModel startingOfWinchTripRequestModel,
      token) async {
    var url =
        Uri.parse('http://161.97.155.244/api/driverMatching/ServiceStart');
    final response = await http.post(url,
        headers: {"x-auth-token": "$token"},
        body: startingOfWinchTripRequestModel.toJson());
    if (response.statusCode == 200 || response.statusCode == 400) {
      print("response.body:${response.body}");
      return StartingOfWinchTripResponseModel.fromJson(
          json.decode(response.body));
    } else {
      throw Exception("failed to load Data");
    }
  }
}

import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:winch_app/models/up_comming_requests/get_nearest_client_model.dart';
import 'package:winch_app/services/winch_driver_request/winch_requests_service.dart';

class WinchStateProvider extends ChangeNotifier {
  bool currentState = false;
  bool isLoading = false;
  Timer timer;

  bool SEARCHING_FOR_CUSTOMER = false;
  bool CUSTOMER_FOUNDED = false;
  bool ALREADY_HAVE_RIDE = false;

  WinchRequestService requestService = WinchRequestService();
  GetNearestClientRequestModel getNearestClientRequestModel;
  // =
  //     GetNearestClientRequestModel();
  GetNearestClientResponseModel getNearestClientResponseModel =
      GetNearestClientResponseModel();

  getWinchDriverCurrentState(state) {
    currentState = state;
    state == true
        ? SEARCHING_FOR_CUSTOMER = true
        : SEARCHING_FOR_CUSTOMER = false;
    notifyListeners();
  }

  getNearestClientToMe(token) async {
    isLoading = true;
    getNearestClientResponseModel = await requestService.getNearestClient(
        getNearestClientRequestModel, token);
    isLoading = false;

    if (getNearestClientResponseModel.requestId == null &&
        getNearestClientResponseModel.error == "No client requests now") {
      SEARCHING_FOR_CUSTOMER = true;
      notifyListeners();
    }
    if (getNearestClientResponseModel.nearestRide != null) {
      CUSTOMER_FOUNDED = true;
      SEARCHING_FOR_CUSTOMER = false;
      notifyListeners();
    }
    if (getNearestClientResponseModel.requestId != null &&
        getNearestClientResponseModel.error != null) {
      ALREADY_HAVE_RIDE = true;
      SEARCHING_FOR_CUSTOMER = false;
      notifyListeners();
    }
    // if (currentState == true) {
    //   print("timer started start");
    //   timer=Timer.periodic(Duration(seconds: 10), (timer) async {
    //     print("request body ${getNearestClientRequestModel.toJson()}");
    //
    //     if (getNearestClientResponseModel.nearestRide != null){
    //       timer.cancel();
    //     }
    //     if (getNearestClientResponseModel.requestId != null ||
    //         currentState == false) {
    //       timer.cancel();
    //       print("timer is cancelled");
    //       print(getNearestClientResponseModel.nearestRide);
    //       print(getNearestClientResponseModel.requestId);
    //       print(getNearestClientResponseModel.error);
    //     }
    //   });
    // }
    // else {
    //   timer.cancel();
    //   print("driver is offline");
    // }
    notifyListeners();
  }
}

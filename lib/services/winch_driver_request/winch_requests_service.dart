import 'dart:convert';
import 'package:winch_app/models/up_comming_requests/get_nearest_client_model.dart';
import 'package:http/http.dart' as http;

class WinchRequestService {
  Future<GetNearestClientResponseModel> getNearestClient(
      GetNearestClientRequestModel getNearestClientRequestModel, token) async {
    var url =
        Uri.parse('http://161.97.155.244/api/driverMatching/getNearestClient');
    final response = await http.post(url,
        headers: {"x-auth-token": "$token"},
        body: getNearestClientRequestModel.toJson());
    if (response.statusCode == 200 || response.statusCode == 400) {
      print("response.body:${response.body}");
      return GetNearestClientResponseModel.fromJson(json.decode(response.body));
    }
  }
}

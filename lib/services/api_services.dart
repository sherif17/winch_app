import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:winch_app/models/files_upload_model.dart';
import 'dart:convert';

import 'package:winch_app/models/phone_num_model.dart';
import 'package:winch_app/models/user_register_model.dart';

class ApiService {
  Future<PhoneResponseModel> phoneCheck(
      PhoneRequestModel phoneRequestModel) async {
    String url = 'http://161.97.155.244/api/registeration/customer';
    final response = await http.post(url,
        headers: {'charset': 'utf-8'}, body: phoneRequestModel.toJson());
    if (response.statusCode == 200 || response.statusCode == 400) {
      print("response.body:${response.body}");
      return PhoneResponseModel.fromJson(json.decode(response.body));
    } else {
      throw Exception("failed to load Data");
    }
  }

  Future<UserRegisterResponseModel> registerUser(
      UserRegisterRequestModel userRegisterRequestModel, token) async {
    String url = 'http://161.97.155.244/api/customer/me/updateprofile';
    final response = await http.post(url,
        headers: {"x-auth-token": "$token"},
        body: userRegisterRequestModel.toJson());
    if (response.statusCode == 200) {
      return UserRegisterResponseModel.fromJson(json.decode(response.body));
    } else if (response.statusCode == 400)
      return UserRegisterResponseModel.fromJson(json.decode(response.body));
  }

  Future<FilesUploadResponseModel> uploadImage(
      {dynamic data, Options options, token}) async {
    Dio dio = new Dio();
    dio.options.headers['content-Type'] = 'application/json';
    dio.options.headers["x-auth-token"] = "$token";
    String url = ' http://.    /api/winchDriver/me/UploadImages';
    Response response = await dio.post(url, data: data /*, options: options*/,
        onSendProgress: (int sent, int total) {
      print("$sent $total");
    });
    if (response.statusCode == 200 || response.statusCode == 400) {
      return FilesUploadResponseModel.fromJson(json.decode(response.data));
    } else {
      throw Exception("failed to load Data");
    }
  }
}

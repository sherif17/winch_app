import 'dart:convert';

// To parse this JSON data, do
//
//     final filesUploadResponseModel = filesUploadResponseModelFromJson(jsonString);

FilesUploadResponseModel filesUploadResponseModelFromJson(String str) =>
    FilesUploadResponseModel.fromJson(json.decode(str));

String filesUploadResponseModelToJson(FilesUploadResponseModel data) =>
    json.encode(data.toJson());

class FilesUploadResponseModel {
  FilesUploadResponseModel({
    this.newToken,
    this.error,
  });

  String newToken;
  String error;

  factory FilesUploadResponseModel.fromJson(Map<String, dynamic> json) =>
      FilesUploadResponseModel(
        newToken: json["New Token"],
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "New Token": newToken,
        "error": error,
      };
}

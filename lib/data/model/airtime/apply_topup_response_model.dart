// To parse this JSON data, do
//
//     final operatorResponseModel = operatorResponseModelFromJson(jsonString);

import 'dart:convert';


class ApplyTopUpResponseModel {
  String? remark;
  String? status;
  Message? message;
  Data? data;

  ApplyTopUpResponseModel({
    this.remark,
    this.status,
    this.message,
    this.data
  });

  factory ApplyTopUpResponseModel.fromJson(Map<String, dynamic> json) => ApplyTopUpResponseModel(
    remark: json["remark"],
    status: json["status"],
    message: json["message"] == null ? null : Message.fromJson(json["message"]),
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );
}

class Message {
  List<String>? success;
  List<String>? error;
  String? errorStr;

  Message({
    this.success,
    this.error,
    this.errorStr
  });

  factory Message.fromJson(Map<String, dynamic> json) {

    return Message(
        success: json["success"] == null ? [] : List<String>.from(json["success"]!.map((x) => x)),
        error: json["error"] == null ? [] : json["error"] is String ? [json["error"].toString()] : List<String>.from(json["error"]!.map((x) => x)),
        errorStr: json["error"]  != null ? json["error"].toString() : ""
    );
  }
}

class Data {
  String? otpId;

  Data({
    this.otpId,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    otpId: json["otpId"] != null ? json["otpId"].toString() : "",
  );

  Map<String, dynamic> toJson() => {
    "otpId": otpId,
  };
}
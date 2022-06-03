import 'dart:convert';

UserAuthModel loginModelFromJson(String str) =>
    UserAuthModel.fromJson(json.decode(str));

String loginModelToJson(UserAuthModel data) => json.encode(data.toJson());

class UserAuthModel {
  UserAuthModel(
      {required this.authentication,
      required this.data,
      this.received,
      this.secretcode,
      this.emailVerification});

  bool? authentication;
  bool? emailVerification;
  bool? received;
  String? secretcode;
  String? data;

  factory UserAuthModel.fromJson(Map<String, dynamic> json) => UserAuthModel(
        emailVerification: json["emailVerification"],
        received: json["received"],
        secretcode: json["secretcode"],
        authentication: json["authentication"],
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "authentication": authentication,
        "data": data,
        "emailVerification": emailVerification,
        "secretcode": secretcode,
        "received": received
      };
}

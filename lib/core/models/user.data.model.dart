//    

import 'dart:convert';

UserDataModel userDataModelFromJson(String str) =>
    UserDataModel.fromJson(json.decode(str));

String userDataModelToJson(UserDataModel data) => json.encode(data.toJson());

class UserDataModel {
  UserDataModel({
    required this.received,
    required this.data,
  });

  bool received;
  Data? data;

  factory UserDataModel.fromJson(Map<String, dynamic> json) => UserDataModel(
        received: json["received"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "received": received,
        "data": data?.toJson(),
      };
}

class Data {
  Data({
    this.email,
    this.name,
    this.id,
    this.photo,
    this.iat,
    this.exp,
  });

  String? email;
  String? name;
  String? id;
  String? photo;
  int? iat;
  int? exp;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        email: json["email"],
        name: json["name"],
        id: json["id"],
        photo: json["photo"],
        iat: json["iat"],
        exp: json["exp"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "name": name,
        "id": id,
        "photo": photo,
        "iat": iat,
        "exp": exp,
      };
}

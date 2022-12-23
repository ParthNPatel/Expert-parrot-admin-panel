// To parse this JSON data, do
//
//     final getCategoriesResponseModel = getCategoriesResponseModelFromJson(jsonString);

import 'dart:convert';

GetCategoriesResponseModel getCategoriesResponseModelFromJson(String str) =>
    GetCategoriesResponseModel.fromJson(json.decode(str));

String getCategoriesResponseModelToJson(GetCategoriesResponseModel data) =>
    json.encode(data.toJson());

class GetCategoriesResponseModel {
  GetCategoriesResponseModel({
    this.flag,
    this.data,
  });

  bool? flag;
  List<Datum>? data;

  factory GetCategoriesResponseModel.fromJson(Map<String, dynamic> json) =>
      GetCategoriesResponseModel(
        flag: json["flag"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "flag": flag,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  String? id;
  String? name;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        name: json["name"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
      };
}

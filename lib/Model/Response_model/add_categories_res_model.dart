// To parse this JSON data, do
//
//     final addCategoriesResponseModel = addCategoriesResponseModelFromJson(jsonString);

import 'dart:convert';

AddCategoriesResponseModel addCategoriesResponseModelFromJson(String str) =>
    AddCategoriesResponseModel.fromJson(json.decode(str));

String addCategoriesResponseModelToJson(AddCategoriesResponseModel data) =>
    json.encode(data.toJson());

class AddCategoriesResponseModel {
  AddCategoriesResponseModel({
    this.flag,
    this.data,
  });

  bool? flag;
  Data? data;

  factory AddCategoriesResponseModel.fromJson(Map<String, dynamic> json) =>
      AddCategoriesResponseModel(
        flag: json["flag"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "flag": flag,
        "data": data!.toJson(),
      };
}

class Data {
  Data({
    this.name,
    this.id,
    this.createdAt,
    this.updatedAt,
  });

  String? name;
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        name: json["name"],
        id: json["_id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "_id": id,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
      };
}

// To parse this JSON data, do
//
//     final addPostCategoriesResponseModel = addPostCategoriesResponseModelFromJson(jsonString);

import 'dart:convert';

AddPostCategoriesResponseModel addPostCategoriesResponseModelFromJson(
        String str) =>
    AddPostCategoriesResponseModel.fromJson(json.decode(str));

String addPostCategoriesResponseModelToJson(
        AddPostCategoriesResponseModel data) =>
    json.encode(data.toJson());

class AddPostCategoriesResponseModel {
  AddPostCategoriesResponseModel({
    this.flag,
    this.data,
  });

  bool? flag;
  Data? data;

  factory AddPostCategoriesResponseModel.fromJson(Map<String, dynamic> json) =>
      AddPostCategoriesResponseModel(
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

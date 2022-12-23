// To parse this JSON data, do
//
//     final addFaqResponseModel = addFaqResponseModelFromJson(jsonString);

import 'dart:convert';

AddFaqResponseModel addFaqResponseModelFromJson(String str) =>
    AddFaqResponseModel.fromJson(json.decode(str));

String addFaqResponseModelToJson(AddFaqResponseModel data) =>
    json.encode(data.toJson());

class AddFaqResponseModel {
  AddFaqResponseModel({
    this.flag,
    this.data,
  });

  bool? flag;
  Data? data;

  factory AddFaqResponseModel.fromJson(Map<String, dynamic> json) =>
      AddFaqResponseModel(
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
    this.question,
    this.answer,
    this.categoryId,
    this.id,
    this.createdAt,
    this.updatedAt,
  });

  String? question;
  String? answer;
  String? categoryId;
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        question: json["question"],
        answer: json["answer"],
        categoryId: json["categoryId"],
        id: json["_id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "question": question,
        "answer": answer,
        "categoryId": categoryId,
        "_id": id,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
      };
}

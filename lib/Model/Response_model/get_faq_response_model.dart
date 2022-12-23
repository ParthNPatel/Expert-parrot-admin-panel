// To parse this JSON data, do
//
//     final getFaqResponseModel = getFaqResponseModelFromJson(jsonString);

import 'dart:convert';

GetFaqResponseModel getFaqResponseModelFromJson(String str) =>
    GetFaqResponseModel.fromJson(json.decode(str));

String getFaqResponseModelToJson(GetFaqResponseModel data) =>
    json.encode(data.toJson());

class GetFaqResponseModel {
  GetFaqResponseModel({
    this.flag,
    this.data,
  });

  bool? flag;
  List<Datum>? data;

  factory GetFaqResponseModel.fromJson(Map<String, dynamic> json) =>
      GetFaqResponseModel(
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
    this.question,
    this.answer,
    this.categoryId,
    this.createdAt,
    this.updatedAt,
  });

  String? id;
  String? question;
  String? answer;
  String? categoryId;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        question: json["question"],
        answer: json["answer"],
        categoryId: json["categoryId"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "question": question,
        "answer": answer,
        "categoryId": categoryId,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
      };
}

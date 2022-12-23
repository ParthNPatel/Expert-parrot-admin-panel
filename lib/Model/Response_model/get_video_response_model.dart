// To parse this JSON data, do
//
//     final getVideoResponseModel = getVideoResponseModelFromJson(jsonString);

import 'dart:convert';

GetVideoResponseModel getVideoResponseModelFromJson(String str) =>
    GetVideoResponseModel.fromJson(json.decode(str));

String getVideoResponseModelToJson(GetVideoResponseModel data) =>
    json.encode(data.toJson());

class GetVideoResponseModel {
  GetVideoResponseModel({
    this.flag,
    this.data,
  });

  bool? flag;
  List<Datum>? data;

  factory GetVideoResponseModel.fromJson(Map<String, dynamic> json) =>
      GetVideoResponseModel(
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
    this.title,
    this.description,
    this.thumbnail,
    this.video,
    this.likes,
    this.createdAt,
    this.updatedAt,
    this.isLiked,
  });

  String? id;
  String? title;
  String? description;
  String? thumbnail;
  String? video;
  int? likes;
  DateTime? createdAt;
  DateTime? updatedAt;
  bool? isLiked;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        title: json["title"],
        description: json["description"],
        thumbnail: json["thumbnail"],
        video: json["video"],
        likes: json["likes"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        isLiked: json["isLiked"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "description": description,
        "thumbnail": thumbnail,
        "video": video,
        "likes": likes,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "isLiked": isLiked,
      };
}

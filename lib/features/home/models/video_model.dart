// To parse this JSON data, do
//
//     final videoModel = videoModelFromJson(jsonString);

import 'dart:convert';

VideoModel videoModelFromJson(String str) => VideoModel.fromJson(json.decode(str));

String videoModelToJson(VideoModel data) => json.encode(data.toJson());

class VideoModel {
  String profilePicUrl;
  String userName;
  String userCategory;
  String videoUrl;
  String thumbnailUrl;
  int likesNo;
  int commentNo;
  String description;

  VideoModel({
    required this.profilePicUrl,
    required this.userName,
    required this.userCategory,
    required this.videoUrl,
    required this.thumbnailUrl,
    required this.likesNo,
    required this.commentNo,
    required this.description,
  });

  factory VideoModel.fromJson(Map<String, dynamic> json) => VideoModel(
    profilePicUrl: json["profilePicUrl"],
    userName: json["userName"],
    userCategory: json["userCategory"],
    videoUrl: json["videoUrl"],
    thumbnailUrl: json["thumbnailUrl"],
    likesNo: json["likesNo"],
    commentNo: json["commentNo"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "profilePicUrl": profilePicUrl,
    "userName": userName,
    "userCategory": userCategory,
    "videoUrl": videoUrl,
    "thumbnailUrl": thumbnailUrl,
    "likesNo": likesNo,
    "commentNo": commentNo,
    "description": description,
  };
}

// To parse this JSON data, do
//
//     final audioModel = audioModelFromJson(jsonString);

import 'dart:convert';

AudioModel audioModelFromJson(String str) => AudioModel.fromJson(json.decode(str));

String audioModelToJson(AudioModel data) => json.encode(data.toJson());

class AudioModel {
  String profilePicUrl;
  String userName;
  String userCategory;
  String audioUrl;
  int likesNo;
  int commentNo;
  String description;

  AudioModel({
    required this.profilePicUrl,
    required this.userName,
    required this.userCategory,
    required this.audioUrl,
    required this.likesNo,
    required this.commentNo,
    required this.description,
  });

  factory AudioModel.fromJson(Map<String, dynamic> json) => AudioModel(
    profilePicUrl: json["profile_pic_url"],
    userName: json["user_name"],
    userCategory: json["user_category"],
    audioUrl: json["audio_url"],
    likesNo: json["likes_no"],
    commentNo: json["comment_no"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "profile_pic_url": profilePicUrl,
    "user_name": userName,
    "user_category": userCategory,
    "audio_url": audioUrl,
    "likes_no": likesNo,
    "comment_no": commentNo,
    "description": description,
  };
}

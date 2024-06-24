// To parse this JSON data, do
//
//     final textModel = textModelFromJson(jsonString);

import 'dart:convert';

TextModel textModelFromJson(String str) => TextModel.fromJson(json.decode(str));

String textModelToJson(TextModel data) => json.encode(data.toJson());

class TextModel {
  String profilePicUrl;
  String userName;
  String userCategory;
  String textDescription;
  int likesNo;
  int commentNo;

  TextModel({
    required this.profilePicUrl,
    required this.userName,
    required this.userCategory,
    required this.textDescription,
    required this.likesNo,
    required this.commentNo,
  });

  factory TextModel.fromJson(Map<String, dynamic> json) => TextModel(
    profilePicUrl: json["profile_pic_url"],
    userName: json["user_name"],
    userCategory: json["user_category"],
    textDescription: json["text_description"],
    likesNo: json["likes_no"],
    commentNo: json["comment_no"],
  );

  Map<String, dynamic> toJson() => {
    "profile_pic_url": profilePicUrl,
    "user_name": userName,
    "user_category": userCategory,
    "text_description": textDescription,
    "likes_no": likesNo,
    "comment_no": commentNo,
  };
}

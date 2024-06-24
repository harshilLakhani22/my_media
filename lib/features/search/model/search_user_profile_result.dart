// To parse this JSON data, do
//
//     final searchUserProfileResult = searchUserProfileResultFromJson(jsonString);

import 'dart:convert';

SearchUserProfileResult searchUserProfileResultFromJson(String str) => SearchUserProfileResult.fromJson(json.decode(str));

String searchUserProfileResultToJson(SearchUserProfileResult data) => json.encode(data.toJson());

class SearchUserProfileResult {
  List<Audio> audios;
  List<Video> videos;
  List<Audio> text;

  SearchUserProfileResult({
    required this.audios,
    required this.videos,
    required this.text,
  });

  factory SearchUserProfileResult.fromJson(Map<String, dynamic> json) => SearchUserProfileResult(
    audios: List<Audio>.from(json["audios"].map((x) => Audio.fromJson(x))),
    videos: List<Video>.from(json["videos"].map((x) => Video.fromJson(x))),
    text: List<Audio>.from(json["text"].map((x) => Audio.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "audios": List<dynamic>.from(audios.map((x) => x.toJson())),
    "videos": List<dynamic>.from(videos.map((x) => x.toJson())),
    "text": List<dynamic>.from(text.map((x) => x.toJson())),
  };
}

class Audio {
  int id;
  String contentId;
  String moneyType;
  String category;
  String uploadedBy;
  DateTime uploadedAt;
  String? audioPath;
  String username;
  String profilePic;
  String? textContent;

  Audio({
    required this.id,
    required this.contentId,
    required this.moneyType,
    required this.category,
    required this.uploadedBy,
    required this.uploadedAt,
    this.audioPath,
    required this.username,
    required this.profilePic,
    this.textContent,
  });

  factory Audio.fromJson(Map<String, dynamic> json) => Audio(
    id: json["id"],
    contentId: json["contentId"],
    moneyType: json["moneyType"],
    category: json["category"],
    uploadedBy: json["uploadedBy"],
    uploadedAt: DateTime.parse(json["uploadedAt"]),
    audioPath: json["audio_path"],
    username: json["username"],
    profilePic: json["profile_pic"],
    textContent: json["textContent"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "contentId": contentId,
    "moneyType": moneyType,
    "category": category,
    "uploadedBy": uploadedBy,
    "uploadedAt": uploadedAt.toIso8601String(),
    "audio_path": audioPath,
    "username": username,
    "profile_pic": profilePic,
    "textContent": textContent,
  };
}

class Video {
  int id;
  String contentId;
  String moneyType;
  String category;
  String subCat;
  String description;
  String title;
  String videoPath;
  String thumbnailPath;
  String uploadedBy;
  DateTime uploadedAt;
  String username;
  String profilePic;

  Video({
    required this.id,
    required this.contentId,
    required this.moneyType,
    required this.category,
    required this.subCat,
    required this.description,
    required this.title,
    required this.videoPath,
    required this.thumbnailPath,
    required this.uploadedBy,
    required this.uploadedAt,
    required this.username,
    required this.profilePic,
  });

  factory Video.fromJson(Map<String, dynamic> json) => Video(
    id: json["id"],
    contentId: json["contentId"],
    moneyType: json["moneyType"],
    category: json["category"],
    subCat: json["sub_cat"],
    description: json["description"],
    title: json["title"],
    videoPath: json["video_path"],
    thumbnailPath: json["thumbnail_path"],
    uploadedBy: json["uploadedBy"],
    uploadedAt: DateTime.parse(json["uploadedAt"]),
    username: json["username"],
    profilePic: json["profile_pic"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "contentId": contentId,
    "moneyType": moneyType,
    "category": category,
    "sub_cat": subCat,
    "description": description,
    "title": title,
    "video_path": videoPath,
    "thumbnail_path": thumbnailPath,
    "uploadedBy": uploadedBy,
    "uploadedAt": uploadedAt.toIso8601String(),
    "username": username,
    "profile_pic": profilePic,
  };
}

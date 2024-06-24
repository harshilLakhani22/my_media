class PostDataModel {
  int? id;
  String? contentId;
  String? moneyType;
  String? category;
  String? uploadedBy;
  String? uploadedAt;
  String? audioPath;
  String? creatorId;
  String? contentType;
  String? videoPath;
  String? thumbnailPath;
  String? subCat;
  String? description;
  String? title;
  String? textContent;
  String? username;
  String? profilePic;

  PostDataModel({
    this.id,
    this.contentId,
    this.moneyType,
    this.category,
    this.subCat,
    this.description,
    this.title,
    this.uploadedBy,
    this.uploadedAt,
    this.videoPath,
    this.thumbnailPath,
    this.audioPath,
    this.creatorId,
    this.contentType,
    this.textContent,
    this.username,
    this.profilePic,
  });

  PostDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    contentId = json['contentId'];
    moneyType = json['moneyType'];
    category = json['category'];
    subCat = json['sub_cat'];
    description = json['description'];
    title = json['title'];
    uploadedBy = json['uploadedBy'];
    uploadedAt = json['uploadedAt'];
    audioPath = json['audio_path'];
    videoPath = json['video_path'];
    thumbnailPath = json['thumbnail_path'];
    creatorId = json['creatorId'];
    contentType = json['content_type'];
    textContent = json['textContent'];
    username = json['username'];
    profilePic = json['profile_pic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['contentId'] = contentId;
    data['moneyType'] = moneyType;
    data['category'] = category;
    data['sub_cat'] = subCat;
    data['description'] = description;
    data['title'] = title;
    data['video_path'] = videoPath;
    data['thumbnail_path'] = thumbnailPath;
    data['sub_cat'] = subCat;
    data['description'] = description;
    data['title'] = title;
    data['video_path'] = videoPath;
    data['thumbnail_path'] = thumbnailPath;
    data['creatorId'] = creatorId;
    data['content_type'] = contentType;
    data['uploadedBy'] = uploadedBy;
    data['uploadedAt'] = uploadedAt;
    data['audio_path'] = audioPath;
    data['creatorId'] = creatorId;
    data['content_type'] = contentType;
    data['textContent'] = textContent;
    data['username'] = username;
    data['profile_pic'] = profilePic;
    return data;
  }
}

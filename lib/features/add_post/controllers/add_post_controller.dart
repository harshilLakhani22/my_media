import 'dart:convert';
import 'dart:io';

import 'package:coonch/common/methods/method.dart';
import 'package:coonch/common/widgets/loader_dialogue.dart';
import 'package:coonch/features/add_post/widgets/content_upload_success_dialog.dart';
import 'package:coonch/features/auth/models/user_data_model.dart';
import 'package:coonch/features/home/controllers/home_controller.dart';
import 'package:coonch/features/search/controllers/search_screen_controller.dart';
import 'package:coonch/utils/api/rest_api.dart';
import 'package:coonch/utils/constants/text_strings.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import "package:coonch/utils/local_storage/storage_utility.dart";

import 'package:coonch/features/setting/controllers/setting_controller.dart';

class AddPostController extends GetxController {
  TextEditingController messageController = TextEditingController();
  final RestAPI restAPI = Get.find<RestAPI>();
  RxString? assetPath = "".obs;
  UserModel? userDataModel;

  final HomeController homeController = Get.find<HomeController>();
  // final SearchScreenController searchScreenController =

  var selectedCategory = 'Entertainment'.obs;
  late final MLocalStorage localStorage;

  @override
  void onInit() {
    super.onInit();
    localStorage = Get.find<MLocalStorage>();
    userDataModel = Get.find<SettingController>().userDataModel?.value;

  }

  void setCategory(String category) {
    selectedCategory.value = category;
  }

  void clearController() {
    messageController.clear();
    selectedCategory.value = 'Entertainment';
  }

  String moneyType = 'free';

  String get orderType => moneyType;

  void setOrderType(String type) {
    moneyType = type;
    debugPrint("The order type is $moneyType");
    update();
  }

  Future<void> addTextPost() async {
    try {
      var response = await restAPI
          .postDataMethod("api/uploadContent/uploadTextContent", data: {
        "textContent": messageController.text,
        "moneyType": moneyType,
        "category": selectedCategory.value,
        "uploadedBy": userDataModel?.userid ?? ''
      }, headers: {
        'Authorization': "Bearer ${localStorage.getToken() ?? ''}"
      });
      debugPrint("addPost====>response::$response");
      if (response == null || response?.isEmpty) {
        showToast(title: "addTextPost response null or empty");
        return;
      }
      if (response['message'] == "Data inserted successfully") {
        homeController.getAllPostData();
        clearController();

        Get.find<SearchScreenController>()
            .searchUserProfileAPI(searchUserId: userDataModel?.userid ?? "");
        Get.back();
        contentUploadSuccessfullyDialog(
          Get.context!,
          title: MTexts.strTextUploadSuccessTitle,
          subTitle: MTexts.strTextUploadSuccessSubTitle,
        );
      } else {
        showToast(title: response.toString());
      }
    } catch (e) {
      showToast(title: "Something went wrong. Please try again!");
    }
  }

  Future<void> addAudioAssetPost() async {
    debugPrint("addAudioAssetPost=====>call");
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'http://109.199.105.248:7900/api/uploadContent/uploadAudioContent'));
    request.fields.addAll({
      'moneyType': moneyType,
      'category': selectedCategory.value,
      'uploadedBy': userDataModel?.userid ?? ''
    });
    request.files.add(await http.MultipartFile.fromPath(
        'audioContent', assetPath?.value ?? ''));

    http.StreamedResponse response = await request.send();
    dynamic responseDecoded = jsonDecode(await response.stream.bytesToString());
    debugPrint("addAudioAssetPost=====>response::$responseDecoded");
    if (response.statusCode == 200) {
      homeController.getAllPostData();
      clearController();
      Get.find<SearchScreenController>()
          .searchUserProfileAPI(searchUserId: userDataModel?.userid ?? "");
      Get.back();
      contentUploadSuccessfullyDialog(
        Get.context!,
        title: MTexts.strAudioUploadSuccessTitle,
        subTitle: MTexts.strAudioUploadSuccessSubTitle,
      );
    } else {
      showToast(title: responseDecoded['error']);
    }
  }

  XFile? tempPath;

  getVideoFromGallery() async {
    debugPrint("getVideoFromGallery=====>call");
    final ImagePicker picker = ImagePicker();
    tempPath = await picker.pickVideo(source: ImageSource.gallery);
    debugPrint("getVideoFromGallery=====>call tempPath::${tempPath?.path}");
    assetPath!.value = (tempPath?.path ?? '');
  }

  getAudioFromGallery() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.audio,
      // allowedExtensions: ['mp3', 'aac', 'wav'],
    );
    if (result?.files.isNotEmpty ?? false) {
      assetPath!.value = result?.files.first.path ?? "";
    }
  }

  /// generate jpeg thumbnail
  Future<Uint8List?> generateThumbnail(File file) async {
    final thumbnailAsUint8List = await VideoThumbnail.thumbnailData(
      video: file.path,
      imageFormat: ImageFormat.JPEG,
      maxWidth: 320,
      quality: 50,
    );
    return thumbnailAsUint8List!;
  }

  String getFileName() {
    File file = File(assetPath!.value);
    return basename(file.path);
  }



  Future<void> addVideoAssetPost() async {
// Create an HttpClient using the SecurityContext

    try {
      showLoader();
      var request = http.MultipartRequest(
          'POST',
          Uri.parse(
              'http://109.199.105.248:7900/api/uploadContent/uploadVideoContent'));
      Map<String, String> body = {
        'moneyType': moneyType,
        'title': 'nature',
        'description': 'video',
        'category': selectedCategory.value,
        'sub_cat': 'all subjects',
        'uploadedBy': userDataModel?.userid ?? ''
      };

      debugPrint("${localStorage.getToken()}");
      request.headers
          .addAll({'Authorization': "Bearer ${localStorage.getToken() ?? ''}"});
      final Map<String, String> mappedBody =
          body.map((k, v) => MapEntry(k.toString(), v.toString()));
      request.fields.addAll(mappedBody);
      debugPrint("addPost====>body:$mappedBody");
      Uint8List? thumbnailData =
          await generateThumbnail(File(assetPath?.value ?? ''));
      Uint8List? fileBytes = await tempPath?.readAsBytes();
      final http.MultipartFile videoRequest = http.MultipartFile.fromBytes(
        'content',
        fileBytes!.toList(),
        filename: "${tempPath?.name}",
        contentType: MediaType("video", "mp4"),
      );

      final http.MultipartFile thumbNaiRequest = http.MultipartFile.fromBytes(
        'thumbnail',
        thumbnailData!.toList(),
        filename: "${tempPath?.name}",
        contentType: MediaType("photo", "jpeg"),
      );
      request.files.add(videoRequest);
      request.files.add(thumbNaiRequest);

      http.StreamedResponse response = await request.send();
      http.Response response3 = await http.Response.fromStream(response);
      dynamic responseDecoded = jsonDecode(response3.body);

      if (response3.statusCode == 200) {
        homeController.getAllPostData();
        clearController();

        dismissLoader();
        Get.back();
        contentUploadSuccessfullyDialog(
          Get.context!,
          title: MTexts.strVideoUploadSuccessTitle,
          subTitle: MTexts.strVideoUploadSuccessSubTitle,
        );
        Get.find<SearchScreenController>()
            .searchUserProfileAPI(searchUserId: userDataModel?.userid ?? "");
      } else {
        dismissLoader();
        showToast(title: responseDecoded['error']);
      }
    } catch (e) {
      dismissLoader();
      showToast(title: "Error");
    }
  }
}

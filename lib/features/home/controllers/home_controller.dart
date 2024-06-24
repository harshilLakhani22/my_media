import 'package:coonch/common/methods/method.dart';
import 'package:coonch/features/auth/models/user_data_model.dart';
import 'package:coonch/features/home/models/post_data_model.dart';
import "package:coonch/features/setting/controllers/setting_controller.dart";
import 'package:coonch/utils/api/rest_api.dart';
import 'package:coonch/utils/local_storage/storage_utility.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxInt currIndex = 0.obs;
  RxBool isExpanded = false.obs;
  final RestAPI restAPI = Get.find<RestAPI>();
  RxList<PostDataModel> postDataModelList = <PostDataModel>[].obs;
  final List<Map<String, dynamic>> choiceItem = [
    {"name": "All", "value": 0, "filter": "all"},
    {"name": "Video", "value": 1, "filter": "video"},
    {"name": "Audio", "value": 2, "filter": "audio"},
    {"name": "Text", "value": 3, "filter": "text"}
  ];

  late final MLocalStorage localStorage;
  Rx<UserModel>? currUser = UserModel().obs;

  // Variables for pagination
  int currentPage = 0;
  final int pageSize = 10;
  bool isLoading = false;
  bool hasMore = true;

  @override
  void onInit() {
    super.onInit();
    localStorage = Get.find<MLocalStorage>();
    currUser = UserModel.fromJson(localStorage.getUserData()).obs;
    getAllPostData(); // Initial load
  }

  Future<bool> checkIfFollow(
      {required String searchedUserId}) async {


    try {
      var response =
          await restAPI.postDataMethod("api/follow/checkIfFollow", data: {
        "myId": currUser?.value.id ?? "",
        "otherId": searchedUserId,
      }, headers: {
        'Authorization': "Bearer ${localStorage.getToken() ?? ''}"
      });

      debugPrint("checkIfFollow====>response::$response");
      if (response == null || response?.isEmpty) {
        showToast(title: "addTextPost response null or empty");
        return false;
      }
      return response['follows'] ?? false;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  void getAllPostData(
      {String selectedCategory = "all", bool isRefresh = false}) async {
    if (isLoading) return; // Prevent multiple simultaneous requests

    isLoading = true;
    if (isRefresh) {
      currentPage = 0;
      hasMore = true;
      postDataModelList.clear();
    }

    UserModel? userDataModel;
    if (Get.isRegistered<SettingController>()) {
      userDataModel = Get.find<SettingController>().userDataModel?.value;
    }
    var response =
        await restAPI.postDataMethod("api/getposts/fetchallFreePosts", data: {
      "userId": userDataModel?.userid ?? '',
      "page": currentPage.toString(),
      "pageSize": pageSize.toString(),
      "filters": selectedCategory,
    }, headers: {
      'Authorization': "Bearer ${localStorage.getToken() ?? ''}"
    });
    if (response == null || response?.isEmpty) {
      showToast(title: "getAllPostData Response null or Empty123");
      isLoading = false;
      return;
    }
    if (response?.isNotEmpty ?? false) {
      List? responseList = response ?? [];
      if (responseList!.isNotEmpty) {
        List<PostDataModel> tempPostDataList =
            responseList.map((e) => PostDataModel.fromJson(e)).toList();
        if (isRefresh) {
          postDataModelList.value = tempPostDataList;
        } else {
          postDataModelList.addAll(tempPostDataList);
        }
        for (var post in tempPostDataList) {
          debugPrint("Profile Picture URL: ${post.profilePic}");
          debugPrint("Profile username : ${post.username}");
        }

        if (tempPostDataList.length < pageSize) {
          hasMore = false; // No more data to load
        }
        currentPage++;
      } else {
        hasMore = false;
        showToast(title: response['error'].toString());
      }
    } else {
      showToast(title: response['error'].toString());
    }
    isLoading = false;
  }

  void changeTab(int index) {
    currIndex.value = index;
  }
}

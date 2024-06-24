import 'package:coonch/api.dart';
import 'package:coonch/common/methods/method.dart';
import 'package:coonch/features/auth/models/user_data_model.dart';
import 'package:coonch/features/home/models/audio_model.dart';
import 'package:coonch/features/home/models/text_model.dart';
import 'package:coonch/features/home/models/video_model.dart';
import 'package:coonch/features/search/model/search_result.dart';
import 'package:coonch/features/search/model/search_user_profile_result.dart';
import 'package:coonch/utils/api/rest_api.dart';
import 'package:coonch/utils/local_storage/storage_utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../setting/controllers/setting_controller.dart';

class SearchScreenController extends GetxController {
  TextEditingController searchProfileController = TextEditingController();
  final RestAPI restAPI = Get.find<RestAPI>();

  Rx<UserModel>? searchedUser = UserModel().obs;
  Rx<UserModel>? loggedInUser = UserModel().obs;
  List<SearchResultModel> searchResults = <SearchResultModel>[];
  var userProfileResult = Rxn<SearchUserProfileResult>();
  RxBool isLoading = false.obs;
  RxBool isSearchStart = false.obs;
  late final MLocalStorage localStorage;
  RxInt currIndex = 0.obs;
  var videos = <VideoModel>[].obs;
  var audios = <AudioModel>[].obs;
  var texts = <TextModel>[].obs;
  var filteredVideos = <VideoModel>[].obs;
  var filteredAudios = <AudioModel>[].obs;
  var filteredTexts = <TextModel>[].obs;

  final List<Map<String, dynamic>> choiceItem = [
    {
      "name": "Video",
      "value": 0,
    },
    {
      "name": "Audio",
      "value": 1,
    },
    {
      "name": "Text",
      "value": 2,
    }
  ];

  void changeTab(int index) {
    currIndex.value = index;
  }

  @override
  void onInit() {
    super.onInit();
    localStorage = Get.find<MLocalStorage>();
    loggedInUser = UserModel
        .fromJson(localStorage.getUserData())
        .obs;
    searchProfileController.addListener(() {
      if (searchProfileController.text.isNotEmpty) {
        searchUserAPI();
      }
    });
  }

  void cleanSearchResult() {
    searchProfileController.clear();
    searchResults.clear();
  }

  /// Searching List
  Future<void> searchUserAPI() async {
    UserModel? userDataModel;
    if (Get.isRegistered<SettingController>()) {
      userDataModel = Get
          .find<SettingController>()
          .userDataModel
          ?.value;
    }
    searchResults.clear();
    isSearchStart.value = false;
    var response = await restAPI.postDataMethod(
        "${APIConstants.strDefaultSearchPath}searchUser",
        data: {
          "searchString": searchProfileController.text,
          "myId": userDataModel?.userid ?? ''
        },
        headers: {
          'Authorization': "Bearer ${localStorage.getToken() ?? ''}"
        });
    debugPrint("searchUserAPI=====> response:: $response");
    debugPrint(userDataModel?.userid ?? '');

    if (response == null || response?.isEmpty) {
      isSearchStart.value = true;
      showToast(title: "searchUserAPI response null or empty");
      return;
    }
    isSearchStart.value = true;
    for (var user in response) {
      SearchResultModel model = SearchResultModel.fromJson(user);
      searchResults.add(model);

      // Retrieve the value of following and print or store it as needed
      bool isFollowing = user['following'];
      String subscription = user['subscription'];
      debugPrint('User ID: ${user['userid']}, Following: $isFollowing');
      debugPrint(
          'User ID: ${user['subscription']}, subscription: $subscription');
    }

    update();
  }

  /// Searched User Profile Get Contents For Search Person
  Future<void> searchUserProfileAPI({
    required String searchUserId,
    Function()? callback,
    String moneyType = 'free',
    Function()? callback2,
    Function()? callback3,
  }) async {
    callback2!();
    var response = await restAPI.postDataMethod("api/getposts/getMyPosts",
        data: {
          "userId": searchUserId,
          "page": 0,
          "pageSize": 2,
          "moneyType": moneyType
        },
        headers: {
          'Authorization': "Bearer ${localStorage.getToken() ?? ''}"
        });

    if (response != null) {
      // Filter and assign the content based on moneyType
      List<dynamic> filteredAudios = [];
      List<dynamic> filteredVideos = [];
      List<dynamic> filteredTexts = [];

      if (response.containsKey('audios')) {
        filteredAudios = response['audios']
            .where((audio) => audio['moneyType'] == moneyType)
            .toList();
        debugPrint("filteredAudios :: --> $filteredAudios");
      }

      if (response.containsKey('videos')) {
        filteredVideos = response['videos']
            .where((video) => video['moneyType'] == moneyType)
            .toList();
        debugPrint("filteredVideos :: --> $filteredVideos");
      }

      if (response.containsKey('text')) {
        filteredTexts = response['text']
            .where((text) => text['moneyType'] == moneyType)
            .toList();
        debugPrint("filteredTexts :: --> $filteredTexts");
      }

      // Assign the filtered content to the userProfileResult
      userProfileResult.value = SearchUserProfileResult.fromJson({
        'audios': filteredAudios,
        'videos': filteredVideos,
        'text': filteredTexts
      });
      debugPrint(
          "userProfileResult.value videos :: --> ${userProfileResult.value!
              .videos}");
      debugPrint(
          "userProfileResult.value text :: --> ${userProfileResult.value!
              .text}");
      debugPrint(
          "userProfileResult.value audios  :: --> ${userProfileResult.value!
              .audios}");
      debugPrint(" searchUserProfileAPI response :: --> $response");
      isLoading.value = false;
      update(["searchedProfilePage"]);
      if (callback != null) {
        callback();
      }
      callback3!();

    } else {
      debugPrint("searchUserProfileAPI response is null or empty");
      showToast(title: "searchUserProfileAPI response is null or empty");
     callback3!();
    }
  }

  Future<void> followUserAPI(
      {required String followingId, required String followId}) async {
    try {
      var response = await restAPI.postDataMethod("api/follow/follow", data: {
        "followingid": followingId,
        "followid": followId,
      }, headers: {
        'Authorization': "Bearer ${localStorage.getToken() ?? ''}"
      });

      if (response['message'] == "Successfully followed new person") {
        showToast(title: "Successfully followed new person");
      } else {
        showToast(title: "Something Went Wrong", subTitle: response['message']);
      }
    }catch (e){
      print(e.toString());
    }
  }
}

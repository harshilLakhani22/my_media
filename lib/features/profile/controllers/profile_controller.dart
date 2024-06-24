import 'package:basic_utils/basic_utils.dart';
import 'package:coonch/api.dart';
import 'package:coonch/common/methods/method.dart';
import 'package:coonch/common/widgets/loader_dialogue.dart';
import 'package:coonch/features/auth/models/user_data_model.dart';
import 'package:coonch/features/search/controllers/search_screen_controller.dart';
import 'package:coonch/features/search/model/search_user_profile_result.dart';
import 'package:coonch/utils/api/rest_api.dart';
import 'package:coonch/utils/constants/text_strings.dart';
import 'package:coonch/utils/local_storage/storage_utility.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  RxInt currIndex = 0.obs;
  RxBool isExpanded = false.obs;
  RxBool isPasswordHidden = true.obs;
  RxBool isConPasswordHidden = true.obs;
  final RestAPI restAPI = Get.find<RestAPI>();
  TextEditingController editProfileFirstNameController =
      TextEditingController();
  TextEditingController editProfileLastNameController = TextEditingController();
  TextEditingController editProfileBioController = TextEditingController();
  TextEditingController editProfilePhoneController = TextEditingController();
  TextEditingController editProfileNewPasswordController =
      TextEditingController();
  TextEditingController editProfileConfirmPasswordController =
      TextEditingController();
  Rx<UserModel>? userDataModel = UserModel().obs;
  Rx<UserModel>? otherUser = UserModel().obs;
  RxBool isLoading = false.obs;

  late final MLocalStorage localStorage;
  final SearchScreenController searchController = Get.find<SearchScreenController>();


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

  // -- show more & show less
  void toggleExpansion() {
    isExpanded.value = !isExpanded.value;
  }

  @override
  void onInit() {
    super.onInit();
    localStorage = Get.find<MLocalStorage>();
    userDataModel = UserModel.fromJson(localStorage.getUserData()).obs;
    // fetchLoggedInUserProfile();
  }

  setUserProfileData() {
    editProfileFirstNameController.text =
        userDataModel?.value.displayName ?? '';
    editProfileLastNameController.text =
        userDataModel?.value.username ?? '';
    editProfileBioController.text = userDataModel?.value.bio ?? '';
    editProfilePhoneController.text = userDataModel?.value.phone ?? '';
  }

  clearPassword() {
    editProfileNewPasswordController.clear();
    editProfileConfirmPasswordController.clear();
  }

  var userProfileResult = Rxn<SearchUserProfileResult>();


  /// Searched User Profile Get Contents For Own Profile Screen
  Future<void> searchOwnProfileAPI({
    required String searchUserId,
    Function()? callback,
    String moneyType = 'free',
  }) async {
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
      // callback3!();

    } else {
      debugPrint("searchUserProfileAPI response is null or empty");
      showToast(title: "searchUserProfileAPI response is null or empty");
      // callback3!();
    }
  }


  /// Edit profile
  Future<void> callUpdateProfile() async {
    showLoader();
    var response = await restAPI.postDataMethod(
        "${APIConstants.strDefaultAuthPath}/editprofile",
        data: {
          "userid": userDataModel?.value.userid ?? '',
          "display_name": editProfileFirstNameController.text,
          "email": userDataModel?.value.email ?? '',
          "bio": editProfileBioController.text,
          "phone": editProfilePhoneController.text
        },
        headers: {
          'Authorization': "Bearer ${localStorage.getToken() ?? ''}"
        });

    if (response == null || response?.isEmpty) {
      showToast(title: "callUpdateProfile response null or empty");
      return;
    }
    debugPrint("callUpdateProfile=====>response::$response");
    if (response['message'] == "Profile updated successfully.") {
      await callGetProfile(
        callback: () {
          dismissLoader();
          dismissLoader();
        },
      );
      showToast(title: response['message']);
    } else {
      dismissLoader();
      showToast(title: response.error.toString());
    }
  }

  /// Get Searched User Profile Info
  Future<void> callGetProfile(
      {String? otherUserId, Function()? callback}) async {

    isLoading.value = true;
    var response = await restAPI.postDataMethod(
        "${APIConstants.strDefaultAuthPath}/getuserInfo",
        data: {
          "userid": otherUserId ?? userDataModel?.value.userid ?? '',
        },
        headers: {
          'Authorization': "Bearer ${localStorage.getToken() ?? ''}"
        });

    debugPrint("callGetProfile=====>response::$response");
    debugPrint("otherUserId::$otherUserId");
    debugPrint("userId::${userDataModel?.value.userid}");
    // print("userToken::${userDataModel?.value.token}");

    if (response != null) {
      if (otherUserId == null) {
        userDataModel!.value = UserModel.fromJson(response);
        userDataModel!.refresh();
      } else {
        debugPrint("otheruserId Data is Set");
        otherUser?.value = UserModel.fromJson(response);
      }
      if (callback != null) {
        callback();
      }
    } else {
      if (response == null || response?.isEmpty) {
        debugPrint("callGetProfile response is null");
        showToast(title: "callGetProfile response is null");
        return;
      }
    }
    isLoading.value = false;
  }


  /// Change Password
  Future<void> changePasswordAPI() async {
    var response = await restAPI.postDataMethod(
        "${APIConstants.strDefaultAuthPath}/resetpassword",
        data: {
          "email": userDataModel?.value.email ?? "",
          "oldpass": editProfileNewPasswordController.text,

          /// Problem
          "newpass": editProfileConfirmPasswordController.text
        },
        headers: {
          'Authorization': "Bearer ${localStorage.getToken() ?? ''}"
        });
    debugPrint("changePasswordAPI=====>response::$response");
    if (response == null || response?.isEmpty) {
      showToast(title: "changePasswordAPI response null or empty");
      return;
    }
    if (response['message'] == "Password updated successfully.") {
      Get.back();
      showToast(title: response['message']);
    } else {
      showToast(title: response['error'].toString());
    }
  }

  /// Change Password Validation
  bool onChangePasswordScreenValidation() {
    if (StringUtils.isNullOrEmpty(editProfileNewPasswordController.text)) {
      showToast(title: MTexts.strPlzEnterEmail);
      return false;
    }
    if (StringUtils.isNullOrEmpty(editProfileConfirmPasswordController.text)) {
      showToast(title: MTexts.strPlzEnterPassword);
      return false;
    }
    if (editProfileConfirmPasswordController.text.toString() !=
        editProfileConfirmPasswordController.text.toString()) {
      showToast(title: MTexts.strPasswordNotMatched);
      return false;
    }
    return true;
  }
}

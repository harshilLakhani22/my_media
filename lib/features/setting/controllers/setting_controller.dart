import 'package:coonch/common/methods/method.dart';
import 'package:coonch/features/add_post/widgets/content_upload_success_dialog.dart';
import 'package:coonch/features/auth/models/user_data_model.dart';
import 'package:coonch/utils/api/rest_api.dart';
import 'package:coonch/utils/constants/text_strings.dart';
import 'package:coonch/utils/local_storage/storage_utility.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class SettingController extends GetxController {
  final valueOfSwitch = true.obs;
  final RestAPI restAPI = Get.find<RestAPI>();

  Rx<UserModel>? userDataModel = UserModel().obs;

  late final MLocalStorage localStorage;

  @override
  void onInit() {
    super.onInit();
    localStorage = Get.find<MLocalStorage>();
    userDataModel = UserModel.fromJson(localStorage.getUserData()).obs;
  }

  void clearUserData(){
    localStorage.removeUserData();
  }

  void toggleSwitch(bool value) {
    valueOfSwitch.value = value;
  }

  Future<void> subscribeCreatorAPI(String? creatorUserId, bool isGold) async {
    debugPrint("creatorUserId : --> $creatorUserId");
    debugPrint("subscriberId : --> ${userDataModel?.value.userid}");
    debugPrint("isGold ---> $isGold");

    var response =
        await restAPI.postDataMethod("api/subscribe/subscribeCreator", data: {
      "subscriberId": userDataModel?.value.userid ?? '',
      "creatorId": creatorUserId ?? '',
      "plan_type": isGold ? 'gold' : 'silver',
    }, headers: {
      'Authorization': "Bearer ${localStorage.getToken() ?? ''}"
    });

    debugPrint("subscribeCreatorAPI =====> response:: $response");

    if (response == null || response?.isEmpty) {
      showToast(title: "subscribeCreatorAPI response null or empty");
      return;
    }

    if (response['message'] == "Already subscribed") {
      showToast(title: response['message']);
    } else {
      contentUploadSuccessfullyDialog(
        Get.context!,
        title: MTexts.strSubscribeSuccessfullyTitle,
        subTitle: MTexts.strSubscribeSuccessfullySubTitle,
      );
    }
  }
}

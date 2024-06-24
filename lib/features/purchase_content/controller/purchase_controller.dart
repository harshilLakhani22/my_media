import 'package:coonch/common/methods/method.dart';
import 'package:coonch/features/auth/models/user_data_model.dart';
import 'package:coonch/utils/api/rest_api.dart';
import 'package:coonch/utils/local_storage/storage_utility.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class PurchaseController extends GetxController {
  final RestAPI restAPI = Get.find<RestAPI>();
  late final MLocalStorage localStorage;

  Rx<UserModel>? userDataModel = UserModel().obs;


  @override
  void onInit(){
    super.onInit();
    localStorage = Get.find<MLocalStorage>();
    userDataModel = UserModel.fromJson(localStorage.getUserData()).obs;
  }

  Future<void> purchaseContentAPI({
    required String creatorId,
    required String planType,
    required String contentId,
    required String contentType,
  }) async {
    try{
      var response = await restAPI.postDataMethod(
        "api/subscribe/selectContent",
        data: {
          "creatorId": creatorId,
          "subscriberId": userDataModel?.value.userid ?? "",
          "plan_type": planType,
          "contentId": contentId,
          "content_type": contentType,
        },
        headers: {'Authorization': "Bearer ${localStorage.getToken() ?? ''}"},
      );

      debugPrint("purchaseContentAPI response =====> response:: $response");
      debugPrint("subscriberId for purchaseContentAPI :: ${userDataModel?.value.userid}");
      debugPrint("creatorId for purchaseContentAPI :: $creatorId");
      debugPrint("planType for purchaseContentAPI :: $planType");
      debugPrint("contentId for purchaseContentAPI :: $contentId");
      debugPrint("contentType for purchaseContentAPI :: $contentType");

      if (response == null || response.isEmpty) {
        Get.back();
        showToast(title: "Error: Response is null or empty");
      }

      if (response.containsKey('error')) {
        showToast(title: "Something Went Wrong!", subTitle: response['error']);
        Get.back();
      } else {
        showToast(title: "Success", subTitle: "Content purchased successfully");
        Get.back();
      }
    } catch (e){
      debugPrint(e.toString());
      showToast(title: "Error: $e");
      return;
    }

  }
}

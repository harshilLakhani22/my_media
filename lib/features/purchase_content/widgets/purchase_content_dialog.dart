import 'package:coonch/features/purchase_content/controller/purchase_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final PurchaseController purchaseController = Get.find<PurchaseController>();

void purchaseContentDialog(
  BuildContext context, {
  required String contentId,
  required String planType,
  required String creatorId,
}) {
  showDialog(
    context: context,
    builder: (context) {
      Widget cancelButton = TextButton(
        child: const Text("Cancel"),
        onPressed: () => Get.back(),
      );
      Widget continueButton = TextButton(
        child: const Text("Continue"),
        onPressed: () async {
          await purchaseController.purchaseContentAPI(
            contentType: "video",
            contentId: contentId,
            planType: planType,
            creatorId: creatorId,
          );
          Get.back();
        },
      );
      return AlertDialog(
        title: const Text("Purchase Content!"),
        content: const Text("Are you sure you want to purchase this content."),
        actions: [
          cancelButton,
          continueButton,
        ],
      );
    },
  );
}

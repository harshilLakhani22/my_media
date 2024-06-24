import 'package:coonch/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showLoader() {
  Get.dialog(
    PopScope(
      canPop: false,
      child: UnconstrainedBox(
        child: Container(
          height: 100,
          width: 150,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Center(
            child: CircularProgressIndicator(color: MColors.buttonPrimary),
          ),
        ),
      ),
    ),
    barrierDismissible: false,
  );
}

void dismissLoader() {
  Get.back();
}

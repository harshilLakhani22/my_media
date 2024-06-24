import 'dart:io';

import 'package:basic_utils/basic_utils.dart';
import 'package:coonch/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

/// Showing the toast with custom fields
void showToast({
  required String title,
  String? subTitle,
  SnackPosition? position,
}) {
  if (Get.isSnackbarOpen) {
    Get.closeAllSnackbars();
  }
  Get.snackbar(
    title,
    subTitle ?? '',
    messageText:
        StringUtils.isNullOrEmpty(subTitle) ? const SizedBox.shrink() : null,
    colorText: Colors.white,
    backgroundColor: MColors.darkerGrey,
    snackPosition: position ?? SnackPosition.BOTTOM,
    duration: const Duration(seconds: 1),
    padding: const EdgeInsets.all(15),
    margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
  );
}

/// Image Picker from the gallery
// Future<XFile?> pickImage() async {
//   final _picker = ImagePicker();
//   final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
//   if (pickedFile == null) return null; // User canceled picking image
//   final croppedFile = await ImageCropper().cropImage(
//     sourcePath: pickedFile.path,
//     aspectRatioPresets: [
//       CropAspectRatioPreset.square,
//     ],
//     uiSettings: [AndroidUiSettings(
//       toolbarTitle: 'Crop Image',
//       toolbarColor: Colors.deepOrange,
//       toolbarWidgetColor: Colors.white,
//       initAspectRatio: CropAspectRatioPreset.square,
//       lockAspectRatio: true,
//     ),
//    IOSUiSettings(
//       minimumAspectRatio: 1.0,
//     )]
//   );
//   return croppedFile == null ? null : XFile(croppedFile.path);
// }
Future<XFile?> pickImage() async {
  final picker = ImagePicker();
  final pickedFile = await picker.pickImage(source: ImageSource.gallery);
  return pickedFile;
}

Future<File> convertXFileToFile(XFile xFile) async {
  final bytes = await xFile.readAsBytes();
  return File(xFile.path).writeAsBytes(bytes);
}

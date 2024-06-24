import 'package:coonch/common/widgets/common_elevated_button.dart';
import 'package:coonch/utils/constants/image_strings.dart';
import 'package:coonch/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

void contentUploadSuccessfullyDialog(BuildContext context,
    {required String title, required String subTitle}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: SvgPicture.asset(MImages.imgVideoUploadSuccessfully),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
             Text(
         title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: MSizes.fontSizeLg, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: MSizes.spaceBtwTexts),
            Text(subTitle,
            textAlign: TextAlign.start,),
            const SizedBox(height: MSizes.spaceBtwSections),
            CommonElevatedButton(onPressed: () => Get.back(), title: "OK"),
          ],
        ),
      );
    },
  );
}

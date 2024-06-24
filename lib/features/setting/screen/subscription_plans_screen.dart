import 'package:coonch/common/widgets/common_elevated_button.dart';
import 'package:coonch/features/setting/controllers/setting_controller.dart';
import 'package:coonch/features/setting/widgets/text_with_blue_tik.dart';
import 'package:coonch/utils/constants/colors.dart';
import 'package:coonch/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubscriptionPlansScreen extends StatelessWidget {
  SubscriptionPlansScreen({
    super.key,
    this.creatorUserId,
  });

  final String? creatorUserId;

  final SettingController settingController = Get.find<SettingController>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: MSizes.spaceBtwSections),
          /// Basic
          Container(
            padding: const EdgeInsets.all(MSizes.defaultSpace),
            decoration: BoxDecoration(
                color: MColors.white,
                borderRadius: BorderRadius.circular(MSizes.borderRadiusLg)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Basic",
                  style: TextStyle(
                    fontSize: MSizes.fontSizeTitleSm,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: MSizes.spaceBtwTexts),
                const Text(
                  "Features",
                  style: TextStyle(
                    fontSize: MSizes.fontSizeMd,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: MSizes.spaceBtwTexts),
                const TextWithBlueTik(text: "Access to limited content."),
                const TextWithBlueTik(
                    text: "Limited profile customization options."),
                const TextWithBlueTik(
                    text: "Option to earn rewards and points."),
                const TextWithBlueTik(
                    text: "Restricted to a few levels within each section."),
                const SizedBox(height: MSizes.spaceBtwTexts),
                const Text(
                  "\$0",
                  style: TextStyle(
                    fontSize: MSizes.fontSizeTitleSm,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: MSizes.spaceBtwSections / 2),
                CommonElevatedButton(
                    onPressed: () {}, title: "Start Free Trial")
              ],
            ),
          ),
          const SizedBox(height: MSizes.spaceBtwSections),

          /// Silver
          Container(
            padding: const EdgeInsets.all(MSizes.defaultSpace),
            decoration: BoxDecoration(
                color: MColors.white,
                borderRadius: BorderRadius.circular(MSizes.borderRadiusLg)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Silver",
                  style: TextStyle(
                    fontSize: MSizes.fontSizeTitleSm,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: MSizes.spaceBtwTexts),
                const Text(
                  "Features",
                  style: TextStyle(
                    fontSize: MSizes.fontSizeMd,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: MSizes.spaceBtwTexts),
                const TextWithBlueTik(text: "Upload own content"),
                const TextWithBlueTik(text: "View other users' profiles"),
                const TextWithBlueTik(
                    text: "Enhanced profile customization options"),
                const TextWithBlueTik(
                    text: "Access to more content levels within each section"),
                const SizedBox(height: MSizes.spaceBtwTexts),
                const Text(
                  "\$1/month",
                  style: TextStyle(
                    fontSize: MSizes.fontSizeTitleSm,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: MSizes.spaceBtwSections / 2),
                CommonElevatedButton(onPressed: () {
                  debugPrint("callong subscribeCreatorAPI");
                  settingController.subscribeCreatorAPI(creatorUserId, false);
                }, title: "Subscribe")
              ],
            ),
          ),
          const SizedBox(height: MSizes.spaceBtwSections),

          /// Gold
          Container(
            padding: const EdgeInsets.all(MSizes.defaultSpace),
            decoration: BoxDecoration(
                color: MColors.white,
                borderRadius: BorderRadius.circular(MSizes.borderRadiusLg)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Gold",
                  style: TextStyle(
                    fontSize: MSizes.fontSizeTitleSm,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: MSizes.spaceBtwTexts),
                const Text(
                  "Features",
                  style: TextStyle(
                    fontSize: MSizes.fontSizeMd,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: MSizes.spaceBtwTexts),
                const TextWithBlueTik(
                    text: "All features from the Silver level"),
                const TextWithBlueTik(
                    text: "Access to all content levels within each section"),
                const TextWithBlueTik(text: "Priority customer support"),
                const TextWithBlueTik(text: "Exclusive rewards and points"),
                const SizedBox(height: MSizes.spaceBtwTexts),
                const Text(
                  "\$3/month",
                  style: TextStyle(
                    fontSize: MSizes.fontSizeTitleSm,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: MSizes.spaceBtwSections / 2),
                CommonElevatedButton(onPressed: () {
                  debugPrint("callong subscribeCreatorAPI");
                  settingController.subscribeCreatorAPI(creatorUserId, true);
                }, title: "Subscribe")
              ],
            ),
          ),
        ],
      ),
    );
  }
}

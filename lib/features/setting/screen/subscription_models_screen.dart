import 'package:coonch/common/widgets/common_elevated_button.dart';
import 'package:coonch/features/setting/widgets/text_with_blue_tik.dart';
import 'package:coonch/utils/constants/colors.dart';
import 'package:coonch/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class SubscriptionModelsScreen extends StatelessWidget {
  const SubscriptionModelsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: MSizes.spaceBtwSections),

          /// Free Trial Phase
          Container(
            padding: const EdgeInsets.all(MSizes.defaultSpace),
            decoration: BoxDecoration(
                color: MColors.white,
                borderRadius: BorderRadius.circular(MSizes.borderRadiusLg)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Free Trial Phase",
                  style: TextStyle(
                    fontSize: MSizes.fontSizeTitleSm,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: MSizes.spaceBtwTexts),
                const Text(
                    "Sign up now for a free trial period to explore all features of our app!"),
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
                    text:
                        "Limited access to premium content during the trial period."),
                const SizedBox(height: MSizes.spaceBtwTexts),
                const Text(
                  "Duration",
                  style: TextStyle(
                    fontSize: MSizes.fontSizeMd,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: MSizes.spaceBtwTexts),
                const TextWithBlueTik(
                    text:
                    "Specify the duration of the free trial period, 7 days."),
                const Text(
                  "\$0",
                  style: TextStyle(
                    fontSize: MSizes.fontSizeTitleSm,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: MSizes.spaceBtwSections / 2),
                CommonElevatedButton(
                    onPressed: () {}, title: "Select")
              ],
            ),
          ),
          const SizedBox(height: MSizes.spaceBtwSections),

          /// Monthly Payments Phase
          Container(
            padding: const EdgeInsets.all(MSizes.defaultSpace),
            decoration: BoxDecoration(
                color: MColors.white,
                borderRadius: BorderRadius.circular(MSizes.borderRadiusLg)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Monthly Payments Phase",
                  style: TextStyle(
                    fontSize: MSizes.fontSizeTitleSm,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: MSizes.spaceBtwTexts),
                const Text(
                    "After the free trial, continue enjoying all features with our monthly subscription plan."),
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
                    text:
                    "Automatic monthly payments charged to your preferred payment method"),
                const SizedBox(height: MSizes.spaceBtwTexts),
                const Text(
                  "Duration",
                  style: TextStyle(
                    fontSize: MSizes.fontSizeMd,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: MSizes.spaceBtwTexts),
                const TextWithBlueTik(
                    text:
                    "Specify the price for the monthly subscription"),
                const Text(
                  "\$5/month",
                  style: TextStyle(
                    fontSize: MSizes.fontSizeTitleSm,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: MSizes.spaceBtwSections / 2),
                CommonElevatedButton(
                    onPressed: () {}, title: "Select")
              ],
            ),
          ),
          const SizedBox(height: MSizes.spaceBtwSections),

          /// 6-Monthly or Yearly Payments Phase
          Container(
            padding: const EdgeInsets.all(MSizes.defaultSpace),
            decoration: BoxDecoration(
                color: MColors.white,
                borderRadius: BorderRadius.circular(MSizes.borderRadiusLg)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "6-Monthly or Yearly Payments Phase",
                  style: TextStyle(
                    fontSize: MSizes.fontSizeTitleSm,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: MSizes.spaceBtwTexts),
                const Text(
                    "Upgrade to our discounted 6-monthly or yearly subscription plan for additional savings!"),
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
                    text:
                    "Flexible upgrade and downgrade options available."),
                const SizedBox(height: MSizes.spaceBtwTexts),
                const Text(
                  "Duration",
                  style: TextStyle(
                    fontSize: MSizes.fontSizeMd,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: MSizes.spaceBtwTexts),
                const TextWithBlueTik(
                    text:
                    "Specify the price for the 6-monthly or yearly subscription, e.g., \$25 for 6 months, \$45 for a year"),
                const Text(
                  "\$25 for 6 months, \$45 for a year",
                  style: TextStyle(
                    fontSize: MSizes.fontSizeTitleSm,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: MSizes.spaceBtwSections / 2),
                CommonElevatedButton(
                    onPressed: () {}, title: "Select")
              ],
            ),
          ),
        ],
      ),
    );
  }
}

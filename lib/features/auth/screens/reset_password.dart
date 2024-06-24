import 'package:coonch/common/widgets/common_elevated_button.dart';
import 'package:coonch/common/widgets/common_text_field.dart';
import 'package:coonch/features/auth/controllers/auth_controller.dart';
import 'package:coonch/features/auth/widgets/auth_heading.dart';
import 'package:coonch/features/auth/widgets/term_and_policy.dart';
import 'package:coonch/utils/constants/sizes.dart';
import 'package:coonch/utils/constants/text_strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({super.key});

  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: Get.back,
          icon: const Icon(CupertinoIcons.back),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(MSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Heading
            const AuthHeading(
                title: MTexts.strResetPassword,
                subTitle: MTexts.strResetPasswordSubTitle),

            /// Email
            CommonTextField(
              controller: authController.resetEmailController,
              hint: MTexts.strEmail,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: MSizes.spaceBtwSections),

            /// Submit
            CommonElevatedButton(
              onPressed: () {
                if (authController.onResetEmailScreenValidation()) {
                  authController.forgotPasswordOTPApi();
                }
              },
              title: MTexts.strSubmit,
            ),

            const Spacer(),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TermAndPolicy(onTermTap: () {}, onPolicyTap: () {}),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

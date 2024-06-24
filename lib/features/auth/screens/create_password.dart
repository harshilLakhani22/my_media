import 'package:coonch/common/widgets/common_elevated_button.dart';
import 'package:coonch/common/widgets/common_text_field.dart';
import 'package:coonch/features/auth/controllers/auth_controller.dart';
import 'package:coonch/features/auth/widgets/auth_heading.dart';
import 'package:coonch/features/auth/widgets/term_and_policy.dart';
import 'package:coonch/utils/constants/colors.dart';
import 'package:coonch/utils/constants/sizes.dart';
import 'package:coonch/utils/constants/text_strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CreatePasswordScreen extends StatelessWidget {
  CreatePasswordScreen({super.key});

  final AuthController authController = Get.find<AuthController>();
  final RxBool isPasswordVisible = false.obs;
  final RxBool isConfirmPasswordVisible = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: Get.back, icon: const Icon(CupertinoIcons.back)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(MSizes.defaultSpace),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Heading
              const AuthHeading(
                  title: MTexts.strCreatePassword,
                  subTitle: MTexts.strCreatePasswordSubTitle),
          
              /// New Password
              Obx(
                () => CommonTextField(
                  controller: authController.resetPasswordController,
                  hint: MTexts.strNewPassword,
                  isObscureText: isPasswordVisible.value,
                  icon: isPasswordVisible.value
                      ? Icons.visibility_off
                      : Icons.visibility,
                  fillColor: (Theme.of(context).brightness == Brightness.dark
                      ? MColors.black
                      : MColors.grey),
                  onTap: () {
                    isPasswordVisible.value = !isPasswordVisible.value;
                  },
                ),
              ),
              const SizedBox(height: MSizes.spaceBtwInputFields),
              Obx(
                () => CommonTextField(
                  controller: authController.resetConfirmPasswordController,
                  hint: MTexts.strConfirmPassword,
                  isObscureText: isConfirmPasswordVisible.value,
                  icon: isConfirmPasswordVisible.value
                      ? Icons.visibility_off
                      : Icons.visibility,
                  fillColor: (Theme.of(context).brightness == Brightness.dark
                      ? MColors.black
                      : MColors.grey),
                  onTap: () {
                    isConfirmPasswordVisible.value =
                        !isConfirmPasswordVisible.value;
                  },
                ),
              ),
              const SizedBox(height: MSizes.spaceBtwInputFields),
              CommonTextField(
                  controller: authController.resetOTPController,
                  hint: MTexts.strOtp,
                  keyboardType: TextInputType.number,
                  fillColor: (Theme.of(context).brightness == Brightness.dark
                      ? MColors.black
                      : MColors.grey),
                  textInputFormatter: [
                    FilteringTextInputFormatter.allow(
                      RegExp("[0-9]"),
                    )
                  ]),
          
              /// Confirm Password
          
              const SizedBox(height: MSizes.spaceBtwSections),
          
              /// Submit
              CommonElevatedButton(
                onPressed: () {
                  if (authController.onResetPasswordScreenValidation()) {
                    authController.createNewPasswordVerifyOTPApi();
                  }
                },
                title: MTexts.strSubmit,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(bottom: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TermAndPolicy(onTermTap: () {}, onPolicyTap: () {}),
          ],
        ),
      ),
    );
  }
}

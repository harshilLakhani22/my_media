import 'package:coonch/common/widgets/common_elevated_button.dart';
import 'package:coonch/common/widgets/common_text_field.dart';
import 'package:coonch/features/profile/controllers/profile_controller.dart';
import 'package:coonch/utils/constants/colors.dart';
import 'package:coonch/utils/constants/sizes.dart';
import 'package:coonch/utils/constants/text_strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePassword extends StatelessWidget {
  ChangePassword({super.key});

  final ProfileController profileController = Get.find<ProfileController>()..clearPassword();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: Get.back,
          icon: const Icon(CupertinoIcons.back),
        ),
        title: const Text(
          MTexts.strChangePassword,
          style: TextStyle(
            fontSize: MSizes.fontSizeLg,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(MSizes.defaultSpace),
        child: Column(
          children: [
            /// New Password
            Obx(() => CommonTextField(
                  controller:
                      profileController.editProfileNewPasswordController,
                  hint: MTexts.strNewPassword,
                  keyboardType: TextInputType.text,
                  isObscureText: profileController.isPasswordHidden.value,
                  icon: profileController.isPasswordHidden.value
                      ? Icons.visibility_off
                      : Icons.visibility,
                  fillColor: (Theme.of(context).brightness == Brightness.dark
                      ? MColors.black
                      : MColors.grey),
                  onTap: () {
                    profileController.isPasswordHidden.value =
                        !profileController.isPasswordHidden.value;
                  },
                )),
            const SizedBox(height: MSizes.spaceBtwInputFields),

            /// Confirm Password
            Obx(
              () =>  CommonTextField(
                controller:
                    profileController.editProfileConfirmPasswordController,
                hint: MTexts.strConfirmPassword,
                keyboardType: TextInputType.text,
                isObscureText: profileController.isConPasswordHidden.value,
                icon: profileController.isConPasswordHidden.value
                    ? Icons.visibility_off
                    : Icons.visibility,
                fillColor: (Theme.of(context).brightness == Brightness.dark
                    ? MColors.black
                    : MColors.grey),
                onTap: () {
                  profileController.isConPasswordHidden.value =
                  !profileController.isConPasswordHidden.value;
                },
              ),
            ),
            const SizedBox(height: MSizes.spaceBtwSections),

            /// Submit
            CommonElevatedButton(
              onPressed: () {
                if (profileController.onChangePasswordScreenValidation()) {
                  profileController.changePasswordAPI();
                }
              },
              title: MTexts.strChangePassword,
            ),
          ],
        ),
      ),
    );
  }
}

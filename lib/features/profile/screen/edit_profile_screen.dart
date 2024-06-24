import 'package:coonch/common/widgets/common_elevated_button.dart';
import 'package:coonch/common/widgets/common_text_field.dart';
import 'package:coonch/features/auth/controllers/auth_controller.dart';
import 'package:coonch/features/auth/widgets/phone_dropdown.dart';
import 'package:coonch/features/profile/controllers/profile_controller.dart';
import 'package:coonch/features/profile/screen/change_password_screen.dart';
import 'package:coonch/utils/constants/colors.dart';
import 'package:coonch/utils/constants/image_strings.dart';
import 'package:coonch/utils/constants/sizes.dart';
import 'package:coonch/utils/constants/text_strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final ProfileController profileController = Get.find<ProfileController>();
  final AuthController authController = Get.find<AuthController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    profileController.setUserProfileData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: Get.back,
          icon: const Icon(CupertinoIcons.back),
        ),
        title: const Text(
          MTexts.strEditProfile,
          style: TextStyle(
            fontSize: MSizes.fontSizeLg,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(MSizes.defaultSpace),
          child: Column(
            children: [
              /// Profile Photo
              Container(
                height: 88,
                width: 88,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Image.asset(MImages.imgMyStatusProfile2),
              ),
              const SizedBox(height: MSizes.spaceBtwItems),
              GestureDetector(
                onTap: () {},
                child: const Text(
                  MTexts.strChangeProfilePhoto,
                  style: TextStyle(
                      color: MColors.buttonPrimary,
                      fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(height: MSizes.spaceBtwSections),

              /// Edit Profile Form
              CommonTextField(
                controller: profileController.editProfileFirstNameController,
                hint: MTexts.strFirstName,
              ),
              const SizedBox(height: MSizes.spaceBtwInputFields),
              CommonTextField(
                controller: profileController.editProfileLastNameController,
                hint: MTexts.strLastName,
              ),
              const SizedBox(height: MSizes.spaceBtwInputFields),
              CommonTextField(
                controller: profileController.editProfileBioController,
                hint: MTexts.strBio,
                maxLines: 3,
              ),
              const SizedBox(height: MSizes.spaceBtwInputFields),
              Row(
                children: [
                  Expanded(
                    child: Obx(
                      () => PhoneNumberDropDown(
                        dropDownValue: authController.selectedPhoneCode.value,
                        onChanged: (newValue) {
                          authController.setPhoneCode(newValue!);
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: MSizes.spaceBtwInputFields),
                  Expanded(
                    flex: 3,
                    child: CommonTextField(
                      controller: profileController.editProfilePhoneController,
                      hint: MTexts.strMobileNumber,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(MSizes.defaultSpace),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// Change Password
            GestureDetector(
              onTap: () {
                Get.to(ChangePassword());
              },
              child: const Text(
                MTexts.strChangePassword,
                style: TextStyle(
                    color: MColors.buttonPrimary, fontSize: MSizes.fontSizeSm),
              ),
            ),
            const SizedBox(height: MSizes.spaceBtwTexts),
            CommonElevatedButton(
              onPressed: () {
                profileController.callUpdateProfile();
              },
              title: MTexts.strDone,
            ),
          ],
        ),
      ),
    );
  }
}

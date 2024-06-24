import 'package:coonch/common/methods/method.dart';
import 'package:coonch/common/widgets/common_text_field.dart';
import 'package:coonch/common/widgets/or_widget.dart';
import 'package:coonch/features/auth/controllers/auth_controller.dart';
import 'package:coonch/features/auth/widgets/phone_dropdown.dart';
import 'package:coonch/utils/constants/colors.dart';
import 'package:coonch/utils/constants/image_strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../common/widgets/common_elevated_button.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/constants/text_strings.dart';
import '../widgets/auth_heading.dart';
import '../widgets/auth_select_profile_photo.dart';
import '../widgets/select_default_profile.dart';

class AlmostThereScreen extends StatelessWidget {
  AlmostThereScreen({super.key});

  // final AuthController authController = Get.put(AuthController());
  late final XFile? pickedFile;

  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leading: IconButton(
          onPressed: Get.back,
          icon: const Icon(CupertinoIcons.back),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(MSizes.defaultSpace),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context)
                .unfocus(); // Dismiss keyboard when tapped outside text field
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Heading
              const AuthHeading(
                title: MTexts.strAlmostThere,
                subTitle: MTexts.strAlmostThereSubTitle,
              ),

              /// Choose Profile Section
              Column(
                children: [
                  /// From Gallery
                  Obx(() {
                    return AuthSelectProfilePhoto(
                      onTap: () async {
                        pickedFile = await pickImage();
                        if (pickedFile != null) {
                          debugPrint("pickedFile here --> $pickedFile");
                          authController.setSelectedProfilePhoto(pickedFile!);
                        }
                      },
                      imgString: authController.imgProfileString.value,
                      backgroundColor: MColors.softGrey,
                      isFile: authController.convertedFile.value,
                    );
                  }),

                  /// Or Divider
                  const OrWidget(title: MTexts.strOrSelectPP),

                  /// Select Profile Photo
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SelectDefaultProfile(
                          onTap: () {
                            authController
                                .setProfilePhoto(MImages.imgAuthProfilePhoto1);
                          },
                          imgString: MImages.imgAuthProfilePhoto1),
                      SelectDefaultProfile(
                          onTap: () {
                            authController
                                .setProfilePhoto(MImages.imgAuthProfilePhoto2);
                          },
                          imgString: MImages.imgAuthProfilePhoto2),
                      SelectDefaultProfile(
                          onTap: () {
                            authController
                                .setProfilePhoto(MImages.imgAuthProfilePhoto3);
                          },
                          imgString: MImages.imgAuthProfilePhoto3),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: MSizes.spaceBtwSections),

              /// Detail Form
              Column(
                children: [
                  CommonTextField(
                    controller: authController.nameController,
                    hint: MTexts.strEnterYourName,
                  ),
                  const SizedBox(height: MSizes.spaceBtwInputFields),
                  Row(
                    children: [
                      Expanded(
                        child: Obx(
                          () => PhoneNumberDropDown(
                            dropDownValue:
                                authController.selectedPhoneCode.value,
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
                          controller: authController.phoneController,
                          hint: MTexts.strMobileNumber,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// Submit
          Padding(
            padding: const EdgeInsets.all(MSizes.defaultSpace),
            child: CommonElevatedButton(
              onPressed: () async {
                if (pickedFile == null &&
                    authController.imgProfileString.value.isNotEmpty) {
                  // If no file picked from gallery, use selected profile photo from assets
                  final assetFile = await authController
                      .getAssetFile(authController.imgProfileString.value);
                  XFile file = XFile(assetFile.path);
                  authController.onSignUp(file);
                } else if (pickedFile != null) {
                  authController.onSignUp(pickedFile!);
                } else {
                  showToast(title: "Please select a profile photo.");
                }
              },
              title: MTexts.strSubmit,
            ),
          ),
          const SizedBox(height: MSizes.spaceBtwItems),
        ],
      ),
    );
  }
}

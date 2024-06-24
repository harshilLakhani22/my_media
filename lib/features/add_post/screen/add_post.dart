import 'package:basic_utils/basic_utils.dart';
import 'package:coonch/common/methods/method.dart';
import 'package:coonch/common/widgets/common_elevated_button.dart';
import 'package:coonch/features/add_post/controllers/add_post_controller.dart';
import 'package:coonch/features/add_post/widgets/category_dropdown_menu.dart';
import 'package:coonch/features/add_post/widgets/money_type_radio_button.dart';
import 'package:coonch/features/dashboard/widgets/floating_action_menu.dart';
import 'package:coonch/utils/constants/colors.dart';
import 'package:coonch/utils/constants/image_strings.dart';
import 'package:coonch/utils/constants/sizes.dart';
import 'package:coonch/utils/constants/text_strings.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class AddPostScreen extends StatelessWidget {
  AddPostScreen(this.postType, {super.key});

  final String? postType;
  final AddPostController addPostController = Get.find<AddPostController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: Get.back,
          icon: const Icon(CupertinoIcons.back),
        ),
        title: const Text(
          MTexts.strAddYourContent,
          style: TextStyle(
            fontSize: MSizes.fontSizeLg,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(MSizes.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              postType == PostType.text.toString()
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          MTexts.strEnterText,
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: MSizes.spaceBtwTexts),
                        TextFormField(
                          controller: addPostController.messageController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                MSizes.borderRadiusLg,
                              ),
                              borderSide: const BorderSide(
                                color: MColors.textFieldBorder,
                              ),
                            ),
                            hintText: MTexts.strWriteMessage,
                            hintStyle: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: MSizes.fontSizeMd,
                            ),
                          ),
                          minLines: 5,
                          maxLines: 6,
                        ),
                      ],
                    )
                  : const SizedBox.shrink(),
              const SizedBox(height: MSizes.spaceBtwItems),

              /// Upload Content

              postType != PostType.text.toString()
                  ? Column(
                      children: [
                        const Text(
                          MTexts.strUploadContent,
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: MSizes.spaceBtwTexts),
                        GestureDetector(
                          onTap: () {
                            if (postType == PostType.video.toString()) {
                              addPostController.getVideoFromGallery();
                            } else {
                              addPostController.getAudioFromGallery();
                            }
                          },
                          child: DottedBorder(
                            strokeWidth: 0.5,
                            borderType: BorderType.RRect,
                            radius:
                                const Radius.circular(MSizes.borderRadiusLg),
                            child: ClipRRect(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(MSizes.borderRadiusLg),
                              ),
                              child: SizedBox(
                                height: 200,
                                child: Center(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SvgPicture.asset(
                                          MIcons.iconUploadContent),
                                      const SizedBox(
                                          height: MSizes.spaceBtwItems),
                                      RichText(
                                        textAlign: TextAlign.center,
                                        text: const TextSpan(
                                          children: [
                                            TextSpan(
                                              text: "Choose ",
                                              style: TextStyle(
                                                color: Colors
                                                    .blue, // Bold and blue color
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            TextSpan(
                                              text: "file to upload\n",
                                              style: TextStyle(
                                                color: Colors.black,
                                                // Bold and black color
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Obx(
                                        () => addPostController.assetPath !=
                                                null
                                            ? Text(
                                                addPostController.getFileName())
                                            : const SizedBox.shrink(),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: MSizes.spaceBtwTexts),
                      ],
                    )
                  : const SizedBox.shrink(),

              /// Still Need Help
              Row(
                children: [
                  SvgPicture.asset(MIcons.iconNeedHelp),
                  const SizedBox(width: MSizes.spaceBtwTexts),
                  const Text(
                    MTexts.strStillNeedHelp,
                    style: TextStyle(fontWeight: FontWeight.w400),
                  )
                ],
              ),
              const SizedBox(height: MSizes.spaceBtwSections / 2),

              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MoneyTypeRadioButton(value: "free", title: "Free"),
                  MoneyTypeRadioButton(value: "paid", title: "Paid"),
                ],
              ),
              const SizedBox(height: MSizes.spaceBtwSections / 2),

              /// DropDown Section
              Obx(
                () => CategoryDropDownMenu(
                  dropDownValue: addPostController.selectedCategory.value,
                  onChanged: (newValue) {
                    addPostController.setCategory(newValue!);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// Post Button
          Padding(
            padding: const EdgeInsets.all(MSizes.defaultSpace),
            child: CommonElevatedButton(
              onPressed: () {
                if (postType == PostType.video.toString()) {
                  if (addPostController.assetPath?.isNotEmpty ?? false) {
                    addPostController.addVideoAssetPost();
                  } else {
                    showToast(title: "Please upload the video");
                  }
                } else if (postType == PostType.text.toString()) {
                  if (StringUtils.isNullOrEmpty(
                      addPostController.messageController.text)) {
                    showToast(title: MTexts.strPleaseEnterText);
                  } else {
                    addPostController.addTextPost();
                  }
                } else {
                  if (addPostController.assetPath?.isNotEmpty ?? false) {
                    addPostController.addAudioAssetPost();
                  } else {
                    showToast(title: "Please upload the audio");
                  }
                }
              },
              title: MTexts.strPost,
            ),
          ),
        ],
      ),
    );
  }
}

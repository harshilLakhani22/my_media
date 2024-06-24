import 'package:coonch/features/add_post/controllers/add_post_controller.dart';
import 'package:coonch/features/add_post/screen/add_post.dart';
import 'package:coonch/features/dashboard/controllers/dashboard_controller.dart';
import 'package:coonch/features/dashboard/widgets/floating_button_add_post_container.dart';
import 'package:coonch/utils/constants/image_strings.dart';
import 'package:coonch/utils/constants/sizes.dart';
import 'package:coonch/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

enum PostType { text, video, audio }

class FloatingActionMenu extends GetWidget<DashBoardController> {
  FloatingActionMenu({super.key});

  final AddPostController addPostController = Get.find<AddPostController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Obx(
          () => controller.isMenuOpen.value
              ? Container(
                  padding: const EdgeInsets.all(MSizes.defaultSpace),
                  width: 320,
                  height: 140,
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(MSizes.borderRadiusLg),
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        MTexts.strPost,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: MSizes.fontSizeMd),
                      ),
                      const SizedBox(height: MSizes.sm),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          FloatingButtonAddPostContainer(
                            icon: MIcons.iconAudioUpload,
                            label: MTexts.strAudio,
                            onTap: () {
                              controller.toggleMenu();
                              addPostController.clearController();
                              Get.to(AddPostScreen(PostType.audio.toString()));
                            },
                          ),
                          FloatingButtonAddPostContainer(
                            icon: MIcons.iconVideoUpload,
                            label: MTexts.strVideo,
                            onTap: () {
                              controller.toggleMenu();
                              addPostController.clearController();
                              Get.to(AddPostScreen(PostType.video.toString()));
                            },
                          ),
                          FloatingButtonAddPostContainer(
                            icon: MIcons.iconTextUpload,
                            label: MTexts.strText,
                            onTap: () {
                              controller.toggleMenu();
                              addPostController.clearController();
                              Get.to(AddPostScreen(PostType.text.toString()));
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              : const SizedBox.shrink(),
        ),
        FloatingActionButton(
          backgroundColor: Colors.transparent,
          elevation: 0,
          onPressed: () {
            controller.toggleMenu();
          },
          child: SvgPicture.asset(MIcons.iconAddPost),
        ),
      ],
    );
  }
}

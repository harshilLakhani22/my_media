import 'package:coonch/features/home/models/audio_model.dart';
import 'package:coonch/features/home/models/text_model.dart';
import 'package:coonch/features/home/models/video_model.dart';
import 'package:coonch/features/profile/controllers/profile_controller.dart';
import 'package:coonch/utils/constants/colors.dart';
import 'package:coonch/utils/constants/sizes.dart';
import 'package:coonch/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';


class DescriptionWithChangeableHeightProfile extends StatelessWidget {
  const DescriptionWithChangeableHeightProfile({
    super.key,
    this.model,
    required this.profileController,
  });


  final dynamic model; // This can be VideoModel, AudioModel, or TextModel
  final ProfileController profileController;

  @override
  Widget build(BuildContext context) {
    String description = "";

    if (model is VideoModel) {
      description = model.description;
    } else if (model is AudioModel) {
      description = model.description;
    } else if (model is TextModel) {
      description = model.textDescription;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(() {
            return AnimatedCrossFade(
              firstChild: Text(
                // "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum",
                description,
                style: const TextStyle(),
                maxLines: 2, // Max lines initially set to 2
                overflow: TextOverflow.ellipsis,
              ),
              secondChild: Text(
                // "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum",
                description,
                style: const TextStyle(),
                softWrap: true,
              ),
              crossFadeState: profileController.isExpanded.value
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              duration: const Duration(milliseconds: 300),
            );
          }),
          const SizedBox(height: MSizes.sm),
          GestureDetector(
            onTap: profileController.toggleExpansion,
            child: Text(
              profileController.isExpanded.value ? MTexts.strShowLess : MTexts.strShowMore,
              style: const TextStyle(
                color: MColors.darkGrey,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

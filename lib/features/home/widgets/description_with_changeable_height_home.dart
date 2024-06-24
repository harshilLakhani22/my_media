import 'package:coonch/features/home/models/audio_model.dart';
import 'package:coonch/features/home/models/text_model.dart';
import 'package:coonch/features/home/models/video_model.dart';
import 'package:coonch/utils/constants/colors.dart';
import 'package:coonch/utils/constants/sizes.dart';
import 'package:coonch/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DescriptionWithChangeableHeightHome extends StatelessWidget {
  DescriptionWithChangeableHeightHome({
    super.key,
    this.model,
  });

  final dynamic model; // This can be VideoModel, AudioModel, or TextModel
  final RxBool isShowMore = false.obs;
  final RxBool isTextLong = false.obs;

  void toggleExpansion() {
    isShowMore.value = !isShowMore.value;
  }

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

    // Measure the text
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final textSpan = TextSpan(text: description, style: const TextStyle());
      final textPainter = TextPainter(
        text: textSpan,
        maxLines: 2,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout(maxWidth: MediaQuery.of(context).size.width - 16); // considering padding
      isTextLong.value = textPainter.didExceedMaxLines;
    });

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(() {
            return AnimatedCrossFade(
              firstChild: Text(
                description,
                style: const TextStyle(),
                maxLines: 2, // Max lines initially set to 2
                overflow: TextOverflow.ellipsis,
              ),
              secondChild: Text(
                description,
                style: const TextStyle(),
                softWrap: true,
              ),
              crossFadeState: isShowMore.value
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              duration: const Duration(milliseconds: 300),
            );
          }),
          Obx(() {
            return isTextLong.value ? Column(
              children: [
                const SizedBox(height: MSizes.sm),
                GestureDetector(
                  onTap: toggleExpansion,
                  child: Text(
                    isShowMore.value ? MTexts.strShowLess : MTexts.strShowMore,
                    style: const TextStyle(
                      color: MColors.darkGrey,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ) : const SizedBox.shrink();
          }),
        ],
      ),
    );
  }
}

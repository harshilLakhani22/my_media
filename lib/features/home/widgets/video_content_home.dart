import 'package:coonch/common/widgets/profile_data_row_free.dart';
import 'package:coonch/features/home/screen/video_player_screen.dart';
import 'package:coonch/features/home/widgets/description_with_changeable_height_home.dart';
import 'package:coonch/common/widgets/like_share_row.dart';
import 'package:coonch/features/home/models/video_model.dart';
import 'package:coonch/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class VideoContentHome extends StatelessWidget {
  const VideoContentHome({
    super.key,
    required this.videoModel,
  });

  final VideoModel videoModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// Profile Data Row
        ProfileDataRowFree(
          profileUrl: videoModel.profilePicUrl,
          username: videoModel.userName,
          userCategory: videoModel.userCategory,
        ),

        /// Thumbnail
        GestureDetector(
          onTap: () {
            Get.to(VideoPlayerScreen(videoUrl: videoModel.videoUrl));
          },
          child: SizedBox(
            height: 200,
            child: Image.network(
              videoModel.thumbnailUrl,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                        : null,
                  ),
                );
              },
            ),
          ),
        ),
        const SizedBox(height: MSizes.sm),

        /// Like, Share & etc.
        LikeShareRow(
          commentNo: videoModel.commentNo,
          likeNo: videoModel.likesNo,
        ),
        const SizedBox(height: MSizes.sm),

        /// Description
        DescriptionWithChangeableHeightHome(
          model: videoModel
        ),
      ],
    );
  }
}

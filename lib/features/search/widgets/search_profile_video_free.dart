import 'package:coonch/common/widgets/image_error_widget.dart';
import 'package:coonch/common/widgets/profile_data_row_free.dart';
import 'package:coonch/features/home/screen/video_player_screen.dart';
import 'package:coonch/features/search/controllers/search_screen_controller.dart';
import 'package:coonch/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchProfileVideoFree extends StatelessWidget {
  const SearchProfileVideoFree({
    super.key,
    // required this.searchScreenController,
    required this.videoUrl,
    required this.thumbnailUrl,
    required this.username,
    required this.userCategory,
    required this.profileUrl,
  });

  // final SearchScreenController searchScreenController;
  final String videoUrl;
  final String thumbnailUrl;
  final String username;
  final String userCategory;
  final String profileUrl;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: MSizes.smmd),
        ProfileDataRowFree(
          profileUrl: profileUrl,
          username: username,
          userCategory: userCategory,
        ),

        /// Thumbnail
        GestureDetector(
          onTap: () {
            Get.to(VideoPlayerScreen(videoUrl: videoUrl));
          },
          child: SizedBox(
            height: 200,
            child: Image.network(
              thumbnailUrl,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                }
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            (loadingProgress.expectedTotalBytes ?? 1)
                        : null,
                  ),
                );
              },
              errorBuilder: (_, __, ___) {
                return const ImageErrorWidget();
              },
            ),
          ),
        ),
        const SizedBox(height: MSizes.sm),
      ],
    );
  }
}

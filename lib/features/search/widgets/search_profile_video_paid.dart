import 'package:coonch/common/widgets/profile_data_row_paid.dart';
import 'package:coonch/features/purchase_content/widgets/purchase_content_dialog.dart';
import 'package:coonch/features/search/controllers/search_screen_controller.dart';
import 'package:coonch/utils/constants/image_strings.dart';
import 'package:coonch/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchProfileVideoPaid extends StatelessWidget {
  const SearchProfileVideoPaid({
    super.key,
    required this.searchScreenController,
    required this.videoUrl,
    required this.thumbnailUrl,
    required this.username,
    required this.userCategory,
    required this.contentId,
    required this.planType,
    required this.creatorId,
    required this.profileUrl,
  });

  // final PurchaseController purchaseController = Get.find<PurchaseController>();

  final SearchScreenController searchScreenController;
  final String videoUrl;
  final String thumbnailUrl;
  final String username;
  final String userCategory;
  final String contentId;
  final String planType;
  final String creatorId;

  final String profileUrl;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: MSizes.smmd),
        ProfileDataRowPaid(
          // profileUrl: MImages.imgMyStatusProfile2,
          profileUrl: profileUrl,
          username: username,
          userCategory: userCategory,
        ),

        /// Thumbnail
        GestureDetector(
          onTap: () {
            purchaseContentDialog(
              Get.context!,
              planType: planType,
              creatorId: creatorId,
              contentId: contentId,
            );
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
            ),
          ),
        ),
        const SizedBox(height: MSizes.sm),
      ],
    );
  }
}

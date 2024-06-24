import 'package:coonch/common/widgets/like_share_row.dart';
import 'package:coonch/features/home/models/text_model.dart';
import 'package:coonch/features/profile/controllers/profile_controller.dart';
import 'package:coonch/features/profile/widgets/description_with_changeable_height_profile.dart';
import 'package:flutter/cupertino.dart';


class TextContentProfile extends StatelessWidget {
  const TextContentProfile({
    super.key,
    required this.textModel,
    required this.profileController,
  });

  final TextModel textModel;
  final ProfileController profileController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Profile Data Row
        // ProfileDataRow(
        //   profileUrl: MImages.imgMyStatusProfile2,
        //   username: textModel.userName,
        //   userCategory: textModel.userCategory,
        // ),

        /// Text
        DescriptionWithChangeableHeightProfile(
          profileController: profileController,
          model: textModel,
        ),

        /// Like, Share & etc.
        LikeShareRow(
          commentNo: textModel.commentNo,
          likeNo: textModel.likesNo,
        ),
      ],
    );
  }
}

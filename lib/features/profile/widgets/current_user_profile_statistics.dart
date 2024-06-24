
import 'package:coonch/features/profile/controllers/profile_controller.dart';
import 'package:coonch/features/profile/widgets/user_statistics_column.dart';
import 'package:coonch/utils/constants/colors.dart';
import 'package:coonch/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';

class CurrentUserProfileStatistics extends StatelessWidget {
  const CurrentUserProfileStatistics({
    super.key,
    required this.profileController,
  });

  final ProfileController profileController;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          /// Posts
          UserStatisticsColumn(
            count: profileController
                .userDataModel?.value.totalPosts
                ?.toString() ??
                "",
            title: MTexts.strPosts,
          ),
          const VerticalDivider(
            color: MColors.grey,
            thickness: 1,
            indent: 8,
            endIndent: 8,
          ),
          UserStatisticsColumn(
            count: profileController
                .userDataModel?.value.followersCount
                ?.toString() ??
                '',
            title: MTexts.strFriends,
            crossAxisAlignment: CrossAxisAlignment.center,
          ),
          const VerticalDivider(
            color: MColors.grey,
            thickness: 1,
            indent: 8,
            endIndent: 8,
          ),
          UserStatisticsColumn(
            count: profileController
                .userDataModel?.value.followingCount
                ?.toString() ??
                '',
            title: MTexts.strFollowing,
          ),
        ],
      ),
    );
  }
}

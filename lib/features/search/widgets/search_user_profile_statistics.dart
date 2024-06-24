
import 'package:coonch/features/profile/controllers/profile_controller.dart';
import 'package:coonch/features/profile/widgets/user_statistics_column.dart';
import 'package:coonch/utils/constants/colors.dart';
import 'package:coonch/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';

class SearchUserProfileStatistics extends StatelessWidget {
  const SearchUserProfileStatistics({
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
                .otherUser?.value.followersCount
                ?.toString() ??
                'Null Value',
            title: MTexts.strPosts,
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
                .otherUser?.value.followersCount
                ?.toString() ??
                'Null Value',
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
                .otherUser?.value.followingCount
                ?.toString() ??
                'Null Value',
            title: MTexts.strFollowing,
            crossAxisAlignment: CrossAxisAlignment.center,
          ),
        ],
      ),
    );
  }
}


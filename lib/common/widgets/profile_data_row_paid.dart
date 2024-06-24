import 'package:coonch/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';

import '../../utils/constants/colors.dart';
import '../../utils/constants/sizes.dart';

class ProfileDataRowPaid extends StatelessWidget {
  const ProfileDataRowPaid({
    super.key,
    required this.profileUrl,
    required this.username,
    required this.userCategory,
  });

  final String profileUrl;
  final String username;
  final String userCategory;


  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.all(MSizes.sm),
          height: 45,
          width: 45,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.network(
              profileUrl,
              fit: BoxFit.fill,
              errorBuilder: (context, error, stackTrace) {
                return Image.asset(MImages.imgMyStatusProfile2);
              },
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              username,
              style: const TextStyle(fontSize: MSizes.fontSizeMd),
            ),
            Text(
              userCategory,
              style: const TextStyle(fontSize: MSizes.fontSizeSm),
            )
          ],
        ),
        const Spacer(),
        IconButton(
          onPressed: (){},
          icon: const Icon(Icons.lock_outline)
        ),
      ],
    );
  }
}

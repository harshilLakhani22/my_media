
import 'package:coonch/features/auth/models/user_data_model.dart';
import 'package:coonch/utils/constants/image_strings.dart';
import 'package:coonch/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CommonProfilePhotoRow extends StatelessWidget {
  const CommonProfilePhotoRow({
    super.key,
    required this.imageString,
    required this.username,
    required this.bio,
  });

  final String imageString;
  final String username;
  final String bio;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: 88,
          width: 88,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.network(
              imageString,
              fit: BoxFit.fill,
            ),
          ),
        ),
        const SizedBox(width: MSizes.defaultSpace),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(username),
              const SizedBox(height: MSizes.spaceBtwTexts),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SvgPicture.asset(MIcons.iconLocation),
                  const SizedBox(width: MSizes.spaceBtwTexts),
                  Flexible(
                    child: Text(
                      bio,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}

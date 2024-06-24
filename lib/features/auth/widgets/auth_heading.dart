
import 'package:flutter/material.dart';

import '../../../utils/constants/sizes.dart';

class AuthHeading extends StatelessWidget {
  const AuthHeading({
    super.key,
    required this.title,
    required this.subTitle,
  });

  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: MSizes.fontSizeTitleLg,
            fontWeight: MSizes.weightTitle,
          ),
        ),
        const SizedBox(height: MSizes.spaceBtwTexts),
        Text(
          subTitle,
          style: const TextStyle(fontSize: MSizes.fontSizeMd),
        ),
        const SizedBox(height: MSizes.spaceBtwSections),
      ],
    );
  }
}

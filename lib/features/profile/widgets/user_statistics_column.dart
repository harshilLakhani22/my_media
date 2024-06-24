import 'package:coonch/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class UserStatisticsColumn extends StatelessWidget {
  const UserStatisticsColumn({
    super.key,
    required this.count,
    required this.title,
    this.crossAxisAlignment = CrossAxisAlignment.start,
  });

  final String count;
  final String title;
  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Text(
          count,
          style: const TextStyle(
            fontSize: MSizes.fontSizeLg,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: MSizes.spaceBtwTexts),
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w300,
          ),
        ),
      ],
    );
  }
}

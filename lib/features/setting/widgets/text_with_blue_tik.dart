import 'package:coonch/utils/constants/image_strings.dart';
import 'package:coonch/utils/constants/sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TextWithBlueTik extends StatelessWidget {
  const TextWithBlueTik({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SvgPicture.asset(MIcons.iconSubscriptionTik),
            const SizedBox(width: MSizes.sm),
            Expanded(
              child: Text(
                text,
                maxLines: 2,
                softWrap: true,
              ),
            ),
          ],
        ),
        const SizedBox(height: MSizes.spaceBtwTexts),
      ],
    );
  }
}

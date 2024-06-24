import 'package:coonch/utils/constants/colors.dart';
import 'package:coonch/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ExploreCategoriesOption extends StatelessWidget {
  const ExploreCategoriesOption({
    super.key,
    required this.icon,
    required this.title,
    this.isSelected = false,
  });

  final String icon;
  final String title;
  final bool? isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: MColors.buttonUnSelected.withOpacity(0.4)),
          borderRadius: BorderRadius.circular(MSizes.borderRadiusLg),
        ),
        padding: const EdgeInsets.all(MSizes.spaceBtwItems),
        child: Row(
          children: [
            SvgPicture.asset(icon),
            const SizedBox(width: MSizes.spaceBtwItems),
            Text(
              title,
              style: const TextStyle(fontSize: MSizes.fontSizeMd),
            ),
          ],
        ),
      ),
    );
  }
}


import 'package:coonch/utils/constants/colors.dart';
import 'package:coonch/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FloatingButtonAddPostContainer extends StatelessWidget {
  const FloatingButtonAddPostContainer({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final String icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: MSizes.lg, vertical: MSizes.smmd),
        decoration: BoxDecoration(
          border: Border.all(color: MColors.borderLightGrey),
          borderRadius: BorderRadius.circular(MSizes.borderRadiusLg),
        ),
        child: Column(
          children: [
            // Icon(icon),
            SvgPicture.asset(icon),
            Text(label),
          ],
        ),
      ),
    );
  }
}

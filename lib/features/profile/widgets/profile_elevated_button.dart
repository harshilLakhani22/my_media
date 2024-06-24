import 'package:coonch/utils/constants/colors.dart';
import 'package:coonch/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class ProfileElevatedButton extends StatelessWidget {
  const ProfileElevatedButton({
    super.key,
    required this.onPressed,
    required this.title,
     this.icon,
    this.isTransparent = false,
  });

  final VoidCallback onPressed;
  final String title;
  final IconData? icon;
  final bool isTransparent;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isTransparent ? MColors.white : MColors.buttonPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
              MSizes.borderRadiusLg), // Set the border radius
        ),
        minimumSize: const Size(double.infinity, 50.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon!=null? Icon(
            icon,
            color: isTransparent ? MColors.darkGrey : Colors.white,
            size: MSizes.md,
          ):const SizedBox.shrink(),
          const SizedBox(width: MSizes.sm),
          Text(
            title,
            style: TextStyle(
              color: isTransparent ? MColors.darkGrey : Colors.white,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}


import 'package:flutter/material.dart';

import '../../utils/constants/colors.dart';
import '../../utils/constants/sizes.dart';

class CommonElevatedButton extends StatelessWidget {
  const CommonElevatedButton({
    super.key,
    required this.onPressed,
    required this.title,
  });

  final VoidCallback onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: MColors.buttonPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0), // Set the border radius
        ),
        minimumSize: const Size(double.infinity, 50.0),
      ),
      child: Text(
        title,
        style: const TextStyle(color: Colors.white, fontSize: MSizes.md),
      ),
    );
  }
}

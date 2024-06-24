import 'package:coonch/utils/constants/theme_constants.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:week_challenge/core/constants/theme_constants.dart';

class TabItem extends StatelessWidget {
  const TabItem({
    required this.isActive,
    super.key,
    this.imageData,
    this.imageName,
    this.activeColor = ThemeColors.accent900Color,
    this.inactiveColor = Colors.black,
  });
  final String? imageData;
  final String? imageName;
  final bool isActive;
  final Color? activeColor;
  final Color? inactiveColor;

  @override
  Widget build(BuildContext context) => _buildDefaultTab();

  Widget _buildDefaultTab() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ImageIcon(
          AssetImage(imageData!),
          color: isActive ? activeColor : inactiveColor,
          // size: 24.sp,
          size: 24,
        ),
        const SizedBox(height: 5),
        Text(
          imageName!,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isActive ? activeColor : inactiveColor,
            // fontSize: 10.sp,
            fontSize: 10,
          ),
        )
      ],
    );
  }
}

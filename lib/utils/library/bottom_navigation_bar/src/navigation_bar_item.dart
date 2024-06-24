import 'package:coonch/utils/library/bottom_navigation_bar/src/tab_item.dart';
import 'package:flutter/material.dart';
// import 'package:week_challenge/core/utils/library/bottom_navigation_bar/src/tab_item.dart';

class NavigationBarItem extends StatelessWidget {
  const NavigationBarItem({
    required this.isActive,
    required this.activeColor,
    required this.inactiveColor,
    required this.imageData,
    required this.iconScale,
    required this.onTap,
    required this.iconName,
    super.key,
  });

  final bool isActive;
  final String iconName;
  final Color? activeColor;
  final Color? inactiveColor;
  final String? imageData;
  final double iconScale;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox.expand(
        child: InkWell(
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
          onTap: onTap,
          child: TabItem(
            isActive: isActive,
            imageName: iconName,
            imageData: imageData,
            activeColor: activeColor,
            inactiveColor: inactiveColor,
          ),
        ),
      ),
    );
  }
}

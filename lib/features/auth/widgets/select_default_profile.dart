import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SelectDefaultProfile extends StatelessWidget {
  const SelectDefaultProfile(
      {super.key, this.onTap, this.imgString, this.backgroundColor,});


  final VoidCallback? onTap;
  final String? imgString;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 77,
        width: 77,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: backgroundColor,
        ),
        child: Center(
          child: SvgPicture.asset(imgString!),
        ),
      ),
    );
  }
}

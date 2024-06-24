import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';

class SocialLoginButton extends StatelessWidget {
  const SocialLoginButton({
    super.key,
    required this.onTap,
    required this.imgPath,
    this.isOther = false,
  });

  final String imgPath;
  final bool isOther;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: MSizes.md),
        child: Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(MSizes.borderRadiusLg),
              ),
              border: Border.all(width: 1, color: MColors.authIconBorder)),
          child: !isOther
              ? SvgPicture.asset(imgPath,height: 20,width: 20,fit: BoxFit.none,)
              : Image.asset(imgPath, height: 20, width: 20),
          // child: Image.asset(imgPath, height: 50, width: 50, fit: BoxFit.fill,),
        ),
      ),
    );
  }
}

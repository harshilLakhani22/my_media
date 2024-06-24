import 'dart:io';

import 'package:basic_utils/basic_utils.dart';
import 'package:coonch/utils/constants/colors.dart';
import 'package:coonch/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AuthSelectProfilePhoto extends StatefulWidget {
  const AuthSelectProfilePhoto({
    super.key,
    this.onTap,
    this.imgString,
    this.backgroundColor = MColors.white,
    this.isFile,
  });

  final VoidCallback? onTap;
  final String? imgString;
  final Color? backgroundColor;
  final File? isFile;

  @override
  State<AuthSelectProfilePhoto> createState() => _AuthSelectProfilePhotoState();
}

class _AuthSelectProfilePhotoState extends State<AuthSelectProfilePhoto> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // convertFile();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        height: 77,
        width: 77,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: widget.backgroundColor,
        ),
        child: Center(
          child: widget.isFile != null
              ? SizedBox(
                  height: 77,
                  width: 77,
                  child:
                      CircleAvatar(backgroundImage: FileImage(widget.isFile!)),
                )
              : StringUtils.isNotNullOrEmpty(widget.imgString)
                  ? SvgPicture.asset(widget.imgString!)
                  : SvgPicture.asset(MImages.imgAddProfilePhoto),
        ),
      ),
    );
  }
}

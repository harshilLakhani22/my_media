
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SettingListTile extends StatelessWidget {
  const SettingListTile({
    super.key,
    required this.leadingIcon,
    required this.title,
    required this.onTap,
  });

  final String leadingIcon;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading:
      SvgPicture.asset(leadingIcon),
      title: Text(title),
      trailing: const Icon(CupertinoIcons.forward),
      onTap: onTap,
    );
  }
}

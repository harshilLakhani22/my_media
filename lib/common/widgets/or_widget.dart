import 'package:coonch/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class OrWidget extends StatelessWidget {
  const OrWidget({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(right: 20),
              child: const Divider(
                color: MColors.dividerColor,
                height: 10,
              ),
            ),
          ),
          Text(title),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 20),
              child: const Divider(
                color: MColors.dividerColor,
                height: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

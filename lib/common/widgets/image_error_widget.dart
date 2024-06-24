

import 'package:coonch/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class ImageErrorWidget extends StatelessWidget {
  const ImageErrorWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(width: 1),
          borderRadius: BorderRadius.circular(MSizes.smmd)
      ),
      alignment: Alignment.center,
      child: const Tooltip(
        message: "Cannot load Image",
        child: Icon(Icons.info),
      ),
    );
  }
}
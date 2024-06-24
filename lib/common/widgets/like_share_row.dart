import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../utils/constants/image_strings.dart';

class LikeShareRow extends StatelessWidget {
  const LikeShareRow({
    super.key,
    // required this.widget,
    required this.likeNo,
    required this.commentNo,
  });

  // final VideoContent widget;
  final int likeNo;
  final int commentNo;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: SvgPicture.asset(MIcons.iconHeart),
        ),
        // const Text("7.5k"),
        // Text("${widget.videoModel.likesNo}"),
        Text(likeNo.toString()),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: SvgPicture.asset(MIcons.iconComment),
        ),
        // const Text("425"),
        Text(commentNo.toString()),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: SvgPicture.asset(MIcons.iconShare),
        ),
        const Spacer(),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Text("200 likes"),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Text("120 comments"),
        ),
      ],
    );
  }
}

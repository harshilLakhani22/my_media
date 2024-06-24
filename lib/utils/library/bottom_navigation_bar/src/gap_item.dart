import 'package:flutter/material.dart';

class GapItem extends StatelessWidget {
  const GapItem({required this.width, super.key});

  final double width;

  @override
  Widget build(BuildContext context) => Container(width: width);
}

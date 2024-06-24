import 'package:flutter/material.dart';

class ImageBuilder extends StatelessWidget {
  const ImageBuilder({super.key, required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: Image.network(
        url,
        // scale: scale,
        fit: BoxFit.fill,
        errorBuilder: (_, __, ___) => Container(
          width: 30,
          height: 30,
          decoration: const BoxDecoration(shape: BoxShape.circle),
          child: const Icon(Icons.error),
        ),
        loadingBuilder: (
          BuildContext context,
          Widget child,
          ImageChunkEvent? loadingProgress,
        ) {
          if (loadingProgress == null) {
            return Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(shape: BoxShape.circle),

              child: child,
            );
          }
          return const SizedBox(
            width: 50,
            height: 50,
          );
        },
      ),
    );
  }
}

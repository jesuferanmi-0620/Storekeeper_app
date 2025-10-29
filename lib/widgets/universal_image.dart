import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class UniversalImage extends StatelessWidget {
  final String? imagePath;
  final double? width;
  final double? height;
  final BoxFit fit;

  const UniversalImage({
    super.key,
    required this.imagePath,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    if (imagePath == null || imagePath!.isEmpty) {
      return Container(
        width: width,
        height: height,
        color: Colors.grey[300],
        child: const Icon(
          Icons.inventory_2,
          color: Colors.white70,
          size: 40,
        ),
      );
    }

    if (kIsWeb) {
      return Image.network(
        imagePath!,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: width,
            height: height,
            color: Colors.grey[300],
            child: const Icon(
              Icons.inventory_2,
              color: Colors.white70,
              size: 40,
            ),
          );
        },
      );
    } else {
      return Image.file(
        File(imagePath!),
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: width,
            height: height,
            color: Colors.grey[300],
            child: const Icon(
              Icons.inventory_2,
              color: Colors.white70,
              size: 40,
            ),
          );
        },
      );
    }
  }
}
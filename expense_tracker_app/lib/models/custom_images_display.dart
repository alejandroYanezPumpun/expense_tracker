import 'package:flutter/material.dart';

class CustomImageDisplay extends StatelessWidget {
  final String imagePath;
  final double height;
  final double width;
  final Color? color;
  const CustomImageDisplay({super.key, required this.imagePath, required this.height, required this.width, this.color});

  @override
  Widget build(BuildContext context) {
    return Image(
      height: height,
      width: width,
      image: AssetImage(imagePath),
      color: color,
    );
  }
}
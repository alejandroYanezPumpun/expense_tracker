import 'package:flutter/material.dart';

class CustomTextDisplay extends StatelessWidget {
  final String text;
  final int fontSize;
  final Color color;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  const CustomTextDisplay({super.key, required this.text, required this.fontSize, required this.color,  this.fontWeight,  this.textAlign});

  @override
  Widget build(BuildContext context) {
    return Text(  
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: fontSize.toDouble(),
        color: color,
        fontWeight: fontWeight,
      ),
    );
  }
}
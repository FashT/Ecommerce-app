import 'package:flutter/material.dart';

class SubtitleText extends StatelessWidget {
  final String label;
  final Color? color;
  final TextDecoration textDecoration;
  final FontStyle fontStyle;
  final FontWeight fontWeight;
  final double fontSize;

  const SubtitleText({
    super.key,
    required this.label,
    this.color,
    this.textDecoration = TextDecoration.none,
    this.fontStyle = FontStyle.normal,
    this.fontWeight = FontWeight.normal,
    this.fontSize = 18,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Text(
        label,
        style: TextStyle(
          fontWeight: fontWeight,
          color: color,
          fontStyle: fontStyle,
          fontSize: fontSize,
          decoration: textDecoration,
        ),
      ),
    );
  }
}

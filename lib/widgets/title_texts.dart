import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  final String label;
  final Color? color;
  final TextDecoration textDecoration;
  final FontStyle fontStyle;
  final FontWeight fontWeight;
  final double fontSize;
  final int? maxLines;

  const TitleText({
    super.key,
    required this.label,
    this.color,
    this.textDecoration = TextDecoration.none,
    this.fontStyle = FontStyle.normal,
    this.fontWeight = FontWeight.normal,
    this.fontSize = 20,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        fontWeight: fontWeight,
        color: color,
        fontStyle: fontStyle,
        fontSize: fontSize,
        decoration: textDecoration,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

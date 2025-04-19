import 'package:flutter/material.dart';
import 'package:guia_click/constants/colors.dart';

class TextWithBackground extends StatelessWidget {
  const TextWithBackground({
    required this.text,
    this.fontSize = 25,
    this.padding = const EdgeInsets.all(15),
    this.margin = const EdgeInsets.all(15),
    this.backgroundColor = GCColors.primary,
    this.textColor = Colors.white,
    this.textAlign = TextAlign.start,
    super.key,
  });
  final String text;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final double fontSize;
  final Color backgroundColor;
  final Color textColor;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: backgroundColor,
      ),
      child: Padding(
        padding: padding,
        child: Text(
          text,
          textAlign: textAlign,
          style: TextStyle(
            color: textColor,
            fontSize: fontSize,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

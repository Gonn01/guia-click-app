import 'package:flutter/material.dart';
import 'package:guia_click/constants/colors.dart';

class TextWithBackground extends StatelessWidget {
  const TextWithBackground({
    required this.text,
    this.fontSize = 30,
    this.padding = const EdgeInsets.all(15),
    this.margin = const EdgeInsets.all(15),
    this.backgroundColor = GCColors.primary,
    this.textColor = Colors.white,
    super.key,
  });
  final String text;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final double fontSize;
  final Color backgroundColor;
  final Color textColor;

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
          textAlign: TextAlign.center,
          style: TextStyle(
            color: textColor,
            fontSize: fontSize,
            fontWeight: FontWeight.w600,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}

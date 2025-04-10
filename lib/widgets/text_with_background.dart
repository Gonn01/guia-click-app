import 'package:flutter/material.dart';

class TextWithBackground extends StatelessWidget {
  const TextWithBackground({
    required this.text,
    this.fontSize = 30,
    this.padding = const EdgeInsets.all(15),
    super.key,
  });
  final String text;
  final EdgeInsetsGeometry padding;
  final double fontSize;
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints:
          BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.8),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: const Color(0xff63B2B5),
        ),
        child: Padding(
          padding: padding,
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: fontSize,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

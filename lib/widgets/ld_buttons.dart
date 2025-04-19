import 'dart:math';

import 'package:flutter/material.dart';

/// {@template LDButtons}
/// Buttons used in the application
/// {@endtemplate}
class LDButtons extends StatelessWidget {
  /// {@macro LDButtons}
  const LDButtons({
    required this.isEnabled,
    required this.onTap,
    required this.content,
    this.backgroundColorOutlined = Colors.white,
    this.backgroundColor = Colors.green,
    this.borderColor = Colors.green,
    this.boxShadow = const [
      BoxShadow(
        color: Colors.grey,
        blurRadius: 8,
        offset: Offset(0, 2),
      ),
    ],
    this.isOutlined = false,
    this.isLoading = false,
    this.padding,
    this.width,
    this.height,
    super.key,
  });

  /// Button that contains a text
  factory LDButtons.text({
    required bool isEnabled,
    required VoidCallback onTap,
    required String text,
    required Color backgroundColor,
    bool adaptative = false,
    bool isLoading = false,
    double width = 160,
    double height = 40,
    EdgeInsets padding =
        const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
    List<BoxShadow>? boxShadow,
  }) {
    return LDButtons(
      width: adaptative ? null : min(width, 160),
      height: adaptative ? null : min(height, 40),
      isEnabled: isEnabled,
      backgroundColor: backgroundColor,
      onTap: onTap,
      boxShadow: boxShadow,
      padding: padding,
      isLoading: isLoading,
      content: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 12,
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  /// Boton con borde que contiene un texto
  factory LDButtons.outlined({
    required bool isEnabled,
    required VoidCallback onTap,
    required String text,
    bool isLoading = false,
    bool adaptative = false,
    EdgeInsets padding =
        const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
    Color borderColor = Colors.green,
    double width = 160,
    double height = 40,
  }) {
    return LDButtons(
      isOutlined: true,
      borderColor: borderColor,
      width: adaptative ? null : min(width, 160),
      height: adaptative ? null : min(height, 40),
      isEnabled: isEnabled,
      isLoading: isLoading,
      onTap: onTap,
      padding: padding,
      boxShadow: const [],
      content: Center(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isEnabled ? borderColor : Colors.grey.withOpacity(.5),
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  /// Gives functionality to the button depending on the conditionals to be
  final bool isEnabled;

  /// Indicates if the button has a border
  final bool isOutlined;

  /// Function to be performed by pressing the button.
  final VoidCallback? onTap;

  /// Button content
  final Widget content;

  /// Background color of the outlined button
  final Color backgroundColorOutlined;

  /// Button background color
  final Color backgroundColor;

  /// Button border color if it is outlined
  final Color borderColor;

  /// Button shadow
  final List<BoxShadow>? boxShadow;

  /// Padding of the button
  final EdgeInsets? padding;

  /// Indicates if the button is loading
  final bool isLoading;

  /// Button width
  final double? width;

  /// Button height
  final double? height;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isEnabled ? onTap : null,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: isOutlined
              ? backgroundColorOutlined
              : isEnabled
                  ? !isLoading
                      ? backgroundColor
                      : Colors.grey.withOpacity(.5)
                  : Colors.grey.withOpacity(.5),
          border: isOutlined
              ? Border.all(
                  color: isEnabled ? borderColor : Colors.grey.withOpacity(.5),
                )
              : null,
          boxShadow: isEnabled
              ? !isLoading
                  ? boxShadow ?? const []
                  : const []
              : const [],
        ),
        child: Padding(
          padding: padding ??
              const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          child: Center(
            child: isLoading
                ? SizedBox(
                    width: 25,
                    height: 25,
                    child: CircularProgressIndicator(
                      color: isOutlined ? borderColor : const Color(0xFFfafafa),
                    ),
                  )
                : content,
          ),
        ),
      ),
    );
  }
}

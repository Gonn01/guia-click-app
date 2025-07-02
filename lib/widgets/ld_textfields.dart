import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:guia_click/constants/colors.dart';

/// {@template LDTextFormFields}
/// Textformfields used in the application
/// {@endtemplate}
class LDTextFormFields extends StatelessWidget {
  /// {@macro LDTextFormFields}
  const LDTextFormFields({
    this.controller,
    this.prefixIcon,
    this.validator,
    this.hintText,
    this.readOnly = false,
    this.obscureText = false,
    this.prefixIconColor,
    this.maxLines = 1,
    this.suffixIcon,
    this.onChanged,
    this.keyboardType,
    this.height,
    this.inputFormatters,
    this.maxLength,
    this.decoration,
    this.focusNode,
    this.initialValue,
    this.borderColor,
    super.key,
  });

  /// [LDTextFormFields] that only allows letters
  factory LDTextFormFields.onlyLetters({
    required TextEditingController controller,
    required String hintText,
    void Function(String)? onChanged,
  }) {
    return LDTextFormFields(
      keyboardType: TextInputType.text,
      controller: controller,
      hintText: hintText,
      onChanged: onChanged,
      inputFormatters: [
        FilteringTextInputFormatter.deny(RegExp(r'[^a-zA-Z\s]')),
      ],
      validator: (value) {
        if (value?.isEmpty ?? false) {
          return 'Complete the field';
        }
        return null;
      },
    );
  }

  /// [LDTextFormFields] that has a suffix icon and is readOnly
  factory LDTextFormFields.userDataField({
    required TextEditingController controller,
    required String hintText,
    required Widget suffixIcon,
    required bool readOnly,
    void Function(String)? onChanged,
  }) {
    return LDTextFormFields(
      keyboardType: TextInputType.text,
      controller: controller,
      hintText: hintText,
      onChanged: onChanged,
      readOnly: readOnly,
      suffixIcon: suffixIcon,
      inputFormatters: [
        FilteringTextInputFormatter.deny(RegExp(r'[^a-zA-Z\s]')),
      ],
      validator: (value) {
        if (value?.isEmpty ?? false) {
          return 'Complete the field';
        }
        return null;
      },
    );
  }

  /// [LDTextFormFields] that only allows numbers
  factory LDTextFormFields.onlyNumbers({
    TextEditingController? controller,
    Widget? suffixIcon,
    String? hintText,
    bool readOnly = false,
    String? initialValue,
    void Function(String)? onChanged,
  }) {
    return LDTextFormFields(
      keyboardType: TextInputType.number,
      readOnly: readOnly,
      controller: controller,
      hintText: hintText,
      onChanged: onChanged,
      initialValue: initialValue,
      suffixIcon: suffixIcon,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      validator: (value) {
        if (value?.isEmpty ?? false) {
          return 'Complete the field';
        }
        return null;
      },
    );
  }

  /// [LDTextFormFields] that only allows letters and numbers
  factory LDTextFormFields.lettersAndNumbers({
    required TextEditingController controller,
    required String hintText,
    void Function(String)? onChanged,
    IconData? prefixIcon,
    Widget? suffixIcon,
  }) {
    return LDTextFormFields(
      keyboardType: TextInputType.text,
      controller: controller,
      hintText: hintText,
      onChanged: onChanged,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      inputFormatters: [
        FilteringTextInputFormatter.deny(
          RegExp(r'[^a-zA-Z0-9\sñóäáéíóúüÜÁÉÍÓÚÑäÄöÖß]'),
        ),
      ],
      validator: (value) {
        if (value?.isEmpty ?? false) {
          return 'Complete the field';
        }
        return null;
      },
    );
  }

  /// [LDTextFormFields] that is vertically expandable with a maximum of lines
  factory LDTextFormFields.description({
    TextEditingController? controller,
    void Function(String)? onChanged,
    String? hintText,
    String? initialValue,
    int? maxLines,
  }) {
    return LDTextFormFields(
      controller: controller,
      hintText: hintText,
      onChanged: onChanged,
      initialValue: initialValue,
      maxLines: maxLines ?? 5,
      validator: (texto) {
        if (texto?.isEmpty ?? false) {
          return 'Complete the field';
        }
        return null;
      },
    );
  }

  /// [LDTextFormFields] that only allows email formatted text
  factory LDTextFormFields.email({
    TextEditingController? controller,
    Widget? suffixIcon,
    bool prefixIcon = true,
    String? hintText,
    bool readOnly = false,
    String? initialValue,
    void Function(String)? onChanged,
  }) {
    return LDTextFormFields(
      keyboardType: TextInputType.emailAddress,
      readOnly: readOnly,
      controller: controller,
      onChanged: onChanged,
      initialValue: initialValue,
      hintText: readOnly ? hintText : 'Email',
      prefixIcon: prefixIcon ? Icons.mail_outlined : null,
      suffixIcon: suffixIcon,
      validator: (email) {},
    );
  }

  /// Textfield to enter passwords
  factory LDTextFormFields.password({
    required String hintText,
    required Widget suffixIcon,
    required bool obscureText,
    void Function(String)? onChanged,
    TextEditingController? controller,
  }) {
    return LDTextFormFields(
      controller: controller,
      hintText: hintText,
      obscureText: obscureText,
      suffixIcon: suffixIcon,
      onChanged: onChanged,
      validator: (value) {
        if (value?.isEmpty ?? false) {
          return 'Complete the field';
        }
        return null;
      },
    );
  }

  /// [LDTextFormFields] controller
  final TextEditingController? controller;

  /// Defines if the [LDTextFormFields] is readOnly.
  final bool readOnly;

  /// Defines if the [LDTextFormFields] is obscureText.
  final bool obscureText;

  /// Placeholder text
  final String? hintText;

  /// Left icon
  final IconData? prefixIcon;

  /// Right icon
  final Widget? suffixIcon;

  /// Left icon color
  final Color? prefixIconColor;

  /// Keyboard type
  final TextInputType? keyboardType;

  /// Validation function
  final String? Function(String? value)? validator;

  /// onChanged function
  final void Function(String)? onChanged;

  /// Height of the text field.
  final double? height;

  /// Text formatters to restrict the user on what type of characters can be
  /// completed in the text field.
  final List<TextInputFormatter>? inputFormatters;

  /// Maximum characters to put
  final int? maxLength;

  /// Textfield decoration
  final InputDecoration? decoration;

  /// An object that can be used by a Stateful widget to obtain the focus of
  /// the keyboard and handle keyboard events.
  final FocusNode? focusNode;

  /// The maximum lines that the text field can take
  final int maxLines;

  /// Color used to mark error in the border of the textfield
  final Color? borderColor;

  /// Initial value of the textfield
  final String? initialValue;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      obscureText: obscureText,
      maxLength: maxLength,
      keyboardType: keyboardType ?? TextInputType.text,
      controller: controller,
      readOnly: readOnly,
      textAlignVertical: TextAlignVertical.center,
      style: TextStyle(
        color: readOnly ? GCColors.primary : Colors.black,
        fontSize: 12,
      ),
      inputFormatters: inputFormatters,
      initialValue: initialValue,
      decoration: decoration ??
          InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 10,
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.red,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            hintText: hintText,
            hintStyle: const TextStyle(color: Colors.grey),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: borderColor ?? const Color(0xff00B3A3).withOpacity(.5),
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: borderColor ?? const Color(0xff00B3A3),
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: readOnly ? const Color(0xff00B3A3) : Colors.white,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon != null
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          prefixIcon,
                          color: (controller?.text.isEmpty ?? false)
                              ? Colors.grey
                              : Colors.blue,
                          size: 24,
                        ),
                      ],
                    ),
                  )
                : null,
          ),
      validator: validator,
      onChanged: (value) => onChanged?.call(value),
    );
  }
}

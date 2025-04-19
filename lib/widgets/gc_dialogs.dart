import 'package:flutter/material.dart';
import 'package:guia_click/widgets/ld_buttons.dart';

/// {@template LDDialogs}
/// Dialogs for the application
/// {@endtemplate}
class LDDialogs extends StatelessWidget {
  /// {@macro LDDialogs}
  const LDDialogs({
    required this.onTapConfirm,
    this.withCancelButton = false,
    this.withOutlineButton = false,
    this.withConfirmButton = false,
    this.withCloseIcon = true,
    this.showButtons = true,
    this.isEnabled = true,
    this.height,
    this.width,
    this.title,
    this.content,
    this.onTapCancel,
    this.confirmButtonText,
    this.cancelButtonText,
    this.backgroundColorCancelButton = Colors.red,
    this.backgroundColorConfirmButton = Colors.green,
    super.key,
  });

  /// Confirmation dialog that shows a confirm button and a cancel button
  factory LDDialogs.actionRequest({
    required VoidCallback onTapConfirm,
    required bool isEnabled,
    required Widget? content,
    String? title,
    VoidCallback? onTapCancel,
    String? confirmButtonText,
    bool showButtons = true,
    bool withCancelButton = true,
  }) {
    return LDDialogs(
      confirmButtonText: confirmButtonText,
      isEnabled: isEnabled,
      onTapCancel: onTapCancel,
      onTapConfirm: onTapConfirm,
      withConfirmButton: true,
      withCloseIcon: false,
      withCancelButton: withCancelButton,
      content: content,
      title: title,
      showButtons: showButtons,
    );
  }

  /// Height of the [LDDialogs].
  final double? height;

  /// Width of the [LDDialogs].
  final double? width;

  /// Indicates whether to show the close icon in the [LDDialogs].
  final bool withCloseIcon;

  /// Indicates whether to show with outline button in the [LDDialogs].
  final bool withOutlineButton;

  /// Indicates whether to show with cancel button in the [LDDialogs].
  final bool withCancelButton;

  /// Indicates whether to show with confirm button in the [LDDialogs].
  final bool withConfirmButton;

  /// Callback for the confirm button, this is executed when pressing
  final void Function() onTapConfirm;

  /// Callback for the cancel button, this is executed when pressing
  final void Function()? onTapCancel;

  /// Title of [LDDialogs].
  final String? title;

  /// Content of [LDDialogs].
  final Widget? content;

  /// Text of the `Confirm` button of [LDDialogs].
  final String? confirmButtonText;

  /// Title of the `Cancel` button of [LDDialogs].
  final String? cancelButtonText;

  /// Background color of the `Cancel` button of [LDDialogs].
  final Color backgroundColorCancelButton;

  /// Background color of the `Confirm` button of [LDDialogs].
  final Color backgroundColorConfirmButton;

  /// Indicates whether the `Confirm` button of [LDDialogs] is enabled.
  final bool isEnabled;

  /// Indicates whether to show the buttons in the [LDDialogs].
  final bool showButtons;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white)
            .copyWith(surfaceTint: const Color(0xffafafa)),
      ),
      child: AlertDialog(
        content: SizedBox(
          height: height,
          width: width,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (title != null)
                    Flexible(
                      child: Text(
                        title!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  if (withCloseIcon)
                    Align(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                        onTap: Navigator.of(context).pop,
                        child: const Icon(
                          Icons.close,
                          size: 25,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: content ?? const SizedBox.shrink(),
              ),
            ],
          ),
        ),
        actionsAlignment: MainAxisAlignment.spaceEvenly,
        actions: [
          if (showButtons)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                if (withCancelButton)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: LDButtons.text(
                      adaptative: true,
                      onTap: () => onTapCancel ?? Navigator.of(context).pop(),
                      isEnabled: true,
                      text: cancelButtonText ?? 'Cancel',
                      backgroundColor: backgroundColorCancelButton,
                    ),
                  ),
                if (withOutlineButton)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: LDButtons.outlined(
                      adaptative: true,
                      onTap: isEnabled ? onTapConfirm : () {},
                      isEnabled: isEnabled,
                      text: confirmButtonText ?? 'ok',
                    ),
                  ),
                if (withConfirmButton)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: LDButtons.text(
                      adaptative: true,
                      onTap: isEnabled ? onTapConfirm : () {},
                      isEnabled: isEnabled,
                      backgroundColor: isEnabled
                          ? backgroundColorConfirmButton
                          : Colors.grey.withOpacity(0.5),
                      text: confirmButtonText ?? 'Confirm',
                    ),
                  ),
              ],
            ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../../app/constants/app_constants.dart';
import '../../extensions/context_extensions.dart';

class CustomAlertDialog extends StatelessWidget {
  CustomAlertDialog({
    Key? key,
    required this.context,
    required this.title,
    this.borderRadius,
    this.children,
    this.onPressedNegativeButton,
    this.onPressedPositiveButton,
    this.negativeButtonText,
    this.positiveButtonText,
    this.message,
    this.disableNegativeButton = false,
    this.disablePositiveButton = false,
    this.dismissible = true,
  }) : super(key: key);

  BuildContext context;
  double? borderRadius;
  bool disableNegativeButton;
  bool disablePositiveButton;
  String title;
  String? message;
  String? positiveButtonText;
  String? negativeButtonText;
  Function? onPressedNegativeButton;
  Function? onPressedPositiveButton;
  List<Widget>? children;
  bool dismissible;

  @override
  Widget build(BuildContext context) {
    return _buildDialog;
  }

  Future<void> show() => showDialog(
        barrierDismissible: dismissible,
        context: context,
        builder: (context) => this,
      );

  Widget get _buildDialog => AlertDialog(
        shape: _shape,
        content: Wrap(
          children: [
            Align(child: _buildTitleText, alignment: Alignment.center),
            const SizedBox(height: 45),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: (children ?? [_buildText]),
              ),
            ),
            _buildButtons,
          ],
        ),
      );

  ShapeBorder get _shape => RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? 12),
      );

  Widget get _buildText => Container(
        constraints: BoxConstraints(
          minHeight: 35.0,
          maxHeight: context.height / 1.5,
        ),
        child: SingleChildScrollView(
          child: Text(
            message ?? "",
            style: context.theme.textTheme.headline6?.copyWith(
              fontSize: context.width / 23,
              color: context.colorScheme.secondary,
            ),
            overflow: TextOverflow.fade,
          ),
        ),
      );

  FittedBox get _buildTitleText => FittedBox(
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: context.theme.textTheme.headline6?.copyWith(
            fontSize: context.width / 17,
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      );

  Row get _buildButtons => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          disableNegativeButton != true ? _buildNegativeButton : Container(),
          disablePositiveButton != true ? _buildPositiveButton : Container(),
        ],
      );

  TextButton get _buildNegativeButton => TextButton(
        onPressed: () {
          context.closeAlerDialog;
          if (onPressedNegativeButton != null) {
            onPressedNegativeButton!();
          }
        },
        child: Text(
          negativeButtonText ?? "Cancel",
          style: context.theme.textTheme.headline6?.copyWith(
            color: context.colorScheme.primary,
            fontSize: context.width / 25,
          ),
        ),
      );

  TextButton get _buildPositiveButton => TextButton(
        onPressed: () {
          context.closeAlerDialog;
          if (onPressedPositiveButton != null) {
            onPressedPositiveButton!();
          }
        },
        child: Text(
          positiveButtonText ?? "Confirm",
          style: context.theme.textTheme.headline6?.copyWith(
            color: context.colorScheme.primary,
            fontSize: context.width / 25,
          ),
        ),
      );
}

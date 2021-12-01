import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../app/constants/app_constants.dart';
import '../extensions/context_extensions.dart';

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
  bool dismissable = true;

  final double _titleTextSize = 25;

  @override
  Widget build(BuildContext context) {
    return _buildDialog;
  }

  show() => showDialog(
        barrierDismissible: dismissable,
        context: context,
        builder: (context) => this,
      );

  get _buildDialog => AlertDialog(
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
            style: GoogleFonts.ubuntu().copyWith(
              fontSize: 16,
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
          style: GoogleFonts.ubuntu().copyWith(
            fontSize: _titleTextSize,
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
        child: Text(negativeButtonText ?? "Cancel"),
      );
      
  TextButton get _buildPositiveButton => TextButton(
        onPressed: () {
          context.closeAlerDialog;
          if (onPressedPositiveButton != null) {
            onPressedPositiveButton!();
          }
        },
        child: Text(positiveButtonText ?? "Confirm"),
      );
}

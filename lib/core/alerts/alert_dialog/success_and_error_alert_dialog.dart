import 'package:flutter/material.dart';
import '../../extensions/context_extensions.dart';
import '../../extensions/int_extensions.dart';

Future showSuccessAlertDialog(BuildContext context) async {
  return showDialog(
    context: context,
    builder: (context) => _buildAlertDialog(context, AlertType.success),
  );
}

Future showErrorAlertDialog(BuildContext context) async {
  return showDialog(
    context: context,
    builder: (context) => _buildAlertDialog(context, AlertType.error),
  );
}

AlertDialog _buildAlertDialog(BuildContext context, AlertType alertType) {
  return AlertDialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        alertType == AlertType.success
            ? _buildTitle(
                context,
                title: 'Success',
                icon: Icons.check_circle,
                iconColor: Colors.green.shade600,
              )
            : _buildTitle(
                context,
                title: 'Error',
                icon: Icons.error,
                iconColor: Colors.red.shade600,
              ),
        25.sizedBoxOnlyHeight,
        alertType == AlertType.success
            ? _buildText(
                context,
                text: 'Report sent. Thanks for your report.',
                fontSize: context.width / 23,
              )
            : _buildText(
                context,
                text: 'The report couldn\'t be sent. Please try again.',
                fontSize: context.width / 23,
              ),
        25.sizedBoxOnlyHeight,
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () => context.pop,
              child: _buildText(
                context,
                text: 'Done',
                fontSize: context.width / 23,
                color: context.colorScheme.primary,
              ),
            )
          ],
        ),
      ],
    ),
  );
}

Row _buildTitle(
  BuildContext context, {
  required String title,
  required IconData icon,
  required Color iconColor,
}) =>
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildText(
          context,
          text: title,
          fontSize: context.width / 18,
          fontWeight: FontWeight.bold,
        ),
        10.sizedBoxOnlyWidth,
        Icon(
          icon,
          color: iconColor,
          size: context.width / 16,
        ),
      ],
    );

Text _buildText(
  BuildContext context, {
  required String text,
  required double fontSize,
  Color? color,
  FontWeight? fontWeight,
}) {
  return Text(
    text,
    style: context.theme.textTheme.headline6!.copyWith(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    ),
  );
}

enum AlertType { success, error }

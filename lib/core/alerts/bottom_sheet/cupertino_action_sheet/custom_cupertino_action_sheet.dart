import 'package:Carafe/core/extensions/context_extensions.dart';
import 'package:flutter/cupertino.dart';

class CustomCupertinoActionSheet extends StatelessWidget {
  CustomCupertinoActionSheet({
    Key? key,
    this.title,
    this.message,
    this.cancelButtonText,
    required this.actions,
    required this.context,
  });

  String? title;
  String? message;
  String? cancelButtonText;
  List<Widget> actions;
  BuildContext context;

  @override
  Widget build(BuildContext context) => CupertinoActionSheet(
        title: title == null ? null : _buildText(title!, context.width / 20),
        message:
            message == null ? null : _buildText(message!, context.width / 25),
        actions: actions,
        cancelButton: _cancelButton,
      );

  Widget? get _cancelButton => cancelButtonText == null
      ? null
      : CupertinoButton(
          child: _buildText(cancelButtonText!, context.width / 20),
          onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
        );

  _buildText(String message, double fontSize) => Text(
        message,
        style: context.theme.textTheme.headline6?.copyWith(
          color: context.colorScheme.secondary,
          fontSize: fontSize,
        ),
      );
}

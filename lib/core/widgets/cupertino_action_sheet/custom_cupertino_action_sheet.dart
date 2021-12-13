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
        title: title == null ? null : Text(title!),
        message: message == null ? null : Text(message!),
        actions: actions,
        cancelButton: _cancelButton,
      );

  Widget? get _cancelButton => cancelButtonText == null
      ? null
      : CupertinoButton(
          child: Text(cancelButtonText!),
          onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
        );
}

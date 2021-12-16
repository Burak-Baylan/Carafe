import 'package:flutter/material.dart';
import 'package:Carafe/core/extensions/context_extensions.dart';

class AuthenticationButton extends StatelessWidget {
  AuthenticationButton({
    Key? key,
    required this.onPressed,
    required this.text,
  }) : super(key: key);

  Widget? child;
  VoidCallback onPressed;
  String text;

  Text _buttonText(BuildContext context) => Text(
        text,
        style: TextStyle(color: Colors.white, fontSize: context.normalValue),
      );

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Center(child: _buttonText(context)),
      style: _buttonStyle(context),
    );
  }

  ButtonStyle _buttonStyle(BuildContext context) => ElevatedButton.styleFrom(
        padding: context.normalPadding,
        shape: const StadiumBorder(),
      );
}

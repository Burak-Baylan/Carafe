import 'package:Carafe/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class SettingsDescriptionText extends StatelessWidget {
  SettingsDescriptionText({
    Key? key,
    required this.text,
  }) : super(key: key);

  String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: context.theme.textTheme.headline6!.copyWith(
        fontSize: context.width / 23,
        color: Colors.grey.shade600
      ),
    );
  }
}

import 'package:Carafe/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class SettingsTitleText extends StatelessWidget {
  SettingsTitleText({
    Key? key,
    required this.text,
  }) : super(key: key);

  String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: context.theme.textTheme.headline6!.copyWith(
        color: context.colorScheme.secondary,
        fontSize: context.width / 24,
      ),
    );
  }
}

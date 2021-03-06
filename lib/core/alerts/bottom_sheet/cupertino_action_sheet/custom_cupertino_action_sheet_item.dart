import 'package:Carafe/core/extensions/context_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomCupertinoActionSheetItem extends StatelessWidget {
  CustomCupertinoActionSheetItem({
    Key? key,
    required this.onPressed,
    this.text = "",
    this.textColor,
    this.fontSize,
    this.fontWeight,
  }) : super(key: key);

  Function() onPressed;
  String text;
  Color? textColor;
  double? fontSize;
  FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return CupertinoActionSheetAction(
      onPressed: () => onPressed(),
      child: Text(
        text,
        style: context.theme.textTheme.headline6?.copyWith(
          color: textColor,
          fontSize: fontSize,
          fontWeight: fontWeight,
        ),
      ),
    );
  }
}

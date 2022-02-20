import 'package:Carafe/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class ProfileTextWidget extends StatelessWidget {
  ProfileTextWidget({
    Key? key,
    required this.text,
    this.maxLines = 1,
    this.color = Colors.black,
    this.fontSize,
    this.overflow = TextOverflow.ellipsis,
    this.fontWeight = FontWeight.normal,
    this.textAlign = TextAlign.left,
  }) : super(key: key);

  String text;
  int? maxLines;
  Color color;
  double? fontSize;
  TextOverflow overflow;
  FontWeight fontWeight;
  TextAlign textAlign;

  @override
  Widget build(BuildContext context) => Text(
        text,
        maxLines: maxLines,
        overflow: overflow,
        style: context.theme.textTheme.headline6?.copyWith(
          color: color,
          fontSize: fontSize ?? context.width / 25,
          fontWeight: fontWeight,
        ),
        textAlign: textAlign,
      );
}

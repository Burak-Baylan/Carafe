import 'package:flutter/material.dart';
import '../../../../../../../core/extensions/context_extensions.dart';

class PostStatusText extends StatelessWidget {
  PostStatusText({
    Key? key,
    required this.text,
    required this.fontSize,
    this.fontWeight = FontWeight.bold,
    this.textColor,
    this.maxLines = 1,
  }) : super(key: key);

  String text;
  double fontSize;
  FontWeight fontWeight = FontWeight.bold;
  Color? textColor;
  int? maxLines = 1;

  @override
  Widget build(BuildContext context) => Text(
        text.replaceAll("", "\u{200B}"),
        textWidthBasis: TextWidthBasis.longestLine,
        maxLines: maxLines,
        overflow: TextOverflow.ellipsis,
        style: context.theme.textTheme.headline6?.copyWith(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: textColor,
        ),
      );
}

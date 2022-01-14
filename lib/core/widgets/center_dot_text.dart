import 'package:Carafe/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class CenterDotText extends StatelessWidget {
  CenterDotText({
    Key? key,
    this.fontSize = 13,
    this.textColor = Colors.black,
    this.fontWeight = FontWeight.bold,
  }) : super(key: key);

  Color textColor;
  double fontSize = 13;
  FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return Text(
      " · ",
      overflow: TextOverflow.ellipsis,
      style: context.theme.textTheme.headline6?.copyWith(
        fontSize: fontSize,
        color: textColor,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

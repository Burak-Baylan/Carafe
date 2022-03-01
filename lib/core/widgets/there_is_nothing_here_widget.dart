import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../constants/svg/svg_constants.dart';
import '../extensions/context_extensions.dart';
import '../extensions/double_extensions.dart';
import '../extensions/widget_extension.dart';

class ThereIsNothingHereWidget extends StatelessWidget {
  const ThereIsNothingHereWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          SVGConstants.nothingHere,
          height: context.height / 3.5,
          width: context.width / 2,
        ),
        20.0.sizedBoxOnlyHeight,
        Text(
          'There is nothing here',
          textAlign: TextAlign.center,
          style: context.theme.textTheme.headline6?.copyWith(
            fontSize: context.width / 16,
            color: context.colorScheme.secondary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ).center;
  }
}

import 'package:flutter/material.dart';
import '../../../../../core/extensions/context_extensions.dart';
import '../../../../../core/extensions/double_extensions.dart';
import '../../../../../core/widgets/place_holder_with_border.dart';

class ProfileViewDescriptionPlaceHolder extends StatelessWidget {
  ProfileViewDescriptionPlaceHolder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Column(
        children: [
          FittedBox(
            child: Row(
              children: [
                PlaceHolderWithBorder(width: context.width / 5),
                3.5.sizedBoxOnlyWidth,
                PlaceHolderWithBorder(width: context.width / 3),
                3.5.sizedBoxOnlyWidth,
                PlaceHolderWithBorder(width: context.width / 5),
                3.5.sizedBoxOnlyWidth,
                PlaceHolderWithBorder(width: context.width / 6),
                3.5.sizedBoxOnlyWidth,
                PlaceHolderWithBorder(width: context.width / 3),
                3.5.sizedBoxOnlyWidth,
                PlaceHolderWithBorder(width: context.width / 5),
              ],
            ),
          ),
          5.0.sizedBoxOnlyHeight,
          FittedBox(
            child: Row(
              children: [
                PlaceHolderWithBorder(width: context.width / 6),
                3.5.sizedBoxOnlyWidth,
                PlaceHolderWithBorder(width: context.width / 5),
                3.5.sizedBoxOnlyWidth,
                PlaceHolderWithBorder(width: context.width / 5),
                3.5.sizedBoxOnlyWidth,
                PlaceHolderWithBorder(width: context.width / 3),
                3.5.sizedBoxOnlyWidth,
                PlaceHolderWithBorder(width: context.width / 6),
                3.5.sizedBoxOnlyWidth,
                PlaceHolderWithBorder(width: context.width / 3),
              ],
            ),
          ),
          5.0.sizedBoxOnlyHeight,
          FittedBox(
            child: Row(
              children: [
                PlaceHolderWithBorder(width: context.width / 2),
                3.5.sizedBoxOnlyWidth,
                PlaceHolderWithBorder(width: context.width / 4),
                3.5.sizedBoxOnlyWidth,
                PlaceHolderWithBorder(width: context.width / 8),
                3.5.sizedBoxOnlyWidth,
                PlaceHolderWithBorder(width: context.width / 2),
                3.5.sizedBoxOnlyWidth,
                PlaceHolderWithBorder(width: context.width / 5),
                3.5.sizedBoxOnlyWidth,
                PlaceHolderWithBorder(width: context.width / 6),
              ],
            ),
          )
        ],
      ),
    );
  }
}

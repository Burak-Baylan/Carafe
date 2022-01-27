import 'package:flutter/material.dart';
import '../../../../../core/extensions/context_extensions.dart';
import '../../../../../core/extensions/double_extensions.dart';
import '../../../../../core/widgets/place_holder_with_border.dart';

class ProfileFollowingAndFollowersPlaceHolderLayout extends StatelessWidget {
  ProfileFollowingAndFollowersPlaceHolderLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        placeHolder(context),
        10.0.sizedBoxOnlyWidth,
        placeHolder(context),
      ],
    );
  }

  Widget placeHolder(BuildContext context) => Column(
        children: [
          PlaceHolderWithBorder(
            width: context.width / 11,
          ),
          3.0.sizedBoxOnlyHeight,
          PlaceHolderWithBorder(
            width: context.width / 7,
          ),
        ],
      );
}

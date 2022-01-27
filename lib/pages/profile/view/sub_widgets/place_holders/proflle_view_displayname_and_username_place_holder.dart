import 'package:flutter/material.dart';
import '../../../../../core/extensions/context_extensions.dart';
import '../../../../../core/extensions/double_extensions.dart';
import '../../../../../core/widgets/place_holder_with_border.dart';

class ProfileViewDisplaynameAndUsernamePlaceHolder extends StatelessWidget {
  ProfileViewDisplaynameAndUsernamePlaceHolder({Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PlaceHolderWithBorder(
          width: context.width / 7,
          height: context.height / 50,
        ),
        5.0.sizedBoxOnlyHeight,
        PlaceHolderWithBorder(
          width: context.width / 7,
          height: context.height / 50,
        ),
      ],
    );
  }
}

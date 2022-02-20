import 'package:flutter/material.dart';
import '../../../../../../core/extensions/context_extensions.dart';
import '../../../../../../core/widgets/place_holder_with_border.dart';

class ProfileViewFollowButtonPlaceHolder extends StatelessWidget {
  ProfileViewFollowButtonPlaceHolder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PlaceHolderWithBorder(
      width: double.infinity,
      height: context.height / 20,
    );
  }
}

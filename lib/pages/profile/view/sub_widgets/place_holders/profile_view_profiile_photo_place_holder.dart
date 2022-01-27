import 'package:flutter/material.dart';
import '../../../../../app/constants/app_constants.dart';
import '../../../../../core/extensions/context_extensions.dart';
import '../../../../../core/widgets/border_container.dart';

class ProfileViewProfilePhotoPlaceHolder extends StatelessWidget {
  ProfileViewProfilePhotoPlaceHolder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BorderContainer.all(
      radius: 100,
      width: context.width / 4,
      height: context.width / 4,
      color: AppColors.placeHolderGray,
    );
  }
}

import 'package:flutter/material.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/widgets/full_screen_image.dart';
import '../../../main/view/sub_views/post_widget/post_widget/sub_widgets/profile_photo.dart';
import '../../view_model/profile_view_model.dart';

class ProfileViewProfilePhotoWidget extends StatelessWidget {
  ProfileViewProfilePhotoWidget({
    Key? key,
    required this.profileViewModel,
  }) : super(key: key);

  ProfileViewModel profileViewModel;

  @override
  Widget build(BuildContext context) {
    return PostProfilePhoto(
      imageUrl: 'https://via.placeholder.com/140x100',
      height: context.width / 4,
      width: context.width / 4,
      onClicked: (provider) => profileViewModel.customNavigateToPage(
        page: FullScreenImage(tag: '', image: provider),
        animate: true,
      ),
    );
  }
}

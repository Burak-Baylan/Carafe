import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../../../../core/extensions/context_extensions.dart';
import '../../../../main/view/sub_views/post_widget/post_widget/sub_widgets/post_full_screen_image.dart';
import '../../../../main/view/sub_views/post_widget/post_widget/sub_widgets/profile_photo.dart';
import '../../../view_model/profile_view_model/profile_view_model.dart';

class ProfileViewProfilePhotoWidget extends StatefulWidget {
  ProfileViewProfilePhotoWidget({
    Key? key,
    required this.profileViewModel,
  }) : super(key: key);

  ProfileViewModel profileViewModel;

  @override
  State<ProfileViewProfilePhotoWidget> createState() =>
      _ProfileViewProfilePhotoWidgetState();
}

class _ProfileViewProfilePhotoWidgetState
    extends State<ProfileViewProfilePhotoWidget> {
  @override
  Widget build(BuildContext context) => Observer(
        builder: (_) => PostProfilePhoto(
          imageUrl: widget.profileViewModel.ppUrl,
          height: context.width / 4,
          width: context.width / 4,
          onClicked: (provider) => widget.profileViewModel.customNavigateToPage(
            page: PostFullScreenImage(
              imageUrl: widget.profileViewModel.ppUrl ?? '',
              imageProvider: provider,
            ),
          ),
        ),
      );
}

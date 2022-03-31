import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../../../../core/extensions/context_extensions.dart';
import '../../../../../core/extensions/double_extensions.dart';
import '../../../view_model/profile_view_model/profile_view_model.dart';
import 'profile_text_widget.dart';

class ProfileViewDisplaynameAndUsernameWidget extends StatefulWidget {
  ProfileViewDisplaynameAndUsernameWidget(
      {Key? key, required this.profileViewModel})
      : super(key: key);

  ProfileViewModel profileViewModel;

  @override
  State<ProfileViewDisplaynameAndUsernameWidget> createState() =>
      _ProfileViewDisplaynameAndUsernameWidgetState();
}

class _ProfileViewDisplaynameAndUsernameWidgetState
    extends State<ProfileViewDisplaynameAndUsernameWidget> {
  Icon get verifiedIcon => Icon(
        Icons.verified,
        color: context.colorScheme.secondary,
        size: context.width / 21,
      );

  late ProfileViewModel profileViewModel;

  @override
  Widget build(BuildContext context) {
    profileViewModel = widget.profileViewModel;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Observer(
              builder: (_) => ProfileTextWidget(
                text: profileViewModel.displayName,
                fontWeight: FontWeight.bold,
                fontSize: context.width / 20,
              ),
            ),
            3.5.sizedBoxOnlyWidth,
            profileViewModel.userModel!.verified ? verifiedIcon : Container()
          ],
        ),
        Observer(
          builder: (_) => ProfileTextWidget(
            text: '@' + profileViewModel.username,
            fontSize: context.width / 25,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }
}

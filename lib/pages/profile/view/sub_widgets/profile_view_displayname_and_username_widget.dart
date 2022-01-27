import 'package:flutter/material.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/extensions/double_extensions.dart';
import '../../../authenticate/model/user_model.dart';
import 'profile_text_widget.dart';

class ProfileViewDisplaynameAndUsernameWidget extends StatefulWidget {
  ProfileViewDisplaynameAndUsernameWidget({
    Key? key,
    required this.userModel,
  }) : super(key: key);

  UserModel userModel;

  @override
  State<ProfileViewDisplaynameAndUsernameWidget> createState() =>
      _ProfileViewDisplaynameAndUsernameWidgetState();
}

class _ProfileViewDisplaynameAndUsernameWidgetState
    extends State<ProfileViewDisplaynameAndUsernameWidget> {
  Icon get verifiedIcon => Icon(
        Icons.check_circle,
        color: context.colorScheme.secondary,
        size: context.width / 21,
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            ProfileTextWidget(
              text: widget.userModel.displayName,
              fontWeight: FontWeight.bold,
              fontSize: context.width / 20,
            ),
            3.5.sizedBoxOnlyWidth,
            widget.userModel.verified ? verifiedIcon : Container()
          ],
        ),
        ProfileTextWidget(
          text: '@' + widget.userModel.username,
          fontSize: context.width / 25,
          color: Colors.grey.shade600,
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../../../../core/extensions/context_extensions.dart';
import '../../../../../core/extensions/int_extensions.dart';
import '../../../view_model/profile_view_model/profile_view_model.dart';
import 'profile_text_widget.dart';

class ProfileViewFollowButton extends StatefulWidget {
  ProfileViewFollowButton({
    Key? key,
    required this.profileViewModel,
  }) : super(key: key);

  ProfileViewModel profileViewModel;

  @override
  State<ProfileViewFollowButton> createState() =>
      _ProfileViewFollowButtonState();
}

class _ProfileViewFollowButtonState extends State<ProfileViewFollowButton> {
  Color get getButtonColor => widget.profileViewModel.profileOwner
      ? context.colorScheme.secondary
      : context.colorScheme.primary;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        style: ElevatedButton.styleFrom(
          onPrimary: getButtonColor,
          shape: RoundedRectangleBorder(
            borderRadius: 50.radiusAll,
            side: BorderSide(color: getButtonColor),
          ),
        ),
        onPressed: () => widget.profileViewModel
            .followButtonClicked(widget.profileViewModel),
        child: Observer(builder: (_) {
          return ProfileTextWidget(
            text: widget.profileViewModel.profileOwner
                ? 'Edit Profile'
                : ((widget.profileViewModel.isUserFollowing ?? false)
                    ? 'Following'
                    : 'Follow'),
            fontSize: context.width / 23,
            fontWeight: FontWeight.w600,
            color: getButtonColor,
            textAlign: TextAlign.center,
          );
        }),
      ),
    );
  }
}

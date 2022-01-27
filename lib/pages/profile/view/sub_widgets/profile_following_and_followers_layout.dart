import 'package:flutter/material.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/extensions/int_extensions.dart';
import '../../view_model/profile_view_model.dart';
import 'profile_text_widget.dart';

class ProfileFollowingAndFollowersLayout extends StatelessWidget {
  ProfileFollowingAndFollowersLayout({
    Key? key,
    required this.userId,
    required this.profileViewModel,
  }) : super(key: key);

  String userId;
  ProfileViewModel profileViewModel;

  late Future userNamesFuture;

  @override
  Widget build(BuildContext context) {
    _initializeValues(context);
    return _buildLayout(context);
  }

  _initializeValues(BuildContext context) {
    userNamesFuture = profileViewModel.getFollowingAndFollowersCount();
  }

  Future getInformations() async {}

  _buildLayout(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ProfileTextWidget(
              text: profileViewModel.userModel!.followersCount.shorten,
              fontWeight: FontWeight.w600,
              fontSize: context.width / 25,
            ),
            ProfileTextWidget(
              text: 'Followers',
              fontWeight: FontWeight.w300,
              fontSize: context.width / 25,
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ProfileTextWidget(
              text: profileViewModel.userModel!.followingCount.shorten,
              fontWeight: FontWeight.w600,
              fontSize: context.width / 25,
            ),
            ProfileTextWidget(
              text: 'Following',
              fontWeight: FontWeight.w300,
              fontSize: context.width / 25,
            ),
          ],
        ),
      ],
    );
  }
}

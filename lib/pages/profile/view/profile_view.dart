import 'package:Carafe/pages/profile/view/sub_widgets/profile_page_place_holder.dart';
import 'package:flutter/material.dart';
import '../../../core/extensions/context_extensions.dart';
import '../../../core/extensions/double_extensions.dart';
import '../view_model/profile_view_model.dart';
import 'sub_widgets/profile_view_profile_photo_widget.dart';
import 'sub_widgets/profile_following_and_followers_layout.dart';
import 'sub_widgets/profile_text_widget.dart';
import 'sub_widgets/profile_view_displayname_and_username_widget.dart';
import 'sub_widgets/profile_view_follow_button.dart';
import 'sub_widgets/profile_view_send_message_widget.dart';

class ProfileView extends StatefulWidget {
  ProfileView({
    Key? key,
    required this.userId,
  }) : super(key: key);

  String userId;

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  ProfileViewModel profileViewModel = ProfileViewModel();
  late Future<bool> initializeUserInformationsFuture;

  Future _initializeValues() async {
    profileViewModel.setContext(context);
    profileViewModel.setUserId(widget.userId);
    initializeUserInformationsFuture =
        profileViewModel.initializeInformations();
  }

  @override
  Widget build(BuildContext context) {
    _initializeValues();
    return Scaffold(
      appBar: _appBar,
      body: FutureBuilder<bool>(
        future: initializeUserInformationsFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null && snapshot.data!) {
            return buildBody;
          }
          if (snapshot.hasError) {
            //ERROR PAGE
          }
          return ProfilePagePlaceHolder();
        },
      ),
    );
  }

  Widget get buildBody => Container(
        margin: 15.0.edgeIntesetsAll,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [profilePhoto, followCountsAndFollowButton],
            ),
            15.0.sizedBoxOnlyHeight,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [displaynameAndUsername, sendMessageWidget],
            ),
            8.0.sizedBoxOnlyHeight,
            description,
          ],
        ),
      );

  Widget get sendMessageWidget => ProfileViewSendMessageWidget();

  Widget get displaynameAndUsername => Flexible(
        child: ProfileViewDisplaynameAndUsernameWidget(
          userModel: profileViewModel.userModel!,
        ),
      );

  Widget get profilePhoto =>
      ProfileViewProfilePhotoWidget(profileViewModel: profileViewModel);

  Widget get description => ProfileTextWidget(
        text: profileViewModel.userModel!.profileDescription ?? '',
        color: Colors.grey.shade800,
        fontSize: context.width / 28,
        maxLines: null,
        overflow: TextOverflow.visible,
      );

  Widget get followCountsAndFollowButton => Expanded(
        child: Container(
          margin: 15.0.edgeIntesetsRightLeft,
          height: context.width / 4,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ProfileFollowingAndFollowersLayout(
                userId: widget.userId,
                profileViewModel: profileViewModel,
              ),
              ProfileViewFollowButton(profileViewModel: profileViewModel),
            ],
          ),
        ),
      );

  AppBar get _appBar => AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () => context.pop,
        ),
        title: Text(
          "Profile",
          style: TextStyle(
            fontSize: context.width / 20,
            color: context.theme.colorScheme.primary,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.more_vert_rounded,
              color: context.colorScheme.primary,
            ),
          ),
        ],
        iconTheme: IconThemeData(color: context.theme.colorScheme.primary),
      );
}

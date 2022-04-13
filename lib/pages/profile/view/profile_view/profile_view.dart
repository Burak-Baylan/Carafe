import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/extensions/double_extensions.dart';
import '../../../../core/extensions/timestamp_extensions.dart';
import '../../../../core/helpers/open_link.dart';
import '../../view_model/profile_view_model/profile_view_model.dart';
import 'profile_view_body.dart';
import 'sub_widgets/profile_following_and_followers_layout.dart';
import 'sub_widgets/profile_page_place_holder.dart';
import 'sub_widgets/profile_text_widget.dart';
import 'sub_widgets/profile_view_displayname_and_username_widget.dart';
import 'sub_widgets/profile_view_follow_button.dart';
import 'sub_widgets/profile_view_profile_photo_widget.dart';

class ProfileView extends StatefulWidget {
  ProfileView({
    Key? key,
    required this.userId,
  }) : super(key: key);

  String userId;

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  ProfileViewModel profileViewModel = ProfileViewModel();
  late Future<bool> initializeUserInformationsFuture;

  @override
  void initState() {
    super.initState();
    profileViewModel.setContext(context);
    profileViewModel.setUserId(widget.userId);
    initializeUserInformationsFuture =
        profileViewModel.initializeInformations();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appBar,
      body: FutureBuilder<bool>(
        future: initializeUserInformationsFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null && snapshot.data!) {
            return ProfileViewBody(
              profileViewModel: profileViewModel,
              body: bodyLayout,
            );
          }
          if (snapshot.hasError) {
            //ERROR PAGE
          }
          return ProfilePagePlaceHolder();
        },
      ),
    );
  }

  Widget get bodyLayout => Container(
        margin: 15.0.edgeIntesetsAll,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
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
            buildDescription,
            buildLink,
            3.0.sizedBoxOnlyHeight,
            buildCreatedAt,
          ],
        ),
      );

  Widget get sendMessageWidget => profileViewModel.profileOwner
      ? Container()
      : Container(); //ProfileViewSendMessageWidget();

  Widget get displaynameAndUsername => Flexible(
        child: ProfileViewDisplaynameAndUsernameWidget(
          profileViewModel: profileViewModel,
        ),
      );

  Widget get profilePhoto =>
      ProfileViewProfilePhotoWidget(profileViewModel: profileViewModel);

  Widget get buildDescription => Observer(
        builder: (_) {
          String? description = profileViewModel.description;
          return (description != null && description != '')
              ? Column(
                  children: [
                    ProfileTextWidget(
                      text: profileViewModel.description!,
                      color: Colors.grey.shade900,
                      fontSize: context.width / 24.5,
                      maxLines: null,
                      overflow: TextOverflow.visible,
                    ),
                    8.0.sizedBoxOnlyHeight,
                  ],
                )
              : Container();
        },
      );

  Widget get buildCreatedAt {
    var createdAt = profileViewModel.userModel?.createdAt?.longDate;
    return (createdAt != null && createdAt != '')
        ? Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.date_range_outlined,
                color: Colors.grey.shade700,
                size: context.width / 19,
              ),
              3.0.sizedBoxOnlyWidth,
              Flexible(
                child: ProfileTextWidget(
                  text: 'Joined ' + createdAt,
                  color: Colors.grey.shade700,
                  fontSize: context.width / 23,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          )
        : Container();
  }

  Widget get buildLink => Observer(builder: (context) {
        return (profileViewModel.userModel!.website != null &&
                profileViewModel.userModel!.website != '')
            ? Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Flexible(
                    flex: 1,
                    child: Icon(
                      Icons.link,
                      color: Colors.grey.shade700,
                      size: context.width / 20,
                    ),
                  ),
                  3.0.sizedBoxOnlyWidth,
                  Expanded(
                    flex: 9,
                    child: SelectableLinkify(
                      onOpen: (link) async => await goToLink(link.url),
                      text: profileViewModel.website!,
                      maxLines: 1,
                    ),
                  ),
                ],
              )
            : Container();
      });

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
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () => context.pop,
        ),
        title: Observer(
          builder: (_) => Text(
            '${profileViewModel.userModel?.displayName ?? ''}\'s Profile',
            style: TextStyle(
              fontSize: context.width / 20,
              color: context.theme.colorScheme.primary,
            ),
          ),
        ),
        bottom: PreferredSize(
          child: const Divider(height: 0),
          preferredSize: Size(context.width, 1),
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

  @override
  bool get wantKeepAlive => true;
}

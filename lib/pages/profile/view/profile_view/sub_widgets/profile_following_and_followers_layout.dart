import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../../../../core/extensions/context_extensions.dart';
import '../../../../../core/extensions/double_extensions.dart';
import '../../../../../core/extensions/int_extensions.dart';
import '../../../../main/sub_views/users_list_view/view/users_list_view.dart';
import '../../../../main/sub_views/users_list_view/view_model/users_list_view_model.dart';
import '../../../view_model/profile_view_model/profile_view_model.dart';
import 'profile_text_widget.dart';

class ProfileFollowingAndFollowersLayout extends StatefulWidget {
  ProfileFollowingAndFollowersLayout({
    Key? key,
    required this.userId,
    required this.profileViewModel,
  }) : super(key: key);

  String userId;
  ProfileViewModel profileViewModel;

  @override
  State<ProfileFollowingAndFollowersLayout> createState() =>
      _ProfileFollowingAndFollowersLayoutState();
}

class _ProfileFollowingAndFollowersLayoutState
    extends State<ProfileFollowingAndFollowersLayout> {
  late Future userNamesFuture;

  @override
  Widget build(BuildContext context) {
    _initializeValues(context);
    return _buildLayout(context);
  }

  _initializeValues(BuildContext context) {
    userNamesFuture = widget.profileViewModel.getFollowingAndFollowersCount();
  }

  Future getInformations() async {}

  Widget _buildLayout(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Observer(
          builder: (context) => _buildWidget(
            text: 'Followers',
            userListType: UserListType.followerUsers,
            collectionName:
                widget.profileViewModel.firebaseConstants.followersText,
            count: widget.profileViewModel.followersCount,
          ),
        ),
        Observer(
          builder: (context) => _buildWidget(
            text: 'Following',
            userListType: UserListType.followingUsers,
            collectionName:
                widget.profileViewModel.firebaseConstants.followingText,
            count: widget.profileViewModel.followingCount,
          ),
        ),
      ],
    );
  }

  Widget _buildWidget({
    required String text,
    required String collectionName,
    required UserListType userListType,
    required int count,
  }) =>
      InkWell(
        borderRadius: 10.borderRadiusCircular,
        onTap: () => navigatePage(
          titleText: text,
          userListType: userListType,
          collectionName: collectionName,
        ),
        child: Padding(
          padding: 8.0.edgeIntesetsAll,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ProfileTextWidget(
                text: count.shorten,
                fontWeight: FontWeight.w600,
                fontSize: context.width / 25,
              ),
              ProfileTextWidget(
                text: text,
                fontWeight: FontWeight.w300,
                fontSize: context.width / 25,
              ),
            ],
          ),
        ),
      );

  Query<Map<String, dynamic>> _buildRef(String collectionName) =>
      widget.profileViewModel.allUsersCollectionRef
          .doc(widget.userId)
          .collection(collectionName);

  void navigatePage({
    required String titleText,
    required UserListType userListType,
    required String collectionName,
  }) {
    widget.profileViewModel.customNavigateToPage(
      page: UsersListView(
        appBarText: titleText,
        userListType: userListType,
        listingUsersRef: _buildRef(collectionName),
      ),
      animate: true,
    );
  }
}

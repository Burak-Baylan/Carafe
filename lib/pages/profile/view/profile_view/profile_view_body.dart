// ignore_for_file: must_call_super

import 'package:Carafe/core/extensions/widget_extension.dart';
import 'package:Carafe/core/widgets/center_dot_text.dart';
import 'package:Carafe/pages/profile/view/users_profile_other_shares_page/view/users_profile_other_shares_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/extensions/double_extensions.dart';
import '../../../../core/extensions/int_extensions.dart';
import '../../../../core/widgets/small_circular_progress_indicator.dart';
import '../../../../main.dart';
import '../../../main/model/post_model.dart';
import '../../../main/view/sub_views/post_widget/post_widget/post_widget.dart';
import '../../view_model/profile_view_model/profile_view_model.dart';

class ProfileViewBody extends StatefulWidget {
  ProfileViewBody({
    Key? key,
    required this.profileViewModel,
    required this.body,
  }) : super(key: key);

  ProfileViewModel profileViewModel;
  Widget body;

  @override
  State<ProfileViewBody> createState() => _ProfileViewBodyState();
}

class _ProfileViewBodyState extends State<ProfileViewBody>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    profileVm = widget.profileViewModel;
    userPostsFuture = profileVm.userPostsFuture();
    super.initState();
  }

  GlobalKey appBarKey = GlobalKey();
  late ProfileViewModel profileVm;
  late Future userPostsFuture;

  @override
  Widget build(BuildContext context) => Observer(
        builder: (context) => RefreshIndicator(
          onRefresh: () => profileVm.refreshPage(),
          child: SingleChildScrollView(
            controller: profileVm.postListController,
            physics: profileVm.cartPhysics,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                widget.body,
                10.0.sizedBoxOnlyHeight,
                tabBar,
                10.0.sizedBoxOnlyHeight,
                const Divider(height: 0, thickness: 1),
                buildSharedPosts(modelList: profileVm.userPosts, docRefs: null),
              ],
            ),
          ),
        ),
      );

  Widget get tabBar => Stack(children: [
        Align(alignment: Alignment.centerLeft, child: buildTabBarText),
        Align(alignment: Alignment.centerRight, child: buildTabBarRightArrow)
      ]);

  Widget get buildTabBarRightArrow => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            borderRadius: 10.borderRadiusCircular,
            onTap: () => profileVm.customNavigateToPage(
              page: UsersProfileOtherSharesPage(profileViewModel: profileVm),
              animate: true,
            ),
            child: Icon(
              Icons.chevron_right_rounded,
              color: context.colorScheme.secondary,
              size: context.width / 13,
            ),
          ),
          12.0.sizedBoxOnlyWidth,
        ],
      );

  Widget get buildTabBarText => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          15.0.sizedBoxOnlyWidth,
          Text(
            'Posts',
            textAlign: TextAlign.center,
            style: context.theme.textTheme.headline6?.copyWith(
              fontSize: context.width / 17,
              color: context.colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          Icon(
            Icons.keyboard_arrow_down_rounded,
            color: context.colorScheme.primary,
            size: context.width / 13,
          ),
        ],
      );

  Widget buildSharedPosts({
    required List<PostModel> modelList,
    required List<DocumentReference?>? docRefs,
  }) =>
      FutureBuilder(
        future: userPostsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Observer(
              builder: (_) => postsListViewBuilder(modelList, docRefs),
            );
          }
          return Column(
            children: [
              10.0.sizedBoxOnlyHeight,
              const SmallCircularProgressIndicator(),
            ],
          );
        },
      );

  Widget postsListViewBuilder(
    List<PostModel> modelList,
    List<DocumentReference<Object?>?>? docRefs,
  ) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: profileVm.userPostsLength,
      itemBuilder: (context, index) =>
          postWidgetBuilder(index, modelList: modelList, docRefs: docRefs),
    );
  }

  Widget postWidgetBuilder(
    int index, {
    required List<PostModel> modelList,
    required List<DocumentReference?>? docRefs,
  }) {
    if (index == 0) {
      return buildPinnedPost();
    }
    var postModel = modelList[index - 1];
    var docRef = docRefs?[index - 1];
    if (profileVm.checkIfSameWithPinnedPost(postModel.postId)) {
      return Container();
    } else {
      if (index == modelList.length) {
        return buildWidgetWithSpace(postModel, docRef);
      } else {
        return buildPostWidget(postModel, docRef);
      }
    }
  }

  Widget buildWidgetWithSpace(
    PostModel postModel,
    DocumentReference<Object?>? docRef,
  ) =>
      Column(
        children: [
          buildPostWidget(postModel, docRef),
          50.0.sizedBoxOnlyHeight,
          CenterDotText().center,
          50.0.sizedBoxOnlyHeight,
        ],
      );

  Widget buildPinnedPost() {
    var pinnedPostModel = profileVm.pinnedPost;
    if (pinnedPostModel == null) {
      return Container();
    } else {
      var ref = profileVm.firestore.doc(pinnedPostModel.postPath);
      return buildPostWidget(pinnedPostModel, ref, isPostPinned: true);
    }
  }

  Widget buildPostWidget(
    PostModel model,
    DocumentReference<Object?>? postRef, {
    bool isPostPinned = false,
  }) =>
      PostWidget(
        model: model,
        postRef: postRef,
        closeCardView: mainVm.isTypeFlatView,
        isPostPinned: isPostPinned,
        onPostPinnedOrUnpinned: () => profileVm.refreshPage(),
      );

  @override
  bool get wantKeepAlive => true;
}

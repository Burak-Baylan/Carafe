import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../../../../core/extensions/context_extensions.dart';
import '../../../../../core/extensions/double_extensions.dart';
import '../../../../../core/extensions/widget_extension.dart';
import '../../../../../core/widgets/center_dot_text.dart';
import '../../../../../core/widgets/small_circular_progress_indicator.dart';
import '../../../../../core/widgets/something_went_wrong_widget.dart';
import '../../../../../core/widgets/there_is_nothing_here_widget.dart';
import '../../../../../main.dart';
import '../../../../main/model/post_model.dart';
import '../../../../main/view/sub_views/post_widget/post_widget/post_widget.dart';
import '../../../view_model/profile_view_model/profile_view_model.dart';
import '../view_model/users_profile_other_shares_page_view_model.dart';

class UsersProfileOtherSharesPage extends StatefulWidget {
  UsersProfileOtherSharesPage({
    Key? key,
    required this.profileViewModel,
  }) : super(key: key);

  ProfileViewModel profileViewModel;

  @override
  State<UsersProfileOtherSharesPage> createState() =>
      _UsersProfileOtherSharesPageState();
}

class _UsersProfileOtherSharesPageState
    extends State<UsersProfileOtherSharesPage>
    with AutomaticKeepAliveClientMixin {
  UsersProfileOtherSharesPageViewModel usersOtherSharesVm =
      UsersProfileOtherSharesPageViewModel();
  @override
  void initState() {
    super.initState();
    profileVm = widget.profileViewModel;
    usersOtherSharesVm.setContext(context);
    usersOtherSharesVm.setProfileModel(profileVm);
    usersOtherSharesVm.initializeViewModel();
    mediaPostsFuture = usersOtherSharesVm.getMediaPosts();
    likedPostsFuture = usersOtherSharesVm.getLikedPosts();
  }

  late Future<void> mediaPostsFuture;
  late Future<void> likedPostsFuture;
  late ProfileViewModel profileVm;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: _appBar,
        body: TabBarView(
          children: [
            FutureBuilder(
              future: likedPostsFuture,
              builder: (context, snapshot) => buildPostList(
                listViewWidget: likedPostsList,
                listIsEmpty: usersOtherSharesVm.likedPosts.isEmpty,
                snapshot: snapshot,
              ),
            ),
            FutureBuilder(
              future: mediaPostsFuture,
              builder: (context, snapshot) => buildPostList(
                listViewWidget: mediaPostsList,
                listIsEmpty: usersOtherSharesVm.mediaPosts.isEmpty,
                snapshot: snapshot,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPostList({
    required AsyncSnapshot<Object?> snapshot,
    required Widget listViewWidget,
    required bool listIsEmpty,
  }) =>
      Builder(builder: (context) {
        if (snapshot.connectionState == ConnectionState.done &&
            !snapshot.hasError) {
          return listIsEmpty ? noPostsHereWidget : listViewWidget;
        }
        if (snapshot.hasError) {
          return errorWidget;
        }
        return const SmallCircularProgressIndicator().center;
      });

  Widget get noPostsHereWidget => const ThereIsNothingHereWidget();
  Widget get errorWidget => const SomethingWentWrongWidget();

  Widget get likedPostsList => RefreshIndicator(
        onRefresh: () => usersOtherSharesVm.getLikedPosts(),
        child: Observer(builder: (context) => likedPostListViewBuilder),
      );

  Widget get likedPostListViewBuilder => ListView.builder(
        key: PageStorageKey(usersOtherSharesVm.likedPosts.first.postId),
        controller: usersOtherSharesVm.likedPostsScrollController,
        physics: usersOtherSharesVm.likedPostsScrollPhysics,
        itemCount: usersOtherSharesVm.likedPosts.length,
        itemBuilder: (context, index) {
          var likedPost = usersOtherSharesVm.getLikedPost(index);
          Widget postWidget = likedPostWidget(likedPost);
          return buildMediaPost(
              index, postWidget, usersOtherSharesVm.likedPosts);
        },
      );

  Widget likedPostWidget(PostModel postModel) => PostWidget(
        model: postModel,
        closeCardView: mainVm.isTypeFlatView,
        postRef: usersOtherSharesVm.getPostRef(postModel.postPath),
      );

  Widget pageBottomExtraWidget(int index, List<PostModel> postList) {
    if (postList.length - 1 == index) {
      return Column(
        children: [
          30.0.sizedBoxOnlyHeight,
          CenterDotText(),
          30.0.sizedBoxOnlyHeight,
        ],
      );
    }
    return Container();
  }

  Widget get mediaPostsList => RefreshIndicator(
        onRefresh: () => usersOtherSharesVm.getMediaPosts(),
        child: Observer(builder: (_) => mediaPostsListViewBuilder),
      );

  Widget get mediaPostsListViewBuilder => ListView.builder(
        key: PageStorageKey(usersOtherSharesVm.mediaPosts.first.postId),
        controller: usersOtherSharesVm.mediaPostsScrollController,
        physics: usersOtherSharesVm.mediaPostsScrollPhysics,
        itemCount: usersOtherSharesVm.mediaPosts.length,
        itemBuilder: (context, index) {
          Widget postWidget = buildMediaPostWidget(index);
          return buildMediaPost(
              index, postWidget, usersOtherSharesVm.mediaPosts);
        },
      );

  Widget buildMediaPostWidget(int index) => PostWidget(
        model: usersOtherSharesVm.mediaPosts[index],
        closeCardView: mainVm.isTypeFlatView,
      );

  Widget buildMediaPost(
      int index, Widget postWidget, List<PostModel> postList) {
    List<Widget> postItem = [];
    postItem.add(postWidget);
    postItem.add(pageBottomExtraWidget(index, postList));
    return Column(children: postItem);
  }

  Widget buildTab(String text) => Tab(
        child: Text(
          text,
          style: context.theme.textTheme.headline6?.copyWith(
            color: context.colorScheme.primary,
            fontSize: context.width / 22,
          ),
        ),
      );

  AppBar get _appBar => AppBar(
        elevation: 0,
        title: Text(
          profileVm.userModel!.displayName + '\'s Profile',
          style: context.theme.textTheme.headline6?.copyWith(
              color: context.colorScheme.primary, fontSize: context.width / 20),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () => context.pop,
        ),
        backgroundColor: Colors.white,
        bottom: PreferredSize(
          preferredSize: Size(context.width, kToolbarHeight),
          child: Column(
            children: [
              TabBar(
                indicatorSize: TabBarIndicatorSize.label,
                indicatorColor: context.colorScheme.primary,
                tabs: [buildTab('Likes'), buildTab('Media')],
              ),
              const Divider(height: 0),
            ],
          ),
        ),
        iconTheme: IconThemeData(color: context.theme.colorScheme.primary),
      );

  @override
  bool get wantKeepAlive => true;
}

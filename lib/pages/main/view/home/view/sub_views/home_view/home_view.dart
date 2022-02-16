import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../../../../../../app/constants/app_constants.dart';
import '../../../../../../../core/extensions/context_extensions.dart';
import '../../../../../../../core/extensions/double_extensions.dart';
import '../../../../../../../core/extensions/widget_extension.dart';
import '../../../../../../../core/widgets/center_dot_text.dart';
import '../../../../../../../core/widgets/small_circular_progress_indicator.dart';
import '../../../../../../../main.dart';
import '../../../../../model/post_model.dart';
import '../../../../sub_views/post_widget/post_widget/post_widget.dart';
import '../../../../sub_views/post_widget/post_widget/sub_widgets/profile_photo.dart';
import '../../../view_model/home_view_model.dart';
import 'sub_views/explore_more_widget.dart';
import 'sub_views/posts_not_found_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with AutomaticKeepAliveClientMixin {
  HomeViewModel viewModel = HomeViewModel();

  late Future<List<PostModel>> postsFuture;

  @override
  void initState() {
    viewModel.setContext(context);
    postsFuture = viewModel.getPosts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appBar,
      body: Column(
        children: [
          const Divider(height: 1, thickness: 1),
          Expanded(
            child: FutureBuilder<List<PostModel>>(
              future: postsFuture,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.isEmpty) {
                    return postsNotFoundWidget;
                  }
                  return _buildPostsList;
                }
                if (snapshot.hasError) {
                  return _errorLayout;
                }
                return const CircularProgressIndicator().center;
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget get postsNotFoundWidget => HomeViewPostsNotFoundView(
        homeViewModel: viewModel,
        onRefreshPressed: () async {
          await viewModel.getPosts();
          setState(() {});
        },
      );

  Widget get _errorLayout => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Somethings went wrong.\nPlease try again.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: context.theme.colorScheme.secondary,
                fontSize: context.height / 35,
              ),
            ),
            TextButton(
              onPressed: () => viewModel.getPosts(),
              child: Text(
                "Refresh",
                style: TextStyle(
                  fontSize: context.height / 45,
                ),
              ),
            )
          ],
        ),
      );

  Widget get morePostLoadingWidget => const Padding(
        padding: EdgeInsets.only(top: 5, bottom: 5),
        child: Center(
          child: SmallCircularProgressIndicator(),
        ),
      );

  Widget get _buildPostsList => Observer(
        builder: (_) => RefreshIndicator(
          strokeWidth: 2.5,
          onRefresh: () => viewModel.getPosts(),
          child: ListView.builder(
            controller: viewModel.scrollController,
            physics: viewModel.postsScrollable,
            itemCount: viewModel.posts.length,
            itemBuilder: (context, index) => _buildPostItem(index),
          ),
        ),
      );

  Widget _buildPostItem(int index) {
    List<Widget> postItem = [];
    postItem.add(Observer(
      builder: (_) => PostWidget(
        model: viewModel.posts[index],
        closeCardView: mainVm.isTypeFlatView,
        index: index,
        homeViewModel: viewModel,
      ),
    ));
    postItem.add(pageBottomExtraWidget(index));
    return Column(children: postItem);
  }

  Widget pageBottomExtraWidget(int index) {
    if (viewModel.posts.length - 1 == index) {
      if (viewModel.showExploreWidget) {
        return Column(
          children: [
            HomeViewExploreMoreWidget(),
            CenterDotText(),
            (context.height / 13).sizedBoxOnlyHeight,
          ],
        );
      }
    }
    return Container();
  }

  AppBar get _appBar => AppBar(
        elevation: 0,
        backgroundColor: AppColors.white,
        leading: _leading,
        centerTitle: true,
        title: Text(
          "Home",
          style: context.theme.textTheme.headline6?.copyWith(
            fontSize: context.width / 25,
            fontWeight: FontWeight.bold,
            color: context.theme.colorScheme.primary,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.now_widgets_outlined,
              color: context.theme.colorScheme.primary,
              size: context.width / 17,
            ),
            onPressed: () => mainVm.showPostViewTypeSelector(),
          ),
        ],
      );

  Widget get _leading => Container(
        margin: 7.0.edgeIntesetsAll,
        child: Observer(builder: (_) => PostProfilePhoto(
            imageUrl: (mainVm.currentUserModel)?.photoUrl,
            onClicked: (_) => context.openDrawer,
          )),
      );

  @override
  bool get wantKeepAlive => true;
}

import 'package:Carafe/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../app/constants/app_constants.dart';
import '../../../model/post_model.dart';
import '../../../../../app/widgets/post_widget/post_widget.dart';
import '../../../../../core/extensions/int_extensions.dart';
import '../view_model/home_view_model.dart';

class HomeView extends StatefulWidget {
  HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  HomeViewModel viewModel = HomeViewModel();

  late Future getPostsV;

  @override
  void initState() {
    getPostsV = getPosts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGroundGrey,
      body: FutureBuilder(
        future: getPostsV,
        builder: (context, snapshot) {
          if (snapshot.hasData) return _postBody;
          if (snapshot.hasError) return _errorLayout;
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

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
              onPressed: () => getPosts(),
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

  Widget get _postBody => Observer(
        builder: (context) => RefreshIndicator(
          strokeWidth: 2.5,
          onRefresh: () => getPosts(),
          child: NotificationListener<UserScrollNotification>(
            onNotification: (notification) =>
                viewModel.scrollDirectionController(notification),
            child: Column(
              children: [
                Flexible(
                  flex: 12,
                  child: _builder,
                ),
                viewModel.moreImageLoadingProgressState
                    ? morePostLoadingWidget
                    : Container(),
              ],
            ),
          ),
        ),
      );

  Widget get morePostLoadingWidget => const Padding(
        padding: EdgeInsets.only(top: 5, bottom: 5),
        child: Center(
          child: SizedBox(
            width: 15,
            height: 15,
            child: CircularProgressIndicator(strokeWidth: 2.5),
          ),
        ),
      );

  Widget get _builder => Observer(builder: (_) {
        return ListView.builder(
          controller: viewModel.scrollController,
          shrinkWrap: true,
          physics: viewModel.postsScrollable,
          itemCount: viewModel.posts.length,
          itemBuilder: (context, index) => _buildPostItem(index),
        );
      });

  Future<List<PostModel>> getPosts() async {
    viewModel.changeHomeBody(const Center(
      child: CircularProgressIndicator(),
    ));
    var posts = await viewModel.getPosts();
    viewModel.changeHomeBody(_postBody);
    return posts;
  }

  _buildPostItem(int index) {
    List<Widget> postItem = [];
    postItem.add(PostWidget(
      model: viewModel.posts[index],
      viewModel: viewModel,
    ));
    if (viewModel.posts.length - 1 == index) {
      postItem.add(15.sizedBoxOnlyHeight);
    }
    return Column(children: postItem);
  }
}

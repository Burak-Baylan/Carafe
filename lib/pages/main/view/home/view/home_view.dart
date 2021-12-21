import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../app/constants/app_constants.dart';
import '../../../../../core/extensions/context_extensions.dart';
import '../../../../../core/extensions/int_extensions.dart';
import '../../sub_views/post_widget/post_widget.dart';
import '../view_model/home_view_model.dart';

class HomeView extends StatefulWidget {
  HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  HomeViewModel viewModel = HomeViewModel();

  late Future postsFuture;

  @override
  void initState() {
    postsFuture = viewModel.getPosts(_postBody);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.backGroundGrey,
      child: FutureBuilder(
        future: postsFuture,
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
              onPressed: () => viewModel.getPosts(_postBody),
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
          onRefresh: () => viewModel.getPosts(_postBody),
          child: NotificationListener<UserScrollNotification>(
            onNotification: (notification) =>
                viewModel.scrollDirectionController(notification),
            child: Column(
              children: [
                Flexible(flex: 12, child: _buildPostsList),
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

  Widget get _buildPostsList => Observer(
        builder: (_) => ListView.builder(
          controller: viewModel.scrollController,
          shrinkWrap: true,
          physics: viewModel.postsScrollable,
          itemCount: viewModel.posts.length,
          itemBuilder: (context, index) => _buildPostItem(index),
        ),
      );

  _buildPostItem(int index) {
    List<Widget> postItem = [];
    postItem.add(PostWidget(
      model: viewModel.posts[index],
      homeViewModel: viewModel,
    ));
    if (viewModel.posts.length - 1 == index) {
      postItem.add(15.sizedBoxOnlyHeight);
    }
    return Column(children: postItem);
  }
}

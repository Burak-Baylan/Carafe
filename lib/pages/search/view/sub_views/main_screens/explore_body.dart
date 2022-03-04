import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../../../../app/constants/app_constants.dart';
import '../../../../../core/extensions/context_extensions.dart';
import '../../../../../core/extensions/double_extensions.dart';
import '../../../../../core/extensions/widget_extension.dart';
import '../../../../../core/widgets/center_dot_text.dart';
import '../../../../../core/widgets/small_circular_progress_indicator.dart';
import '../../../../../core/widgets/something_went_wrong_widget.dart';
import '../../../../../main.dart';
import '../../../../category/view/category_view.dart';
import '../../../../main/model/post_model.dart';
import '../../../../main/view/sub_views/post_widget/post_widget/post_widget.dart';
import '../../../view_model/explore_view_model/explore_view_model.dart';
import '../../../view_model/search_view_model.dart';

class SearchViewExploreBody extends StatefulWidget {
  SearchViewExploreBody({
    Key? key,
    required this.searchViewModel,
  }) : super(key: key);

  SearchViewModel searchViewModel;

  @override
  State<SearchViewExploreBody> createState() => _SearchViewExploreBodyState();
}

class _SearchViewExploreBodyState extends State<SearchViewExploreBody>
    with AutomaticKeepAliveClientMixin {
  late Future categoriesFuture;

  ExploreViewModel exploreVm = ExploreViewModel();

  String gamesText = PostContstants.GAMES;
  String softwareText = PostContstants.SOFTWARE;
  String advicesText = PostContstants.ADVICES;
  String enterpriseText = PostContstants.ENTERPRISE;
  String technologyText = PostContstants.TECHNOLOGY;

  @override
  void initState() {
    exploreVm.initializeValues();
    exploreVm.setContext(context);
    categoriesFuture = exploreVm.getAllPosts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: FutureBuilder(
        future: categoriesFuture,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const SomethingWentWrongWidget();
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return buildPostsViewSkeleton;
          }
          return const SmallCircularProgressIndicator().center;
        },
      ),
    );
  }

  Widget get buildPostsViewSkeleton => RefreshIndicator(
        strokeWidth: 2.5,
        onRefresh: () => exploreVm.getAllPosts(),
        child: buildScrollView,
      );

  Widget get buildScrollView => Observer(builder: (_) {
        return SingleChildScrollView(
          controller: mainVm.exploreViewPostsScrollController,
          physics: exploreVm.postsScrollable,
          child: buildCategoriesColumn,
        );
      });

  Widget get buildCategoriesColumn => Column(
        children: [
          categoryWidget(exploreVm.softwarePosts, softwareText),
          categoryWidget(exploreVm.technologyPosts, technologyText),
          categoryWidget(exploreVm.enterprisePosts, enterpriseText),
          categoryWidget(exploreVm.gamesPosts, gamesText),
          categoryWidget(exploreVm.advicesPosts, advicesText),
          25.0.sizedBoxOnlyHeight,
          CenterDotText().center,
          25.0.sizedBoxOnlyHeight
        ],
      );

  Widget categoryWidget(List<PostModel>? postList, String categoryName) {
    if (postList == null || postList.isEmpty) {
      return Container();
    }
    return Column(
      children: [
        buildTile(categoryName),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: postList.length,
          shrinkWrap: true,
          itemBuilder: (context, index) => buildPostWidget(postList[index]),
        ),
      ],
    );
  }

  Widget buildPostWidget(PostModel postModel) =>
      PostWidget(model: postModel, closeCardView: true);

  Widget buildTile(String categoryName) => _createTile(
        categoryName,
        () => mainVm.customNavigateToPage(
          page: CategoryView(categoryName: categoryName),
          animate: true,
        ),
      );

  Widget _createTile(String title, Function()? onTap) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Divider(height: 0, thickness: 1.5),
          ListTile(
            onTap: onTap,
            title: Text(
              title,
              style: context.theme.textTheme.headline6?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: context.width / 20,
                color: context.colorScheme.secondary,
              ),
            ),
            trailing: Icon(
              Icons.chevron_right_outlined,
              color: context.colorScheme.primary,
            ),
          ),
          const Divider(height: 0, thickness: 2),
        ],
      );

  @override
  bool get wantKeepAlive => true;
}

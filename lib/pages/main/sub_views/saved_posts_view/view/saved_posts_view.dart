import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../../../../core/extensions/context_extensions.dart';
import '../../../../../core/extensions/double_extensions.dart';
import '../../../../../core/extensions/widget_extension.dart';
import '../../../../../core/widgets/center_dot_text.dart';
import '../../../../../core/widgets/deleted_post_widget.dart';
import '../../../../../core/widgets/small_circular_progress_indicator.dart';
import '../../../../../core/widgets/something_went_wrong_widget.dart';
import '../../../../../core/widgets/there_is_nothing_here_widget.dart';
import '../../../../../main.dart';
import '../../../model/post_model.dart';
import '../../../view/sub_views/post_widget/post_widget/post_widget.dart';
import '../view_model/saved_posts_view_model.dart';

class SavedPostsView extends StatefulWidget {
  SavedPostsView({Key? key}) : super(key: key);

  @override
  State<SavedPostsView> createState() => _SavedPostsViewState();
}

class _SavedPostsViewState extends State<SavedPostsView> {
  late Future<List<PostModel>?> savedPostFuture;
  SavedPostsViewModel savedPostsVm = SavedPostsViewModel();

  @override
  void initState() {
    savedPostFuture = savedPostsVm.getSavedPosts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      backgroundColor: Colors.white,
      body: buildBody,
    );
  }

  Widget get buildBody => FutureBuilder<List<PostModel>?>(
        future: savedPostFuture,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const SomethingWentWrongWidget();
          }
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data == null || savedPostsVm.savedPosts.isEmpty) {
              return const ThereIsNothingHereWidget();
            } else {
              return savedPostsListView;
            }
          }
          return const SmallCircularProgressIndicator().center;
        },
      );

  Widget get savedPostsListView => Observer(
        builder: (_) => ListView.builder(
          itemCount: savedPostsVm.savedPosts.length,
          controller: savedPostsVm.scrollController,
          physics: savedPostsVm.postsScrollable,
          itemBuilder: (context, index) {
            var postModel = savedPostsVm.savedPosts[index];
            if (postModel.isPostDeleted!) {
              return DeletedPostWidget(postModel: postModel);
            }
            return buildPostWidget(index);
          },
        ),
      );

  Widget buildPostWidget(int index) {
    List<Widget> widgets = [];
    widgets.add(PostWidget(
      model: savedPostsVm.savedPosts[index],
      closeCardView: mainVm.isTypeFlatView,
    ));
    if (index == savedPostsVm.savedPosts.length - 1) {
      widgets.add(25.0.sizedBoxOnlyHeight);
      widgets.add(CenterDotText());
      widgets.add(25.0.sizedBoxOnlyHeight);
    }
    return Column(children: widgets);
  }

  AppBar get appBar => AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () => context.pop,
        ),
        title: Text(
          'Saved Posts',
          style: TextStyle(
            fontSize: context.width / 20,
            color: context.theme.colorScheme.primary,
          ),
        ),
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: Size(context.width, 1),
          child: const Divider(height: 0),
        ),
        iconTheme: IconThemeData(color: context.theme.colorScheme.primary),
      );
}

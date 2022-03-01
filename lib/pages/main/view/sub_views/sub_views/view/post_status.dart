import 'package:flutter/material.dart';
import '../../../../../../core/extensions/context_extensions.dart';
import '../../../../../../core/extensions/double_extensions.dart';
import '../../../../../../core/extensions/int_extensions.dart';
import '../../../../../../core/widgets/border_container.dart';
import '../../../../../../core/widgets/small_circular_progress_indicator.dart';
import '../../../../model/post_model.dart';
import '../../post_widget/post_widget/view_model/post_view_model.dart';
import '../view_model/post_status_view_model.dart';
import 'sub_views/post_status_post_widget_layout/post_status_view_like_and_comment_status_widget.dart';
import 'sub_views/post_status_post_widget_layout/post_status_view_post_widget.dart';
import 'sub_views/status_informations_layout/post_status_informations_layout.dart';

class PostStatusView extends StatefulWidget {
  PostStatusView({
    Key? key,
    required this.postModel,
    required this.postViewModel,
  }) : super(key: key);

  PostModel postModel;
  PostViewModel postViewModel;

  @override
  State<PostStatusView> createState() => _PostStatusViewState();
}

class _PostStatusViewState extends State<PostStatusView> {
  PostStatusViewModel postStatusViewModel = PostStatusViewModel();

  @override
  void initState() {
    postStatusViewModel.setViewModel(widget.postViewModel);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appBar(),
      body: FutureBuilder(
        future: postStatusViewModel.getInformations(widget.postModel.authorId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return body;
          }
          return const Center(child: SmallCircularProgressIndicator());
        },
      ),
    );
  }

  Widget get body {
    return SingleChildScrollView(
      child: Container(
        margin: 15.0.edgeIntesetsAll,
        child: Column(
          children: [
            postViewWidget,
            25.sizedBoxOnlyHeight,
            PostStatusInformationsLayout(
              postStatusInformationsModel:
                  postStatusViewModel.postStatusInformationsModel,
            ),
          ],
        ),
      ),
    );
  }

  Widget get postViewWidget => BorderContainer.all(
        color: Colors.transparent,
        radius: 15,
        decoration: BoxDecoration(
          border: Border.all(width: .5, color: Colors.grey.shade500),
          borderRadius: 15.radiusAll,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            PostStatausViewPostWidget(
              postModel: postStatusViewModel.postModel,
              userModel: postStatusViewModel.userModel,
            ),
            Divider(height: 0, color: Colors.grey.shade500, thickness: .5),
            PostStatusViewLikeAndCommentStatusWidget(
              postModel: postStatusViewModel.postModel,
            )
          ],
        ),
      );

  AppBar _appBar() => AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () => context.pop,
        ),
        elevation: 0,
        title: Text(
          "Post Status",
          style: TextStyle(
            fontSize: context.width / 20,
            color: context.theme.colorScheme.primary,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size(context.width, 1),
          child: const Divider(height: 0),
        ),
        iconTheme: IconThemeData(color: context.theme.colorScheme.primary),
      );
}

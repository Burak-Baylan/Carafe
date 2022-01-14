import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../../core/extensions/context_extensions.dart';
import '../../../../../../core/extensions/double_extensions.dart';
import '../../../../../../core/extensions/int_extensions.dart';
import '../../../../../../core/extensions/widget_extension.dart';
import '../../../../../../core/widgets/center_dot_text.dart';
import '../../../../model/post_model.dart';
import '../../../home/view_model/home_view_model.dart';
import '../post_widget/post_widget.dart';
import '../post_widget/sub_widgets/name_and_menu/name_and_menu.dart';
import '../post_widget/sub_widgets/post_image_widget/post_images.dart';
import '../post_widget/sub_widgets/post_top_information.dart';
import '../post_widget/sub_widgets/profile_photo.dart';
import '../post_widget/view_model/post_view_model.dart';
import 'sub_widgets/full_screen_post_bottom_layout/full_screen_post_bottom_layout.dart';
import 'sub_widgets/more_comments_loading_widget.dart';

class FullScreenPostView extends StatefulWidget {
  FullScreenPostView({
    Key? key,
    required this.postViewModel,
    required this.postModel,
    required this.homeViewModel,
    this.postRef,
  }) : super(key: key);

  PostViewModel postViewModel;
  HomeViewModel homeViewModel;
  PostModel postModel;
  DocumentReference? postRef;

  @override
  State<FullScreenPostView> createState() => _FullScreenPostViewState();
}

class _FullScreenPostViewState extends State<FullScreenPostView> {
  late BuildContext context;
  late PostViewModel postViewModel;
  late Future<List<PostModel>> commentsFuture;

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => postViewModel.navigateToReplyScreen(),
        child: const Icon(Icons.reply_rounded),
      ),
      appBar: _appBar,
      body: _body,
    );
  }

  @override
  void initState() {
    super.initState();
    postViewModel = widget.postViewModel;
    postViewModel.findCommentsPath(widget.postRef);
    commentsFuture = postViewModel.getComments();
  }

  Widget get _body => FutureBuilder<List<PostModel>>(
        future: commentsFuture,
        builder: (context, snapshot) => snapshot.hasData
            ? _postsListsBuilderSkeleton
            : const Center(child: CircularProgressIndicator()),
      );

  Widget get _postsListsBuilderSkeleton => Observer(
        builder: (_) => Column(
          children: [
            Flexible(flex: 12, child: _postsListBuilder),
            postViewModel.moreCommentsLoadingProgressState
                ? const MoreCommentsLoadingWidget()
                : Container(),
          ],
        ),
      );

  Widget get _postsListBuilder => ListView.builder(
        shrinkWrap: true,
        controller: widget.postViewModel.scrollController,
        physics: widget.postViewModel.commentsScrollable,
        itemCount: postViewModel.commentsLength + 1,
        itemBuilder: (context, index) =>
            index == 0 ? postBodySkeleton : _buildCommentItem(index - 1),
      );

  Widget _buildCommentItem(int index) {
    List<Widget> postItem = [];
    postItem.add(PostWidget(
      model: postViewModel.comments[index],
      homeViewModel: widget.homeViewModel,
      showReply: true,
      postRef: postViewModel.findACommentPathFromComments(index),
    ));
    if (postViewModel.commentsLength - 1 == index) {
      postItem.add(10.0.sizedBoxOnlyHeight);
      postItem.add(CenterDotText(textColor: Colors.grey.shade500).center);
      postItem.add((context.height / 10).sizedBoxOnlyHeight);
    }
    return Column(children: postItem);
  }

  Widget get postBodySkeleton => Column(
        children: [
          Container(margin: 10.0.edgeIntesetsRightLeftTop, child: postBody),
          const Divider(thickness: 0.5, height: 0),
          postViewModel.commentsLength == 0
              ? CenterDotText(textColor: Colors.grey.shade500)
              : Container(),
          postViewModel.commentsLength == 0
              ? (context.height / 10).sizedBoxOnlyHeight
              : Container(),
        ],
      );

  Widget get postBody => IntrinsicHeight(
        child: Column(
          children: [
            5.sizedBoxOnlyHeight,
            _topInformation,
            5.sizedBoxOnlyHeight,
            _postUserInformation,
            10.sizedBoxOnlyHeight,
            Expanded(child: _postInfromationLayout),
          ],
        ),
      );

  Widget get _postUserInformation => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPp,
          5.sizedBoxOnlyWidth,
          Expanded(
            child: SizedBox(
              height: context.height * 0.075,
              child: _nameAndMoreMenu,
            ),
          ),
          5.sizedBoxOnlyWidth,
        ],
      );

  Widget get _postInfromationLayout => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          _buildPostText,
          _image,
          5.sizedBoxOnlyHeight,
          _buildPostBottomLayout,
        ],
      );

  Widget get _buildPostText => widget.postModel.text != null
      ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            1.sizedBoxOnlyHeight,
            Text(
              "${widget.postModel.text}",
              style: context.theme.textTheme.headline6?.copyWith(
                fontSize: context.height / 35,
              ),
            ),
          ],
        )
      : Container();

  Widget get _image => Column(
        children: [
          5.sizedBoxOnlyHeight,
          ImageWidgets(
            images: widget.postModel.imageLinks,
            fullSizeHeight: context.height / 2.8,
            halfSizeHeight: context.height / 2.8,
            onPressedImage: (imageProviders, imageUrls, imageIndex) => widget
                .postViewModel
                .onPressedImage(imageProviders, imageUrls, imageIndex),
          ),
        ],
      );

  Widget get _nameAndMoreMenu => PostNameAndMenu(
        postViewModel: postViewModel,
        postModel: widget.postModel,
        homeViewModel: widget.homeViewModel,
        closeCenterDot: true,
        buildWithColumn: true,
      );

  get _buildPp => PostProfilePhoto(postModel: widget.postModel);

  Widget get _topInformation => PostTopInformation(model: widget.postModel);

  Widget get _buildPostBottomLayout => FullScreenPostBottomLayout(
        postModel: widget.postModel,
        postViewModel: widget.postViewModel,
        homeViewModel: widget.homeViewModel,
      );

  AppBar get _appBar => AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Post",
          style: TextStyle(
            fontSize: context.width / 20,
            color: context.theme.colorScheme.primary,
          ),
        ),
        iconTheme: IconThemeData(color: context.theme.colorScheme.primary),
      );
}

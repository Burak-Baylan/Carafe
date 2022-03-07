import 'package:Carafe/core/extensions/widget_extension.dart';
import 'package:Carafe/core/widgets/small_circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../../../../../core/extensions/context_extensions.dart';
import '../../../../../../core/extensions/double_extensions.dart';
import '../../../../../../core/extensions/int_extensions.dart';
import '../../../../../../core/widgets/center_dot_text.dart';
import '../../../../model/post_model.dart';
import '../post_widget/post_widget.dart';
import '../post_widget/sub_widgets/name_and_menu/name_and_menu.dart';
import '../post_widget/sub_widgets/post_image_widget/post_images.dart';
import '../post_widget/sub_widgets/post_top_information.dart';
import '../post_widget/sub_widgets/profile_photo.dart';
import '../post_widget/view_model/post_view_model.dart';
import 'sub_widgets/full_screen_post_bottom_layout/full_screen_post_bottom_layout.dart';

class FullScreenPostView extends StatefulWidget {
  FullScreenPostView(
      {Key? key, required this.postViewModel, required this.postModel})
      : super(key: key);

  PostViewModel postViewModel;
  PostModel postModel;

  @override
  State<FullScreenPostView> createState() => _FullScreenPostViewState();
}

class _FullScreenPostViewState extends State<FullScreenPostView> {
  late PostViewModel postViewModel;
  late Future<List<PostModel>> commentsFuture;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
    postViewModel.findCommentsPath(widget.postModel.postPath);
    commentsFuture = postViewModel.getComments();
    _initValues();
  }

  _initValues() async {
    await postViewModel.addToPostClicked();
  }

  Widget get _body => FutureBuilder<List<PostModel>>(
        future: commentsFuture,
        builder: (context, snapshot) => snapshot.hasData
            ? _postsListBuilder
            : const SmallCircularProgressIndicator().center,
      );

  Widget get _postsListBuilder => Observer(
        builder: (context) => ListView.builder(
          shrinkWrap: true,
          controller: postViewModel.scrollController,
          physics: postViewModel.commentsScrollable,
          itemCount: postViewModel.comments.length + 1,
          itemBuilder: (context, index) =>
              index == 0 ? postBodySkeleton : _buildCommentItem(index - 1),
        ),
      );

  Widget _buildCommentItem(int index) {
    List<Widget> postItem = [];
    postItem.add(PostWidget(
      model: postViewModel.comments[index],
      closeCardView: true,
      postRef: postViewModel.findACommentPathFromComments(index),
      index: index,
    ));
    if (postViewModel.comments.length - 1 == index) {
      postItem.add(centerDotText);
    }
    return Column(children: postItem);
  }

  Widget get centerDotText => Column(
        children: [
          15.0.sizedBoxOnlyHeight,
          CenterDotText(textColor: Colors.grey.shade500),
          (context.height / 10).sizedBoxOnlyHeight,
        ],
      );

  Widget get postBodySkeleton => Column(
        children: [
          Container(margin: 10.0.edgeIntesetsRightLeftTop, child: postBody),
          const Divider(thickness: 0.5, height: 0),
          postViewModel.comments.isEmpty ? centerDotText : Container(),
          postViewModel.comments.isEmpty
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
          10.sizedBoxOnlyWidth,
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
            onPressedImage:
                (imageProviders, imageUrls, imageIndex, tagForImage) =>
                    widget.postViewModel.onPressedImage(
                        imageProviders, imageUrls, imageIndex, tagForImage),
          ),
        ],
      );

  Widget get _nameAndMoreMenu => PostNameAndMenu(
        postViewModel: postViewModel,
        postModel: widget.postModel,
        closeCenterDot: true,
        buildWithColumn: true,
      );

  dynamic get _buildPp => PostProfilePhoto(
        height: context.width / 7.5,
        width: context.width / 7.5,
        postModel: widget.postModel,
        postViewModel: postViewModel,
        imageUrl: postViewModel.userModel!.photoUrl,
      );

  Widget get _topInformation => PostTopInformation(model: widget.postModel);

  Widget get _buildPostBottomLayout => FullScreenPostBottomLayout(
        postModel: widget.postModel,
        postViewModel: widget.postViewModel,
      );

  AppBar get _appBar => AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () => context.pop,
        ),
        title: Text(
          "Post",
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

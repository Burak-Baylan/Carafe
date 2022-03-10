import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../../../../../../core/extensions/context_extensions.dart';
import '../../../../../../../core/extensions/double_extensions.dart';
import '../../../../../../../core/extensions/int_extensions.dart';
import '../../../../../model/post_model.dart';
import '../view_model/post_view_model.dart';

class PostBottomLayout extends StatelessWidget {
  PostBottomLayout({
    Key? key,
    required this.postModel,
    required this.postViewModel,
  }) : super(key: key);

  PostModel postModel;
  PostViewModel postViewModel;

  late BuildContext context;

  _initState(BuildContext context) {
    this.context = context;
    postViewModel.findLikeIcon();
    postViewModel.findPostSaveIcon();
  }

  @override
  Widget build(BuildContext context) {
    _initState(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [_likeLayout, _commentLayout],
        ),
        _buildSaveButton,
      ],
    );
  }

  Widget get _likeLayout => InkWell(
        borderRadius: 5.radiusAll,
        onTap: () => postModel.isPostDeleted! ? {} : postViewModel.like(),
        child: Padding(
          padding: 4.0.edgeIntesetsTopBottom,
          child: Row(
            children: [
              _buildLikeButton,
              3.sizedBoxOnlyWidth,
              _buildLikeText,
              10.sizedBoxOnlyWidth,
            ],
          ),
        ),
      );

  Widget get _commentLayout => InkWell(
        borderRadius: 5.radiusAll,
        onTap: () => postModel.isPostDeleted! ? {} : sendToReplyScreen(),
        child: Padding(
          padding: 4.0.edgeIntesetsTopBottom,
          child: Row(
            children: [
              _buildCommentButton,
              3.sizedBoxOnlyWidth,
              _buildCommentText,
              10.sizedBoxOnlyWidth,
            ],
          ),
        ),
      );

  Widget _buildMyText(String text, {bool animate = false}) => AnimatedSwitcher(
        transitionBuilder: (child, animation) => animate
            ? postViewModel.bottomToTopAnimation(child, animation)
            : _buildText(text),
        duration: 200.durationMilliseconds,
        child: _buildText(text),
      );

  Widget _buildText(String text) => Text(
        text,
        key: ValueKey(postViewModel.randomId),
        style: TextStyle(color: Colors.grey[700], fontSize: context.width / 27),
      );

  Widget _buildSmallButtons(
    IconData icon, {
    Color? iconColor,
  }) =>
      Padding(
        padding: .0.edgeIntesetsAll,
        child: Icon(
          icon,
          size: context.width / 19,
          color: iconColor ?? context.theme.colorScheme.secondary,
        ),
      );

  Widget get _buildLikeText => postModel.isPostDeleted!
      ? Container()
      : StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: postViewModel.firebaseConstants
              .likeCountStremRef(postViewModel.currentPostRef),
          builder: (context, snapshot) => _findLikeText(snapshot),
        );

  Widget get _buildCommentText => postModel.isPostDeleted!
      ? Container()
      : StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: postViewModel.firebaseConstants
              .commentsStremRef(postViewModel.currentPostRef),
          builder: (context, snapshot) => _findCommentText(snapshot),
        );

  Widget _findLikeText(
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) =>
      _findText(snapshot, postModel.likeCount);

  Widget _findCommentText(
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) =>
      _findText(snapshot, postModel.commentCount);

  Widget _findText(
    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot,
    int countFromModel,
  ) {
    if (snapshot.hasData) {
      int count = snapshot.data!.docs.length;
      return _buildMyText(count.toString(), animate: false);
    }
    return _buildMyText(countFromModel.toString(), animate: false);
  }

  Widget get _buildLikeButton => Observer(
      builder: (context) => _buildSmallButtons(postViewModel.likeIcon));

  Widget get _buildCommentButton =>
      _buildSmallButtons(Icons.mode_comment_outlined);

  Widget get _buildSaveButton {
    if (postModel.authorId == postViewModel.authService.userId) {
      return InkWell(
        borderRadius: 10.radiusAll,
        child: Padding(
          padding: 5.0.edgeIntesetsAll,
          child: _buildSmallButtons(Icons.bar_chart_rounded),
        ),
        onTap: () => postViewModel.navigateToPostStatus(postViewModel),
      );
    } else {
      return Observer(
        builder: (context) => InkWell(
          borderRadius: 10.radiusAll,
          onTap: () => postViewModel.save(),
          child: Padding(
            padding: 5.0.edgeIntesetsAll,
            child: _buildSmallButtons(postViewModel.postSaveIcon),
          ),
        ),
      );
    }
  }

  void sendToReplyScreen() => postViewModel.navigateToReplyScreen(
        postModel: postModel,
        postAddingRef: postViewModel.currentPostRef,
      );
}

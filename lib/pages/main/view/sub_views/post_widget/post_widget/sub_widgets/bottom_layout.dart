import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../../../../../../core/extensions/context_extensions.dart';
import '../../../../../../../core/extensions/double_extensions.dart';
import '../../../../../../../core/extensions/int_extensions.dart';
import '../../../../../model/post_model.dart';
import '../../../../home/view_model/home_view_model.dart';
import '../view_model/post_view_model.dart';

class PostBottomLayout extends StatelessWidget {
  PostBottomLayout({
    Key? key,
    required this.postModel,
    required this.postViewModel,
    required this.homeViewModel,
  }) : super(key: key);

  PostModel postModel;
  PostViewModel postViewModel;
  HomeViewModel homeViewModel;

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
          children: [
            _buildLikeButton,
            3.sizedBoxOnlyWidth,
            _buildLikeText,
            10.sizedBoxOnlyWidth,
            _buildCommentButton,
            3.sizedBoxOnlyWidth,
            _buildCommentText,
          ],
        ),
        _buildSaveButton,
      ],
    );
  }

  Widget _buildMyText(String text, {bool animate = false}) => AnimatedSwitcher(
        transitionBuilder: (child, animation) => animate
            ? postViewModel.bottomToTopAnimation(child, animation)
            : _buildText(text),
        duration: 200.durationMilliseconds,
        child: _buildText(text),
      );

  Widget _buildText(String text) => Text(
        text,
        key: ValueKey(postViewModel.getRandomId),
        style: TextStyle(color: Colors.grey[700], fontSize: 12),
      );

  Widget _buildSmallButtons(
    Function onTab,
    IconData icon, {
    Color? iconColor,
  }) =>
      InkWell(
        customBorder: const CircleBorder(),
        onTap: () => onTab(),
        child: Padding(
          padding: 3.0.edgeIntesetsAll,
          child: Icon(
            icon,
            size: context.height / 34,
            color: iconColor ?? context.theme.colorScheme.secondary,
          ),
        ),
      );

  Widget get _buildLikeText =>
      StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: postViewModel.firebaseConstants
            .likeCountStremRef(postViewModel.sharedPostRef),
        builder: (context, snapshot) => _findLikeText(snapshot),
      );

  Widget get _buildCommentText =>
      StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: postViewModel.firebaseConstants
            .commentCountStremRef(postViewModel.sharedPostRef),
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
        builder: (context) => _buildSmallButtons(
          () => postViewModel.like(),
          postViewModel.likeIcon,
        ),
      );

  Widget get _buildCommentButton => _buildSmallButtons(
        () => postViewModel.navigateToReplyScreen(
          postModel: postModel,
          postAddingRef: postViewModel.sharedPostRef,
        ),
        Icons.mode_comment_outlined,
      );

  Widget get _buildSaveButton =>
      postModel.authorId == postViewModel.authService.userId
          ? Container()
          : Observer(
              builder: (context) => _buildSmallButtons(
                () => postViewModel.save(),
                postViewModel.postSaveIcon,
              ),
            );
}

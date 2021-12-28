import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../../../../../core/extensions/context_extensions.dart';
import '../../../../../../core/extensions/double_extensions.dart';
import '../../../../../../core/extensions/int_extensions.dart';
import '../../../../../../core/extensions/timestamp_extensions.dart';
import '../../../../model/post_model.dart';
import '../../../home/view_model/home_view_model.dart';
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

  late Stream<QuerySnapshot<Map<String, dynamic>>> postLikeCountStream;

  _initState(BuildContext context) {
    this.context = context;
    postViewModel.findLikeIcon();
    postViewModel.findPostSaveIcon();
    postLikeCountStream = postViewModel.firebaseConstants.allPostsCollectionRef
        .doc(postModel.postId)
        .collection(homeViewModel.firebaseConstants.postLikersText)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    _initState(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _buildMyText(postModel.createdAt!.getTimeAgo),
        Row(
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
                _buildMyText(postModel.commentCount.toString()),
              ],
            ),
            _buildSaveButton,
          ],
        ),
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
        key: ValueKey<String>(postViewModel.getRandomId),
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
            size: 21,
            color: iconColor ?? context.theme.colorScheme.secondary,
          ),
        ),
      );

  Widget get _buildLikeText =>
      StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: postLikeCountStream,
        builder: (context, snapshot) => _findLikeText(snapshot),
      );

  Widget _findLikeText(
      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
    if (snapshot.hasData) {
      int likeCount = snapshot.data!.docs.length;
      return _buildMyText(likeCount.toString(), animate: true);
    }
    return _buildMyText(postModel.likeCount.toString(), animate: true);
  }

  Widget get _buildLikeButton => Observer(
        builder: (context) => _buildSmallButtons(
          () => postViewModel.like(),
          postViewModel.likeIcon,
        ),
      );

  Widget get _buildCommentButton => _buildSmallButtons(
        () {},
        Icons.mode_comment_outlined,
      );

  Widget get _buildSaveButton => Observer(
        builder: (context) => _buildSmallButtons(
          () => postViewModel.save(),
          postViewModel.postSaveIcon,
        ),
      );
}

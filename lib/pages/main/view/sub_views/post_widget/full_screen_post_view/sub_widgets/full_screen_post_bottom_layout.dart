import 'package:Carafe/app/constants/app_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../../../../../../core/extensions/context_extensions.dart';
import '../../../../../../../core/extensions/double_extensions.dart';
import '../../../../../../../core/extensions/int_extensions.dart';
import '../../../../../../../core/extensions/timestamp_extensions.dart';
import '../../../../../model/post_model.dart';
import '../../../../home/view_model/home_view_model.dart';
import '../../post_widget/view_model/post_view_model.dart';

class FullScreenPostBottomLayout extends StatelessWidget {
  FullScreenPostBottomLayout({
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        10.sizedBoxOnlyHeight,
        _buildMyText(postModel.createdAt!.date, fontSize: context.width / 23),
        10.sizedBoxOnlyHeight,
        const Divider(thickness: 0.5, height: 0),
        _buildLikeAndCommentCountText,
        const Divider(thickness: 0.5, height: 0),
        10.sizedBoxOnlyHeight,
        _buildButtons,
        10.sizedBoxOnlyHeight,
        const Divider(thickness: 0.5, height: 0),
      ],
    );
  }

  Widget get _buildLikeAndCommentCountText => Row(
        children: [
          likeCountLayout,
          10.sizedBoxOnlyWidth,
          commentCountLayout,
        ],
      );

  Widget get _buildButtons => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildLikeButton,
              10.sizedBoxOnlyWidth,
              _buildCommentButton,
            ],
          ),
          _buildSaveButton,
        ],
      );

  Widget _buildMyText(String text,
          {bool animate = false, double fontSize = 12, Color? color}) =>
      AnimatedSwitcher(
        transitionBuilder: (child, animation) => animate
            ? postViewModel.bottomToTopAnimation(child, animation)
            : _buildText(text, fontSize: fontSize, color: color),
        duration: 200.durationMilliseconds,
        child: _buildText(text, fontSize: fontSize, color: color),
      );

  Widget _buildText(String text, {double fontSize = 12, Color? color}) => Text(
        text,
        key: ValueKey<String>(postViewModel.getRandomId),
        style: TextStyle(color: color ?? Colors.grey[700], fontSize: fontSize),
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
            size: context.width / 15,
            color: iconColor ?? context.theme.colorScheme.secondary,
          ),
        ),
      );

  Widget _buildLikeText(double fontSize) =>
      StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream:
            postViewModel.firebaseConstants.likeTextStremRef(postModel.postId),
        builder: (context, snapshot) => _findLikeText(snapshot, fontSize),
      );

  Widget _findLikeText(
      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot,
      double fontSize) {
    if (snapshot.hasData) {
      int likeCount = snapshot.data!.docs.length;
      return _buildMyText(likeCount.shorten,
          animate: true, fontSize: fontSize, color: AppColors.black);
    }
    return _buildMyText(postModel.likeCount.shorten,
        animate: true, fontSize: fontSize, color: AppColors.black);
  }

  Widget get likeCountLayout => InkWell(
        onTap: () {},
        child: Column(
          children: [
            10.sizedBoxOnlyHeight,
            Row(
              children: [
                _buildLikeText(context.width / 23),
                3.sizedBoxOnlyWidth,
                _buildMyText("Likes", fontSize: context.width / 23),
              ],
            ),
            10.sizedBoxOnlyHeight,
          ],
        ),
      );

  Widget get commentCountLayout => InkWell(
        onTap: () {},
        child: Column(
          children: [
            10.sizedBoxOnlyHeight,
            Row(
              children: [
                _buildMyText(postModel.commentCount.toString(),
                    fontSize: context.width / 23, color: AppColors.black),
                3.sizedBoxOnlyWidth,
                _buildMyText("Comments", fontSize: context.width / 23),
              ],
            ),
            10.sizedBoxOnlyHeight,
          ],
        ),
      );

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
            () => postViewModel.save(), postViewModel.postSaveIcon),
      );
}

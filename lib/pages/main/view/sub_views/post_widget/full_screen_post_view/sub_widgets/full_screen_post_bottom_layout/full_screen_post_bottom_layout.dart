import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../../../../../../../app/constants/app_constants.dart';
import '../../../../../../../../core/extensions/context_extensions.dart';
import '../../../../../../../../core/extensions/int_extensions.dart';
import '../../../../../../../../core/extensions/timestamp_extensions.dart';
import '../../../../../../../../core/widgets/bottom_to_top_animated_text.dart';
import '../../../../../../../../core/widgets/place_holder_with_border.dart';
import '../../../../../../model/post_model.dart';
import '../../../../../home/view_model/home_view_model.dart';
import '../../../post_widget/view_model/post_view_model.dart';
import 'sub_widgets/full_screen_post_bottom_layout_count_and_text_widget.dart';
import 'sub_widgets/full_screen_post_bottom_layout_small_button.dart';

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

  double get fontSize => context.width / 23;

  @override
  Widget build(BuildContext context) {
    _initState(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        10.sizedBoxOnlyHeight,
        _createdAtText,
        10.sizedBoxOnlyHeight,
        _divider,
        _buildLikeAndCommentCountText,
        _divider,
        10.sizedBoxOnlyHeight,
        _buildButtons,
        10.sizedBoxOnlyHeight,
      ],
    );
  }

  Widget get _divider => const Divider(thickness: 0.5, height: 0);

  Widget get _createdAtText => BottomToTopAnimatedText(
        text: postModel.createdAt!.date,
        fontSize: fontSize,
        animate: false,
      );

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

  Widget _buildLikeText(double fontSize) =>
      StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: postViewModel.firebaseConstants
            .likeCountStremRef(postViewModel.sharedPostRef),
        builder: (context, snapshot) => _find(snapshot, fontSize),
      );

  Widget _buildCommentText(double fontSize) =>
      StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: postViewModel.firebaseConstants
            .commentCountStremRef(postViewModel.sharedPostRef),
        builder: (context, snapshot) => _find(snapshot, fontSize),
      );

  Widget _find(AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot,
      double fontSize) {
    if (snapshot.hasData) {
      int count = snapshot.data!.docs.length;
      return BottomToTopAnimatedText(
        text: count.shorten,
        fontSize: fontSize,
        color: AppColors.black,
        animate: false,
      );
    }
    return PlaceHolderWithBorder(
        width: context.height / 100, height: context.height / 100);
  }

  Widget get likeCountLayout => FullScreenPostBottomLayoutCountAndTextWidget(
        onTap: () {},
        children: [
          _buildLikeText(fontSize),
          3.sizedBoxOnlyWidth,
          BottomToTopAnimatedText(
              text: "Likes", fontSize: fontSize, animate: false),
        ],
      );

  Widget get commentCountLayout => FullScreenPostBottomLayoutCountAndTextWidget(
        onTap: () {},
        children: [
          _buildCommentText(fontSize),
          3.sizedBoxOnlyWidth,
          BottomToTopAnimatedText(
              text: "Comments", fontSize: fontSize, animate: false),
        ],
      );

  Widget get _buildLikeButton => Observer(
      builder: (context) => FullScreenPostBottomLayoutSmallButton(
          onTab: () => postViewModel.like(), icon: postViewModel.likeIcon));

  Widget get _buildCommentButton => FullScreenPostBottomLayoutSmallButton(
      onTab: () => postViewModel.navigateToReplyScreen(),
      icon: Icons.mode_comment_outlined);

  Widget get _buildSaveButton =>
      postModel.authorId == postViewModel.authService.userId
          ? Container()
          : Observer(
              builder: (context) => FullScreenPostBottomLayoutSmallButton(
                  onTab: () => postViewModel.save(),
                  icon: postViewModel.postSaveIcon));
}

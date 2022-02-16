import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../../../../../core/extensions/context_extensions.dart';
import '../../../../../../core/extensions/double_extensions.dart';
import '../../../../../../core/extensions/int_extensions.dart';
import '../../../../model/post_model.dart';
import '../../../home/view_model/home_view_model.dart';
import 'sub_widgets/bottom_layout.dart';
import 'sub_widgets/name_and_menu/name_and_menu.dart';
import 'sub_widgets/post_image_widget/post_images.dart';
import 'sub_widgets/post_skeleton.dart';
import 'sub_widgets/post_top_information.dart';
import 'sub_widgets/profile_photo.dart';
import 'view_model/post_view_model.dart';

class PostWidget extends StatefulWidget {
  PostWidget({
    Key? key,
    required this.model,
    this.ppWidget,
    this.topInformation,
    this.topUserInformation,
    this.postText,
    this.image,
    this.bottomLayout,
    this.closeCardView = false,
    this.postRef,
    this.index,
    this.homeViewModel,
    this.isPostPinned,
    this.onPostPinnedOrUnpinned,
  }) : super(key: key);

  PostModel model;
  Widget? topInformation;
  Widget? ppWidget;
  Widget? topUserInformation;
  Widget? postText;
  Widget? image;
  Widget? bottomLayout;
  bool? isPostPinned;
  bool closeCardView;
  DocumentReference? postRef;
  int? index;
  HomeViewModel? homeViewModel;
  Function? onPostPinnedOrUnpinned;

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  PostViewModel postViewModel = PostViewModel();
  late PostModel model;

  @override
  Widget build(BuildContext context) {
    _initializeValues();
    return Observer(
      builder: (_) => (!postViewModel.isPostDeleted ||
              (model.isPostDeleted != null && !(model.isPostDeleted!)))
          ? Column(
              children: [
                widget.closeCardView
                    ? 0.sizedBoxOnlyHeight
                    : 15.sizedBoxOnlyHeight,
                PostSkeleton(
                    closeCardView: widget.closeCardView, child: _postContainer)
              ],
            )
          : postIsDeletedWidget,
    );
  }

  Widget get _postContainer => InkWell(
        splashColor: Colors.grey.shade100.withOpacity(.0),
        borderRadius: widget.closeCardView ? 0.radiusAll : 10.radiusAll,
        onTap: () => postViewModel.navigateToFullScreenPostView(postViewModel),
        child: _postLayout,
      );

  Widget get _postLayout => Column(
        children: [
          widget.closeCardView ? 10.sizedBoxOnlyHeight : 0.sizedBoxOnlyHeight,
          _postBody,
          widget.closeCardView ? 10.sizedBoxOnlyHeight : 0.sizedBoxOnlyHeight,
          widget.closeCardView
              ? const Divider(thickness: .5, height: 0)
              : Container(),
        ],
      );

  Widget get _postBody => Container(
        margin: widget.closeCardView
            ? const EdgeInsets.symmetric(horizontal: 10)
            : 10.0.edgeIntesetsAll,
        child: Column(
          children: [
            widget.topInformation ?? _topInformation,
            5.sizedBoxOnlyHeight,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                widget.ppWidget ?? _buildPp,
                5.sizedBoxOnlyWidth,
                Expanded(child: _postComponents),
              ],
            ),
          ],
        ),
      );

  Widget get _postComponents => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          widget.topUserInformation ?? _nameAndMoreMenu,
          widget.postText ?? _buildPostText,
          widget.image ?? _image,
          5.sizedBoxOnlyHeight,
          widget.bottomLayout ?? _buildPostBottomLayout
        ],
      );

  Widget get _topInformation => Align(
        alignment: Alignment.centerLeft,
        child: PostTopInformation(
          model: model,
          isPostPinned: widget.isPostPinned ?? false,
        ),
      );

  Widget get _image => Column(
        children: [
          5.sizedBoxOnlyHeight,
          ImageWidgets(
            images: model.imageLinks,
            onPressedImage: (iProvider, iUrl, iIndex, tag) =>
                postViewModel.onPressedImage(iProvider, iUrl, iIndex, tag),
          ),
        ],
      );

  Widget get _buildPp => Observer(builder: (_) {
        return PostProfilePhoto(
          postModel: model,
          postViewModel: postViewModel,
          imageUrl: postViewModel.userModel != null
              ? postViewModel.userModel!.photoUrl
              : null,
        );
      });

  Widget get _nameAndMoreMenu => PostNameAndMenu(
        postModel: model,
        postViewModel: postViewModel,
        onPostPinnedOrUnpinned: widget.onPostPinnedOrUnpinned,
      );

  Widget get _buildPostBottomLayout =>
      PostBottomLayout(postModel: model, postViewModel: postViewModel);

  Widget get _buildPostText => model.text != null
      ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            1.sizedBoxOnlyHeight,
            Text(
              "${model.text}",
              style: context.theme.textTheme.headline6?.copyWith(
                fontSize: context.width / 24,
                letterSpacing: 0.0,
                wordSpacing: 0,
              ),
            ),
          ],
        )
      : Container();

  Widget get postIsDeletedWidget => Builder(builder: (context) => Container());

  void _initializeValues() async {
    postViewModel.setPostModel(widget.model);
    postViewModel.setContext(context);
    postViewModel.setHomeViewModel(widget.homeViewModel);
    postViewModel.initializeValues();
    model = widget.model;
    await postViewModel.addToPostViews();
  }
}

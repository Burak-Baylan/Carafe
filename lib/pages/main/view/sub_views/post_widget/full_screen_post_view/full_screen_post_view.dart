import 'package:Carafe/core/widgets/center_dot_text.dart';
import 'package:flutter/material.dart';
import '../../../../../../core/extensions/context_extensions.dart';
import '../../../../../../core/extensions/double_extensions.dart';
import '../../../../../../core/extensions/int_extensions.dart';
import '../../../../model/post_model.dart';
import '../../../home/view_model/home_view_model.dart';
import '../post_widget/sub_widgets/name_and_menu/name_and_menu.dart';
import '../post_widget/sub_widgets/post_image_widget/post_images.dart';
import '../post_widget/sub_widgets/post_top_information.dart';
import '../post_widget/sub_widgets/profile_photo.dart';
import '../post_widget/view_model/post_view_model.dart';
import 'sub_widgets/full_screen_post_bottom_layout.dart';

class FullScreenPostView extends StatelessWidget {
  FullScreenPostView({
    Key? key,
    required this.postViewModel,
    required this.postModel,
    required this.homeViewModel,
  }) : super(key: key);

  PostViewModel postViewModel;
  HomeViewModel homeViewModel;
  PostModel postModel;
  late BuildContext context;

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Scaffold(
      appBar: _appBar,
      body: _body,
    );
  }

  Widget get _body => SingleChildScrollView(
        child: Container(
          margin: 10.0.edgeIntesetsAll,
          child: IntrinsicHeight(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IntrinsicHeight(
                  child: Column(
                    children: [
                      5.sizedBoxOnlyHeight,
                      _topInformation,
                      5.sizedBoxOnlyHeight,
                      _postUserInformation,
                      10.sizedBoxOnlyHeight,
                      Expanded(child: _postInfromationLayotu),
                    ],
                  ),
                ),
                10.sizedBoxOnlyHeight,
                CenterDotText(textColor: Colors.grey.shade500),
              ],
            ),
          ),
        ),
      );

  Widget get _postUserInformation => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPp,
          Expanded(
            child: SizedBox(
              height: context.height * 0.075,
              child: _nameAndMoreMenu,
            ),
          ),
          5.sizedBoxOnlyWidth,
        ],
      );

  Widget get _postInfromationLayotu => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          _buildPostText,
          _image,
          5.sizedBoxOnlyHeight,
          _buildPostBottomLayout
        ],
      );

  Widget get _buildPostText => postModel.text != null
      ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            1.sizedBoxOnlyHeight,
            Text(
              "${postModel.text}",
              style: TextStyle(fontSize: context.height / 40),
            ),
          ],
        )
      : Container();

  Widget get _image => Column(
        children: [
          5.sizedBoxOnlyHeight,
          ImageWidgets(
            images: postModel.imageLinks,
            fullSizeHeight: context.height / 2.8,
            halfSizeHeight: context.height / 2.8,
            onPressedImage: (imageProviders, imageUrls, imageIndex) =>
                postViewModel.onPressedImage(
                    imageProviders, imageUrls, imageIndex),
          ),
        ],
      );

  Widget get _nameAndMoreMenu => PostNameAndMenu(
        postModel: postModel,
        homeViewModel: homeViewModel,
        closeCenterDot: true,
        buildWithColumn: true,
      );

  get _buildPp => PostProfilePhoto(postModel: postModel);

  Widget get _topInformation => Align(
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            (context.height * 0.053).sizedBoxOnlyWidth,
            PostTopInformation(model: postModel),
          ],
        ),
      );

  Widget get _buildPostBottomLayout => FullScreenPostBottomLayout(
        postModel: postModel,
        postViewModel: postViewModel,
        homeViewModel: homeViewModel,
      );

  AppBar get _appBar => AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Post",
          style: TextStyle(
            fontSize: 16,
            color: context.theme.colorScheme.primary,
          ),
        ),
        iconTheme: IconThemeData(color: context.theme.colorScheme.primary),
      );
}

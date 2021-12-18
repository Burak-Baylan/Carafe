import 'view_model/post_view_model.dart';
import 'package:flutter/material.dart';

import '../../../../../core/extensions/context_extensions.dart';
import '../../../../../core/extensions/double_extensions.dart';
import '../../../../../core/extensions/int_extensions.dart';
import '../../../../../core/init/navigation/navigator/navigator.dart';
import '../../../../../core/widgets/border_container.dart';
import '../../../model/post_model.dart';
import '../../home/view/sub_views/home_page_full_screen_image/home_page_full_screen_image.dart';
import '../../home/view_model/home_view_model.dart';
import 'sub_widgets/bottom_layout.dart';
import 'sub_widgets/name_and_menu/name_and_menu.dart';
import 'sub_widgets/post_image_widget.dart';
import 'sub_widgets/post_top_information.dart';
import 'sub_widgets/profile_photo.dart';

class PostWidget extends StatefulWidget {
  PostWidget({
    Key? key,
    required this.model,
    required this.homeViewModel,
  }) : super(key: key);

  PostModel model;
  HomeViewModel homeViewModel;

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  PostViewModel postViewModel = PostViewModel();
  late PostModel model;

  @override
  Widget build(BuildContext context) {
    _initializeValues();
    return Column(
      children: [
        15.sizedBoxOnlyHeight,
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: BorderContainer.all(
            elevation: 5,
            radius: 10,
            width: context.width,
            child: InkWell(
              borderRadius: 10.radiusAll,
              onTap: () {},
              child: _postBody,
            ),
          ),
        ),
      ],
    );
  }

  _initializeValues() {
    postViewModel.setPostModel(widget.model);
    model = widget.model;
  }

  Widget get _postBody => Container(
        margin: 10.0.edgeIntesetsAll,
        child: Column(
          children: [
            _topInformation,
            5.sizedBoxOnlyHeight,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildPp,
                5.sizedBoxOnlyWidth,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      _nameAndMoreMenu,
                      _buildPostText,
                      _image,
                      5.sizedBoxOnlyHeight,
                      _buildBottomLayout
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      );

  Widget get _topInformation => Align(
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            (context.height * 0.053).sizedBoxOnlyWidth,
            PostTopInformation(model: model),
          ],
        ),
      );

  Widget get _image => Column(
        children: [
          5.sizedBoxOnlyHeight,
          ImageWidgets(
            images: model.imageLinks,
            onPressedImage: (imageProviders, imageUrls, imageIndex) =>
                onPressedImage(imageProviders, imageUrls, imageIndex),
          ),
        ],
      );

  void onPressedImage(
    List<ImageProvider<Object>?> imageProviders,
    List<dynamic> imageUrls,
    int imageIndex,
  ) {
    if (imageProviders[imageUrls.length - 1] == null) return;
    PushToPage.instance.navigateToCustomPage(
      HomePageFullScreenImage(
        onPageChanged: (index, reason) =>
            widget.homeViewModel.changeFullScreenImageIndex(index),
        imageIndex: imageIndex,
        imageProviders: imageProviders,
        imageUrls: imageUrls,
        imagesDominantColor: model.imagesDominantColors,
      ),
      animate: false,
    );
  }

  Widget get _buildPp => PostProfilePhoto(postModel: model);

  Widget get _nameAndMoreMenu => PostNameAndMenu(
        postModel: model,
        viewModel: widget.homeViewModel,
      );

  Widget get _buildBottomLayout =>
      PostBottomLayout(postModel: model, postViewModel: postViewModel, homeViewModel: widget.homeViewModel);

  Widget get _buildPostText => model.text != null
      ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            1.sizedBoxOnlyHeight,
            Text(
              "${model.text}",
              style: TextStyle(color: Colors.grey[700]),
            ),
          ],
        )
      : Container();
}

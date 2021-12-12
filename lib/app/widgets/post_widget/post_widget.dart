import 'package:flutter/material.dart';

import '../../../core/extensions/context_extensions.dart';
import '../../../core/extensions/double_extensions.dart';
import '../../../core/extensions/int_extensions.dart';
import '../../../core/init/navigation/navigator/navigator.dart';
import '../../../core/widgets/border_container.dart';
import '../../../view/main/view/home/view/sub_views/home_page_full_screen/home_page_full_screen_image.dart';
import '../../../view/main/view/home/view_model/home_view_model.dart';
import '../../models/post_model.dart';
import 'sub_widgets/bottom_layout.dart';
import 'sub_widgets/image_widgets.dart';
import 'sub_widgets/name_and_menu.dart';
import 'sub_widgets/post_top_information.dart';
import 'sub_widgets/profile_photo.dart';

class PostWidget extends StatefulWidget {
  PostWidget({Key? key, required this.model, required this.viewModel})
      : super(key: key);

  PostModel model;
  HomeViewModel viewModel;

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
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
    PushToPage.instance.navigateToCustomPage(
      HomePageFullScreenImage(
        onPageChanged: (index, reason) =>
            widget.viewModel.changeFullScreenImageIndex(index),
        imageIndex: imageIndex,
        imageProviders: imageProviders,
        imageUrls: imageUrls,
        imagesDominantColor: model.imagesDominantColors,
      ),
      animate: false,
    );
  }

  Widget get _buildPp => PostProfilePhoto(postModel: model);

  Widget get _nameAndMoreMenu => PostNameAndMenu(postModel: model);

  Widget get _buildBottomLayout => PostBottomLayout(postModel: model);

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

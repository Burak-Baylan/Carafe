import 'package:flutter/material.dart';
import '../../pages/authenticate/model/user_model.dart';
import '../../pages/main/model/post_model.dart';
import '../../pages/main/view/sub_views/post_widget/post_widget/sub_widgets/post_image_widget/post_images.dart';
import '../../pages/main/view/sub_views/post_widget/post_widget/sub_widgets/profile_photo.dart';
import '../extensions/context_extensions.dart';
import '../extensions/double_extensions.dart';
import '../extensions/timestamp_extensions.dart';
import 'center_dot_text.dart';
import 'user_name_username_text.dart';

class LitePostWidget extends StatefulWidget {
  LitePostWidget({
    Key? key,
    required this.postModel,
    required this.userModel,
  }) : super(key: key);

  PostModel postModel;
  UserModel userModel;
  double? width;

  @override
  State<LitePostWidget> createState() => _LitePostWidgetState();
}

class _LitePostWidgetState extends State<LitePostWidget> {
  late PostModel postModel;
  late UserModel userModel;

  double get pageWidth => context.width - ((context.width / 8) + 10 + 30);

  @override
  void initState() {
    postModel = widget.postModel;
    userModel = widget.userModel;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: 10.0.edgeIntesetsAll,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PostProfilePhoto(imageUrl: userModel.photoUrl, onClicked: (_) {}),
              10.0.sizedBoxOnlyWidth,
              _buildPostView,
            ],
          ),
        ),
        const Divider(height: 0),
      ],
    );
  }

  Widget get _buildPostView => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: pageWidth,
            child: Row(
              children: [
                UserNameUsernameText(userModel: userModel),
                _buildTimeAgoText,
              ],
            ),
          ),
          _buildPostText,
          _buildImages,
        ],
      );

  Widget get _buildTimeAgoText => Row(
        children: [
          CenterDotText(textColor: Colors.grey.shade500),
          Text(
            postModel.createdAt!.getTimeAgo,
            style: context.theme.textTheme.headline6?.copyWith(
              fontSize: context.width / 30,
              color: Colors.grey.shade500,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      );

  Widget get _buildPostText => postModel.text == null
      ? Container()
      : SizedBox(
          width: pageWidth,
          child: Text(
            postModel.text ?? '',
            style: context.theme.textTheme.headline6?.copyWith(
              fontSize: context.width / 26,
              letterSpacing: 0.0,
              wordSpacing: 0,
            ),
          ),
        );

  Widget get _buildImages =>
      widget.postModel.imageLinks.isEmpty ? Container() : _images;

  Widget get _images => Column(
        children: [
          10.0.sizedBoxOnlyHeight,
          SizedBox(
            width: pageWidth,
            height: context.height / 3,
            child: ImageWidgets(
              images: widget.postModel.imageLinks,
              fullSizeHeight: context.height / 3,
              halfSizeHeight: context.height / 3,
              onPressedImage: (_, __, ___, ____) {},
            ),
          ),
        ],
      );
}

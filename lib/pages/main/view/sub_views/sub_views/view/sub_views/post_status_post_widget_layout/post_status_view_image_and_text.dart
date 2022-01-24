import 'package:flutter/material.dart';
import '../../../../../../../../core/extensions/context_extensions.dart';
import '../../../../../../../../core/extensions/int_extensions.dart';
import '../../../../../../model/post_model.dart';
import '../../../../post_widget/post_widget/sub_widgets/post_image_widget/post_images.dart';

class PostStatusViewImageAndText extends StatefulWidget {
  PostStatusViewImageAndText({
    Key? key,
    required this.postModel,
  }) : super(key: key);

  PostModel postModel;

  @override
  State<PostStatusViewImageAndText> createState() =>
      _PostStatusViewImageAndTextState();
}

class _PostStatusViewImageAndTextState
    extends State<PostStatusViewImageAndText> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.postModel.imageLinks.isEmpty ? Container() : _images,
        widget.postModel.imageLinks.isEmpty
            ? Container()
            : 10.sizedBoxOnlyWidth,
        _text
      ],
    );
  }

  Widget get _images => Column(
        children: [
          SizedBox(
            width: context.width / 5,
            height: context.width / 5,
            child: ImageWidgets(
              images: widget.postModel.imageLinks,
              fullSizeHeight: context.width / 5,
              halfSizeHeight: (context.width / 2.5) / 2,
              onPressedImage: (_, __, ___, ____) {},
            ),
          )
        ],
      );

  Widget get _text => Expanded(
        child: Text(
          widget.postModel.text ?? '',
          style: context.theme.textTheme.headline6
              ?.copyWith(fontSize: context.width / 29),
        ),
      );
}

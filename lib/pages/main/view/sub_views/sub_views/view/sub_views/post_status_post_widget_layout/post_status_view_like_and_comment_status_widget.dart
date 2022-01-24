import 'package:flutter/material.dart';
import '../../../../../../../../core/extensions/context_extensions.dart';
import '../../../../../../../../core/extensions/double_extensions.dart';
import '../../../../../../../../core/extensions/int_extensions.dart';
import '../../../../../../../../core/widgets/border_container.dart';
import '../../../../../../model/post_model.dart';
import '../../sub_widgets.dart/post_status_text.dart';

class PostStatusViewLikeAndCommentStatusWidget extends StatelessWidget {
  PostStatusViewLikeAndCommentStatusWidget({
    Key? key,
    required this.postModel,
  }) : super(key: key);

  PostModel postModel;

  @override
  Widget build(BuildContext context) {
    return BorderContainer(
      color: Colors.transparent,
      padding: 10.0.edgeIntesetsTopBottom,
      width: context.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              Icon(
                Icons.favorite_border_rounded,
                color: context.colorScheme.secondary,
                size: context.width / 15,
              ),
              PostStatusText(
                text: (postModel.likeCount).shorten,
                fontSize: context.width / 25,
              ),
            ],
          ),
          Column(
            children: [
              Icon(
                Icons.mode_comment_outlined,
                color: context.colorScheme.secondary,
                size: context.width / 15,
              ),
              PostStatusText(
                text: (postModel.commentCount).shorten,
                fontSize: context.width / 25,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

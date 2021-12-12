import 'package:flutter/material.dart';

import '../../../../core/extensions/double_extensions.dart';
import '../../../../core/extensions/int_extensions.dart';
import '../../../../core/extensions/timestamp_extensions.dart';
import '../../../models/post_model.dart';

class PostBottomLayout extends StatelessWidget {
  PostBottomLayout({
    Key? key,
    required this.postModel,
  }) : super(key: key);

  PostModel postModel;

  @override
  Widget build(BuildContext context) {
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
                _buildMyText(postModel.likeCount.toString()),
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

  Widget _buildMyText(String text) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.grey[700],
        fontSize: 12,
      ),
    );
  }

  Widget _buildSmallButtons(Function onTab, IconData icon) => InkWell(
        customBorder: const CircleBorder(),
        onTap: () => onTab(),
        child: Padding(
          padding: 3.0.edgeIntesetsAll,
          child: Icon(
            icon,
            size: 21,
          ),
        ),
      );

  Widget get _buildLikeButton => _buildSmallButtons(
        () {},
        Icons.favorite_outline,
      );

  Widget get _buildCommentButton => _buildSmallButtons(
        () {},
        Icons.mode_comment_outlined,
      );

  Widget get _buildSaveButton => _buildSmallButtons(
        () {},
        Icons.bookmark_outline,
      );
}

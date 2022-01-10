import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../../../../core/extensions/context_extensions.dart';
import '../../../../../core/widgets/repyling_to_widget.dart';
import '../../../model/replying_post_model.dart';
import '../view_model/add_post_view_model.dart';
import 'post_category_selector.dart';

class AddPostTopLayout extends StatelessWidget {
  AddPostTopLayout({required this.viewModel});

  AddPostViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      padding: const EdgeInsets.only(top: 10, left: 5, right: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            radius: context.width * 0.06,
            //TODO change url
            backgroundImage: const NetworkImage(
              "https://via.placeholder.com/140x100",
            ),
          ),
          viewModel.isAComment
              ? _replyingText(context)
              : _selectCategoryWidget(context),
        ],
      ),
    );
  }

  Widget _replyingText(BuildContext context) => ReplyingToWidget(
        future: viewModel.firebaseManager
            .getAUserInformation(ReplyingPostModel(
      replyingUserId: viewModel.replyingPostPostModel!.authorId,
      replyingPostId: viewModel.replyingPostPostModel!.postId,
    ).replyingUserId),
      );

  Widget _selectCategoryWidget(BuildContext context) => Observer(
        builder: (_) {
          return TextButton(
            onPressed: () => AddPostCategorySelector.show(context, viewModel),
            child: Text(
              "Also share by category: " + viewModel.selectedCategory,
              style: TextStyle(fontSize: context.width * 0.04),
            ),
          );
        },
      );
}

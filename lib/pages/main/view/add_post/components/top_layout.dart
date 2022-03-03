import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../../../../core/extensions/context_extensions.dart';
import '../../../../../core/widgets/repyling_to_widget.dart';
import '../../../../../main.dart';
import '../../sub_views/post_widget/post_widget/sub_widgets/profile_photo.dart';
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
          PostProfilePhoto(
            imageUrl: mainVm.currentUserModel?.photoUrl,
            width: context.width / 8,
            onClicked: (_) {},
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
            .getAUserInformation(viewModel.replyingPostPostModel!.authorId),
        viewModel: viewModel,
      );

  Widget _selectCategoryWidget(BuildContext context) => Observer(
        builder: (_) {
          return TextButton(
            onPressed: () => AddPostCategorySelector.show(context, viewModel),
            child: Text(
              "Also share by category: " + viewModel.selectedCategory,
              style: context.theme.textTheme.headline6?.copyWith(
                fontSize: context.width / 25,
                color: context.colorScheme.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
          );
        },
      );
}

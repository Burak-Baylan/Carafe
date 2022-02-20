import 'package:flutter/material.dart';
import '../../../../../core/extensions/context_extensions.dart';
import '../../../../../core/widgets/animated_button.dart';
import '../view_model/add_post_view_model.dart';

class AddPostAppBar extends StatelessWidget {
  AddPostAppBar({required this.viewModel});

  AddPostViewModel viewModel;
  late BuildContext context;

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Column(
      children: [
        SizedBox(
          width: context.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildClosePageButton,
              _shareButton,
            ],
          ),
        ),
        const Divider(height: 0, thickness: 0.5),
      ],
    );
  }

  Widget get _shareButton => Container(
        padding: const EdgeInsets.only(right: 10),
        width: context.width * 0.25,
        height: 30,
        child: AnimatedButton(
          onPressed: () => viewModel.sharePost(viewModel),
          child: FittedBox(
            child: Text(
              viewModel.isAComment ? 'Reply' : 'Share',
              style: context.theme.textTheme.headline6?.copyWith(
                color: Colors.white,
                fontSize: context.width / 27,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
          ),
        ),
      );

  Widget get _buildClosePageButton => IconButton(
        icon: const Icon(Icons.close),
        color: context.colorScheme.primary,
        onPressed: () => viewModel.controlAndCloseThePage,
      );
}

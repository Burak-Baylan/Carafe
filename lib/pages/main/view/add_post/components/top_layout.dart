import 'package:Carafe/core/extensions/context_extensions.dart';
import 'package:Carafe/pages/main/view/add_post/components/post_category_selector.dart';
import 'package:Carafe/pages/main/view/add_post/view_model/add_post_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class AddPostTopLayout extends StatelessWidget {
  AddPostTopLayout({required this.viewModel});

  AddPostViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      padding: EdgeInsets.only(top: 10, right: 5, left: 5),
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
          Observer(builder: (_) {
            return TextButton(
              onPressed: () =>
                  AddPostCategorySelector.show(context, viewModel),
              child: Text(
                "Also share by category: " +
                    viewModel.selectedCategory,
                style: TextStyle(fontSize: context.width * 0.04),
              ),
            );
          }),
        ],
      ),
    );
  }
}

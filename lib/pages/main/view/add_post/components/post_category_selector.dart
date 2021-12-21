import 'package:Carafe/app/constants/app_constants.dart';
import 'package:Carafe/core/extensions/context_extensions.dart';
import 'package:Carafe/core/widgets/cupertino_action_sheet/custom_cupertino_action_sheet.dart';
import 'package:Carafe/pages/main/view/add_post/view_model/add_post_view_model.dart';
import 'package:flutter/cupertino.dart';

class AddPostCategorySelector {
  static void show(BuildContext context, AddPostViewModel viewModel) =>
      AddPostCategorySelector().showCategories(context, viewModel);

  late AddPostViewModel vm;
  late BuildContext context;

  showCategories(BuildContext context, AddPostViewModel viewModel) {
    this.context = context;
    vm = viewModel;

    showCupertinoModalPopup(
      context: context,
      builder: (context) => CustomCupertinoActionSheet(
        context: context,
        title: "Category",
        cancelButtonText: "Cancel",
        actions: [
          _buildItem(PostContstants.ALL, 1),
          _buildItem(PostContstants.TECHNOLOGY, 2),
          _buildItem(PostContstants.SOFTWARE, 3),
          _buildItem(PostContstants.GAMES, 4),
          _buildItem(PostContstants.ADVICES, 5),
          _buildItem(PostContstants.ENTERPRISE, 6),
        ],
      ),
    );
  }

  Widget _buildItem(String text, int index) => CupertinoActionSheetAction(
        onPressed: () => _selector(index),
        child: Text(text),
      );

  _selector(int index) {
    switch (index) {
      case 1:
        vm.selectCategory(PostContstants.ALL);
        break;
      case 2:
        vm.selectCategory(PostContstants.TECHNOLOGY);
        break;
      case 3:
        vm.selectCategory(PostContstants.SOFTWARE);
        break;
      case 4:
        vm.selectCategory(PostContstants.GAMES);
        break;
      case 5:
        vm.selectCategory(PostContstants.ADVICES);
        break;
      case 6:
        vm.selectCategory(PostContstants.ENTERPRISE);
        break;
      default:
    }
    context.popSheet;
  }
}

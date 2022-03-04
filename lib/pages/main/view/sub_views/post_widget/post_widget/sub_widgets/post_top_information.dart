import 'package:Carafe/main.dart';
import 'package:Carafe/pages/category/view/category_view.dart';
import 'package:flutter/material.dart';
import '../../../../../../../app/constants/app_constants.dart';
import '../../../../../../../core/extensions/context_extensions.dart';
import '../../../../../model/post_model.dart';

class PostTopInformation extends StatelessWidget {
  PostTopInformation({
    Key? key,
    required this.model,
    this.isPostPinned = false,
  }) : super(key: key);

  PostModel model;
  bool isPostPinned;
  late BuildContext context;

  @override
  Widget build(BuildContext context) {
    this.context = context;
    _findCategory();
    return _buildCategoryWidget;
  }

  IconData? categoryIcon;
  String? longCategoryName;
  String? shortCategoryName;

  void _findCategory() {
    if (isPostPinned) {
      longCategoryName = PostContstants.PINNED_POST;
      categoryIcon = PostContstants.PINNED_POST_ICON;
      return;
    }
    switch (model.category) {
      case PostContstants.ALL:
        longCategoryName = null;
        shortCategoryName = null;
        categoryIcon = null;
        break;
      case PostContstants.TECHNOLOGY:
        longCategoryName = 'Category: ' + PostContstants.TECHNOLOGY;
        shortCategoryName = PostContstants.TECHNOLOGY;
        categoryIcon = PostContstants.TECHNOLOGY_ICON;
        break;
      case PostContstants.SOFTWARE:
        longCategoryName = 'Category: ' + PostContstants.SOFTWARE;
        shortCategoryName = PostContstants.SOFTWARE;
        categoryIcon = PostContstants.SOFTWARE_ICON;
        break;
      case PostContstants.GAMES:
        longCategoryName = 'Category: ' + PostContstants.GAMES;
        shortCategoryName = PostContstants.GAMES;
        categoryIcon = PostContstants.GAMES_ICON;
        break;
      case PostContstants.ADVICES:
        longCategoryName = 'Category: ' + PostContstants.ADVICES;
        shortCategoryName = PostContstants.ADVICES;
        categoryIcon = PostContstants.ADVICES_ICON;
        break;
      case PostContstants.ENTERPRISE:
        longCategoryName = 'Category: ' + PostContstants.ENTERPRISE;
        shortCategoryName = PostContstants.ENTERPRISE;
        categoryIcon = PostContstants.ENTERPRISE_ICON;
        break;
      default:
    }
  }

  Widget get _buildCategoryWidget =>
      longCategoryName == null ? _categoryWidget(true) : _categoryWidget(false);

  Widget _categoryWidget(bool categoryNameIsNull) => SizedBox(
        height: categoryNameIsNull ? 0 : null,
        child: Row(
          children: [
            buildCategoryIcon(categoryNameIsNull),
            buildCategoryText(categoryNameIsNull),
          ],
        ),
      );

  Widget buildCategoryIcon(bool categoryNameIsNull) => SizedBox(
        width: context.width / 7.5,
        child: Align(
          child: categoryNameIsNull
              ? null
              : Icon(categoryIcon,
                  size: context.width / 25, color: AppColors.secondary),
          alignment: Alignment.centerRight,
        ),
      );

  Widget buildCategoryText(bool categoryNameIsNull) => Padding(
        padding: const EdgeInsets.only(left: 10),
        child: InkWell(
          onTap: () => navigateToCategoryPage(),
          child: Text(
            categoryNameIsNull ? "" : longCategoryName!,
            style: TextStyle(
              color: AppColors.secondary,
              fontSize: context.width / 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );

  void navigateToCategoryPage() {
    mainVm.customNavigateToPage(
      page: CategoryView(categoryName: shortCategoryName!),
      animate: true,
    );
  }
}

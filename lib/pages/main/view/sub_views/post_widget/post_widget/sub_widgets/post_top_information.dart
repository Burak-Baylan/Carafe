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
  String? categoryName;

  _findCategory() {
    if (isPostPinned) {
      categoryName = PostContstants.PINNED_POST;
      categoryIcon = PostContstants.PINNED_POST_ICON;
      return;
    }
    switch (model.category) {
      case PostContstants.ALL:
        categoryName = null;
        categoryIcon = null;
        break;
      case PostContstants.TECHNOLOGY:
        categoryName = 'Category: ' + PostContstants.TECHNOLOGY;
        categoryIcon = PostContstants.TECHNOLOGY_ICON;
        break;
      case PostContstants.SOFTWARE:
        categoryName = 'Category: ' + PostContstants.SOFTWARE;
        categoryIcon = PostContstants.SOFTWARE_ICON;
        break;
      case PostContstants.GAMES:
        categoryName = 'Category: ' + PostContstants.GAMES;
        categoryIcon = PostContstants.GAMES_ICON;
        break;
      case PostContstants.ADVICES:
        categoryName = 'Category: ' + PostContstants.ADVICES;
        categoryIcon = PostContstants.ADVICES_ICON;
        break;
      case PostContstants.ENTERPRISE:
        categoryName = 'Category: ' + PostContstants.ENTERPRISE;
        categoryIcon = PostContstants.ENTERPRISE_ICON;
        break;
      default:
    }
  }

  get _buildCategoryWidget =>
      categoryName == null ? _categoryWidget(true) : _categoryWidget(false);

  Widget _categoryWidget(bool categoryNameIsNull) => SizedBox(
        height: categoryNameIsNull ? 0 : null,
        child: Row(
          children: [
            SizedBox(
              width: (context.height * 0.075),
              child: Align(
                child: categoryNameIsNull
                    ? null
                    : Icon(categoryIcon,
                        size: context.width / 25, color: AppColors.secondary),
                alignment: Alignment.centerRight,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: InkWell(
                onTap: () {},
                child: Text(
                  categoryNameIsNull ? "" : categoryName!,
                  style: TextStyle(
                    color: AppColors.secondary,
                    fontSize: context.width / 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}

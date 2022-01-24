import 'package:flutter/material.dart';
import '../../../../../../../app/constants/app_constants.dart';
import '../../../../../../../core/extensions/context_extensions.dart';
import '../../../../../model/post_model.dart';


class PostTopInformation extends StatelessWidget {
  PostTopInformation({
    Key? key,
    required this.model,
  }) : super(key: key);

  PostModel model;
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
    switch (model.category) {
      case PostContstants.ALL:
        categoryName = null;
        categoryIcon = null;
        break;
      case PostContstants.TECHNOLOGY:
        categoryName = PostContstants.TECHNOLOGY;
        categoryIcon = PostContstants.TECHNOLOGY_ICON;
        break;
      case PostContstants.SOFTWARE:
        categoryName = PostContstants.SOFTWARE;
        categoryIcon = PostContstants.SOFTWARE_ICON;
        break;
      case PostContstants.GAMES:
        categoryName = PostContstants.GAMES;
        categoryIcon = PostContstants.GAMES_ICON;
        break;
      case PostContstants.ADVICES:
        categoryName = PostContstants.ADVICES;
        categoryIcon = PostContstants.ADVICES_ICON;
        break;
      case PostContstants.ENTERPRISE:
        categoryName = PostContstants.ENTERPRISE;
        categoryIcon = PostContstants.ENTERPRISE_ICON;
        break;
      default:
    }
  }

  get _buildCategoryWidget =>
      categoryName == null ? _categoryWidget(true) : _categoryWidget(false);

  _categoryWidget(bool nameIsNull) => SizedBox(
        height: nameIsNull ? 0 : null,
        child: Row(
          children: [
            SizedBox(
              width: (context.height * 0.075),
              child: Align(
                child: nameIsNull
                    ? null
                    : Icon(categoryIcon, size: context.width / 25, color: AppColors.secondary),
                alignment: Alignment.centerRight,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: InkWell(
                onTap: (){},
                child: Text(
                  nameIsNull ? "" : "Category: $categoryName",
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

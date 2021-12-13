import 'package:flutter/material.dart';

import '../../../constants/app_constants.dart';
import '../../../../view/main/model/post_model.dart';

class PostTopInformation extends StatelessWidget {
  PostTopInformation({
    Key? key,
    required this.model,
  }) : super(key: key);

  PostModel model;

  @override
  Widget build(BuildContext context) {
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
        categoryIcon = Icons.phone_android_outlined;
        break;
      case PostContstants.SOFTWARE:
        categoryName = PostContstants.SOFTWARE;
        categoryIcon = Icons.language_outlined;
        break;
      case PostContstants.GAMES:
        categoryName = PostContstants.GAMES;
        categoryIcon = Icons.games_outlined;
        break;
      case PostContstants.ADVICES:
        categoryName = PostContstants.ADVICES;
        categoryIcon = Icons.book_outlined;
        break;
      default:
    }
  }

  get _buildCategoryWidget =>
      categoryName == null ? _categoryWidget(true) : _categoryWidget(false);

  _categoryWidget(bool nameIsNull) => SizedBox(
        height: nameIsNull ? 0 : null,
        child: InkWell(
          onTap: () {},
          child: Row(
            children: [
              Align(
                child: nameIsNull
                    ? null
                    : Icon(categoryIcon, size: 16, color: AppColors.secondary),
                alignment: Alignment.centerRight,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Text(
                  nameIsNull ? "" : "Category: $categoryName",
                  style: TextStyle(
                    color: AppColors.secondary,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}

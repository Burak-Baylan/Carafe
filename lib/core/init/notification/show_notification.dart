import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import '../../../app/constants/app_constants.dart';
import '../../extensions/context_extensions.dart';
import '../../extensions/double_extensions.dart';
import '../../extensions/int_extensions.dart';

class ShowNotification {
  static void show({
    required BuildContext context,
    required String? title,
    bool closeTrailing = false,
    Function? onClickTrailing,
    String? type,
  }) {
    ShowNotification().showNotification(
      context: context,
      title: title,
      onClickTrailing: onClickTrailing,
      type: type,
    );
  }

  late BuildContext _context;
  late IconData leadingIcon;

  void showNotification({
    required BuildContext context,
    required String? title,
    bool closeTrailing = false,
    Function? onClickTrailing,
    String? type,
  }) {
    selectIcon(type);
    _context = context;
    showSimpleNotification(
      buildTitleText(title),
      trailing: buildTrailing(onClickTrailing),
      duration: 5.durationSeconds,
      leading: buildLeading,
      elevation: 15,
      slideDismissDirection: DismissDirection.up,
      background: Colors.white,
    );
  }

  Widget buildTitleText(String? title) {
    return Text(
      title.toString(),
      style: _context.theme.textTheme.headline6?.copyWith(
        color: AppColors.secondary,
        fontSize: 16,
      ),
    );
  }

  Widget buildTrailing(Function? onClick) {
    return InkWell(
      borderRadius: 10.borderRadiusCircular,
      onTap: () {
        if (onClick != null) {
          onClick();
        }
      },
      child: buildTrailigIcon,
    );
  }

  Widget get buildTrailigIcon {
    return Container(
      padding: 5.0.edgeIntesetsAll,
      child: Icon(
        Icons.chevron_right_rounded,
        color: AppColors.primary,
      ),
    );
  }

  Widget get buildLeading {
    return Icon(
      leadingIcon,
      color: AppColors.secondary,
    );
  }

  void selectIcon(String? type) {
    leadingIcon = Icons.favorite_rounded;
    switch (type) {
      case 'like':
        leadingIcon = Icons.favorite_rounded;
        break;
      case 'comment':
        leadingIcon = Icons.comment_outlined;
        break;
      case 'follow':
        leadingIcon = Icons.person_add_alt;
        break;
    }
  }
}

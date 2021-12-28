import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../../../../../../../../../app/constants/app_constants.dart';
import '../../../../../../../../../../core/extensions/context_extensions.dart';
import '../../../../../../../../../authenticate/model/user_model.dart';
import '../../../../../../../../model/post_model.dart';
import '../../view_model/post_menu_view_model.dart';

class PostMenuItems {
  PostMenuViewModel postMenuVm;
  UserModel userModel;
  PostModel postModel;
  BuildContext context;

  PostMenuItems({
    required this.context,
    required this.postMenuVm,
    required this.userModel,
    required this.postModel,
  });

  List<Widget> postOwnerItems() {
    return [
      Observer(
        builder: (_) => _listItem(
          3,
          postMenuVm.pinButtonText,
          () async => itemClicked(() async => await postMenuVm.pinProfileClicked()),
          Icons.push_pin_outlined,
        ),
      ),
      _listItem(
        3,
        "Edit",
        () => context.pop,
        Icons.edit_outlined,
      ),
      _listItem(
        3,
        "Delete",
        () => context.pop,
        Icons.delete_forever_outlined,
      ),
    ];
  }

  List<Widget> somoneElsePostItems() {
    var username = userModel.username;
    return [
      Observer(
        builder: (_) => _listItem(
          2,
          '${postMenuVm.followButtonText} \'$username\'',
          () async => itemClicked(() async => await postMenuVm.followUserClicked()),
          Icons.person_add_alt_outlined,
        ),
      ),
      _listItem(
        2,
        'Block \'$username\'',
        () => context.pop,
        Icons.block_outlined,
      ),
      _listItem(
        2,
        'Report \'$username\'',
        () => context.pop,
        Icons.report_gmailerrorred_outlined,
      ),
      _listItem(
        2,
        'Report post',
        () => context.pop,
        Icons.flag_outlined,
      ),
    ];
  }

  Future itemClicked(Function() function) async {
    context.pop;
    await function();
  }

  Widget _listItem(int index, String text, Function() onTap, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: AppColors.secondary),
      title: Text(
        text,
        style: TextStyle(color: AppColors.secondary, fontSize: 16),
      ),
      onTap: () => onTap(),
    );
  }
}

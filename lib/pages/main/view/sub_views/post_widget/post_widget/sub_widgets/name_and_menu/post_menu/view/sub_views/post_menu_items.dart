import 'package:Carafe/pages/main/sub_views/report/view/report_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../../../../../../../../../../app/constants/app_constants.dart';
import '../../../../../../../../../../../core/extensions/context_extensions.dart';
import '../../../../../../../../../../authenticate/model/user_model.dart';
import '../../../../../../../../../model/post_model.dart';
import '../../view_model/post_menu_view_model.dart';

class PostMenuItems {
  PostMenuViewModel postMenuVm;
  UserModel userModel;
  PostModel postModel;
  BuildContext context;
  Function? onPostPinnedOrUnpinned;

  PostMenuItems({
    required this.context,
    required this.postMenuVm,
    required this.userModel,
    required this.postModel,
    this.onPostPinnedOrUnpinned,
  });

  List<Widget> postOwnerItems() {
    postMenuVm.postViewModel.saveLock;
    return [
      Observer(
        builder: (_) => _listItem(
          postMenuVm.pinButtonText,
          () async => itemClicked(() async {
            await postMenuVm.pinProfileClicked();
            if (onPostPinnedOrUnpinned != null) {
              onPostPinnedOrUnpinned!();
            }
          }),
          Icons.push_pin_outlined,
        ),
      ),
      _listItem(
        "Delete",
        () => itemClicked(() async => await postMenuVm.deletePost()),
        Icons.delete_forever_outlined,
      ),
    ];
  }

  List<Widget> somoneElsePostItems() {
    var username = userModel.username;
    return [
      _listItem(
        '${postMenuVm.followButtonText} @$username',
        () async =>
            itemClicked(() async => await postMenuVm.followUserClicked()),
        Icons.person_add_alt_outlined,
      ),
      _listItem(
        'Report @$username',
        () =>
            itemClicked(() => postMenuVm.reportClicked(ReportType.userReport)),
        Icons.report_gmailerrorred_outlined,
      ),
      const Divider(height: 0),
      _listItem(
        'Report post',
        () =>
            itemClicked(() => postMenuVm.reportClicked(ReportType.postReport)),
        Icons.flag_outlined,
      ),
    ];
  }

  Future itemClicked(Function() function) async {
    context.pop;
    await function();
  }

  Widget _listItem(String text, Function() onTap, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: AppColors.secondary, size: context.width / 15),
      title: Text(
        text,
        style: context.theme.textTheme.headline6?.copyWith(
            color: AppColors.secondary, fontSize: context.width / 22),
      ),
      onTap: () => onTap(),
    );
  }
}

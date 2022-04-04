import 'package:flutter/material.dart';
import '../../main.dart';
import '../../pages/authenticate/model/user_model.dart';
import '../extensions/context_extensions.dart';
import '../extensions/int_extensions.dart';
import '../widgets/bottom_sheet_top_rounded_container.dart';
import 'rounded_bottom_sheet.dart';

class NotificationBottomSheet {
  static show(BuildContext context) async =>
      NotificationBottomSheet(context).build();

  NotificationBottomSheet(this.context);

  BuildContext context;

  UserModel get currentUserModel => mainVm.currentUserModel!;

  void build() async {
    var type = mainVm.currentUserModel!.notifications;
    showRoundedBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          10.sizedBoxOnlyHeight,
          const BottomSheetTopRoundedContainer(),
          10.sizedBoxOnlyHeight,
          buildOpenTile(type),
          buildCloseTile(type),
        ],
      ),
    );
  }

  Widget buildOpenTile(bool type) {
    return ListTile(
      onTap: () => _clicked(() => openNotifications()),
      trailing: type ? _checkmarkIcon : _bodylessWidget,
      title: _buildText('Open'),
    );
  }

  Widget buildCloseTile(bool type) {
    return ListTile(
      onTap: () => _clicked(() => closeNotifications()),
      trailing: !type ? _checkmarkIcon : _bodylessWidget,
      title: _buildText('Close'),
    );
  }

  Future<void> openNotifications() async {
    if (currentUserModel.notifications) {
      mainVm.showToast('Notificaitons are already on');
      return;
    }
    var response = await mainVm.userManager.openUserNotificaitons();
    if (!response) return;
    await mainVm.updateCurrentUserModel();
    mainVm.showToast('Notifications turned on');
  }

  Future<void> closeNotifications() async {
    if (!(currentUserModel.notifications)) {
      mainVm.showToast('Notificaitons are already off');
      return;
    }
    var response = await mainVm.userManager.closeUserNotifications();
    if (!response) return;
    await mainVm.updateCurrentUserModel();
    mainVm.showToast('Notifications turned off');
  }

  void _clicked(Function() onTap) {
    onTap();
    context.pop;
  }

  Widget _buildText(String text) => Text(text,
      style: context.theme.textTheme.headline6?.copyWith(
        color: context.colorScheme.secondary,
        fontSize: context.width / 26,
      ));

  Widget get _bodylessWidget => const SizedBox(width: 0, height: 0);

  Widget get _checkmarkIcon => Icon(
        Icons.check,
        color: context.colorScheme.primary,
        size: context.width / 18,
      );
}

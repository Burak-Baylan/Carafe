import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import '../../../core/base/view_model/base_view_model.dart';
import '../../../core/helpers/notification_bottom_sheet.dart';
import '../helper/verification_request_sender/bottom_sheet/verification_request_sheet.dart';
part 'settings_view_model.g.dart';

class SettingsViewModel = _SettingsViewModelBase with _$SettingsViewModel;

abstract class _SettingsViewModelBase extends BaseViewModel with Store {
  @override
  BuildContext? context;
  @override
  void setContext(BuildContext context) => this.context = context;

  Future<void> showNotificationsDialog() async =>
      NotificationBottomSheet.show(context!);

  void showVerificationRequestDialog() =>
      VerificationRequestBottomSheet.show(context!);
}

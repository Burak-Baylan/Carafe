import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import '../../../core/extensions/context_extensions.dart';
import '../../../main.dart';
import '../view_model/settings_view_model.dart';
import 'sub_views/change_password_sheet/view/change_password_sheet_view.dart';
import 'widgets/settings_description_text.dart';
import 'widgets/settings_section_text.dart';
import 'widgets/settings_title_text.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  String verifiedSectionDescription =
      'Verified accounts are marked with a tick and appear first in the searches.';
  String verifiedSectionText = 'Verification Request';
  String accountInformationText = 'Account Infromation';
  String accountText = 'Account';
  String postViewTypeText = 'Post View Type';
  String generalText = 'General';
  String notificationsText = 'Notifications';
  String emailText = 'Email';
  String changePasswordText = 'Change Password';
  String deleteAccountText = 'Delete Account';
  String deleteAccountDescription =
      'Permanently delete your account with your all user data.';
  String notificationDescription = 'Change your notification status.';
  String postViewTypeDescription = 'Change post view type.';

  SettingsViewModel settingsVm = SettingsViewModel();

  SettingsThemeData get getSettingsThemeData =>
      const SettingsThemeData(settingsListBackground: Colors.white);

  bool get isAccountVerified => mainVm.currentUserModel!.verified;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: appBar,
        body: SettingsList(
          lightTheme: getSettingsThemeData,
          sections: [buildGeneralSection, buildAccountSection],
        ),
      ),
    );
  }

  SettingsSection get buildGeneralSection => SettingsSection(
        title: SettingsTitleText(text: generalText),
        tiles: [buildViewTypeTile, buildNotificationTile],
      );

  SettingsSection get buildAccountSection => SettingsSection(
        title: SettingsTitleText(text: accountText),
        tiles: [
          buildPasswordTile,
          buildVerificationTile,
          buildDeleteAccountTile,
        ],
      );

  SettingsTile get buildViewTypeTile => SettingsTile(
        onPressed: (context) => mainVm.showPostViewTypeSelector(),
        leading: const Icon(Icons.widgets_outlined),
        description: SettingsDescriptionText(text: postViewTypeDescription),
        title: SettingsSectionText(text: postViewTypeText),
      );

  SettingsTile get buildNotificationTile => SettingsTile(
        onPressed: (context) => settingsVm.showNotificationsDialog(),
        leading: const Icon(Icons.notifications_outlined),
        description: SettingsDescriptionText(text: notificationDescription),
        title: SettingsSectionText(text: notificationsText),
      );

  SettingsTile get buildPasswordTile => SettingsTile(
        onPressed: (context) => ChangePasswordSheet.show(context),
        leading: const Icon(Icons.lock_outline_rounded),
        title: SettingsSectionText(text: changePasswordText),
      );

  SettingsTile get buildVerificationTile => SettingsTile(
        onPressed: (context) => settingsVm.showVerificationRequestDialog(),
        leading: const Icon(Icons.verified_outlined),
        title: SettingsSectionText(text: verifiedSectionText),
        enabled: !isAccountVerified,
        description: SettingsDescriptionText(text: verifiedSectionDescription),
      );

  SettingsTile get buildDeleteAccountTile => SettingsTile(
        onPressed: (context) {},
        leading: const Icon(Icons.delete_forever_outlined),
        title: SettingsSectionText(text: deleteAccountText),
        description: SettingsDescriptionText(
          text: deleteAccountDescription,
        ),
      );

  AppBar get appBar => AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () => context.pop,
        ),
        title: Text(
          'Settings',
          style: TextStyle(
            fontSize: context.width / 20,
            color: context.theme.colorScheme.primary,
          ),
        ),
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: Size(context.width, 1),
          child: const Divider(height: 0),
        ),
        iconTheme: IconThemeData(color: context.theme.colorScheme.primary),
      );

  @override
  void initState() {
    settingsVm.setContext(context);
    super.initState();
  }
}

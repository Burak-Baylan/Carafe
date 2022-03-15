import 'package:flutter/material.dart';
import 'package:share/share.dart';
import '../../../../../app/constants/app_constants.dart';
import '../../../../../core/extensions/context_extensions.dart';
import '../../../../../core/extensions/double_extensions.dart';
import '../../../../../core/helpers/feedback/feedback.dart';
import '../../../../../main.dart';
import '../../../../authenticate/authenticate_view.dart';
import '../../../../profile/view/profile_view/profile_view.dart';
import '../../../../settings/view/settings_view.dart';
import '../../../sub_views/categories_page/categories_page.dart';
import '../../../sub_views/saved_posts_view/view/saved_posts_view.dart';
import 'sub_views/main_drawer_header.dart';

class MainScreenDrawer extends StatefulWidget {
  const MainScreenDrawer({Key? key}) : super(key: key);

  @override
  _MainScreenDrawerState createState() => _MainScreenDrawerState();
}

class _MainScreenDrawerState extends State<MainScreenDrawer> {
  var headerPadding = const EdgeInsets.symmetric(horizontal: 16);
  var divider = Divider(color: Colors.grey[400], height: 0.3);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(flex: 3, child: buildHeader),
            divider,
            Flexible(
              flex: 9,
              child: SingleChildScrollView(child: buildItems),
            ),
          ],
        ),
      ),
    );
  }

  Widget get buildItems => Column(
        children: [
          _buildMenuItem(
            text: "Profile",
            icon: Icons.person_outline,
            onClick: () => _selectedItem(0),
          ),
          _buildMenuItem(
            text: "Notifications",
            icon: Icons.notifications_none_rounded,
            onClick: () => _selectedItem(1),
          ),
          _buildMenuItem(
            text: "Saved Posts",
            icon: Icons.bookmark_outline,
            onClick: () => _selectedItem(2),
          ),
          _buildMenuItem(
            text: "Categories",
            icon: Icons.category_outlined,
            onClick: () => _selectedItem(3),
          ),
          getDividerWithHeight,
          _buildMenuItem(
            text: "Settings",
            icon: Icons.settings_outlined,
            onClick: () => _selectedItem(4),
          ),
          _buildMenuItem(
            text: "Feedback",
            icon: Icons.feedback_outlined,
            onClick: () => _selectedItem(5),
          ),
          _buildMenuItem(
            text: "Share",
            icon: Icons.share_outlined,
            onClick: () => _selectedItem(6),
          ),
          getDividerWithHeight,
          _buildMenuItem(
            text: "Logout",
            icon: Icons.logout_outlined,
            onClick: () => _selectedItem(7),
          ),
        ],
      );

  void _selectedItem(int index) async {
    switch (index) {
      case 0:
        context.pop;
        _navigate(ProfileView(userId: mainVm.authService.userId!));
        break;
      case 1:
        break;
      case 2:
        context.pop;
        _navigate(SavedPostsView());
        break;
      case 3:
        context.pop;
        _navigate(const CategoriesPage());
        break;
      case 4:
        context.pop;
        _navigate(const SettingsView());
        break;
      case 5:
        SendFeedback.show(context);
        break;
      case 6:
        context.pop;
        Share.share(AppConstants.APP_LINK);
        break;
      case 7:
        _signOutAlert();
        break;
      default:
    }
  }

  Widget _buildMenuItem({
    required String text,
    required IconData icon,
    required VoidCallback onClick,
  }) =>
      InkWell(
        splashColor: Colors.grey.shade100.withOpacity(.0),
        child: ListTile(
          leading: Icon(icon, color: Colors.black, size: context.width / 16),
          hoverColor: Colors.blueAccent,
          title: Text(
            text,
            style: context.theme.textTheme.headline6
                ?.copyWith(fontSize: context.width / 22),
          ),
          onTap: null,
        ),
        onTap: onClick,
      );

  Widget get getDividerWithHeight => Column(
      children: [10.0.sizedBoxOnlyHeight, divider, 10.0.sizedBoxOnlyHeight]);

  Widget get buildHeader => Container(
        width: double.infinity,
        padding: headerPadding,
        child: MainDrawerHeader(),
      );

  Future<void> _signOut() async {
    await mainVm.userManager.removeUserToken();
    await mainVm.auth.signOut();
    _replacePage(AuthenticateView());
  }

  void _replacePage(Widget page) => mainVm.customReplacePage(page: page);
  void _navigate(Widget page) =>
      mainVm.customNavigateToPage(page: page, animate: true);

  void _signOutAlert() async => mainVm.showAlert(
        "Sign Out",
        "Are you sure you want to sign out?",
        context: context,
        negativeButtonText: "Cancel",
        positiveButtonText: "Sign out",
        onPressedPositiveButton: () => _signOut(),
      );
}

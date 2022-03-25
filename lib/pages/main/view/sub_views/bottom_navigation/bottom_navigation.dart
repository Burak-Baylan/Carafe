import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import '../../../../../core/extensions/context_extensions.dart';
import '../../../../../core/widgets/border_container.dart';
import '../../../../../main.dart';
import '../../../view_model/main_view_view_model.dart';

class MainBottomNavigation extends StatelessWidget {
  MainBottomNavigation({
    Key? key,
    required this.viewModel,
  }) : super(key: key);
  final MainViewViewModel viewModel;

  late BuildContext context;

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Divider(height: 0, thickness: 1),
        Observer(
          builder: (_) {
            return SalomonBottomBar(
              currentIndex: viewModel.currentIndex,
              onTap: (i) => viewModel.changeIndex(i),
              items: [homeIcon, searchIcon, notificationIcon],
            );
          },
        ),
      ],
    );
  }

  SalomonBottomBarItem get homeIcon => SalomonBottomBarItem(
        icon: const Icon(Icons.home_outlined),
        title: _buildText("Home"),
        unselectedColor: context.colorScheme.secondary,
        selectedColor: context.colorScheme.primary,
      );

  SalomonBottomBarItem get searchIcon => SalomonBottomBarItem(
        icon: const Icon(Icons.search_outlined),
        title: _buildText("Search"),
        unselectedColor: context.colorScheme.secondary,
        selectedColor: context.colorScheme.primary,
      );

  SalomonBottomBarItem get notificationIcon => SalomonBottomBarItem(
        icon: getNotificationIcon,
        unselectedColor: context.colorScheme.secondary,
        title: _buildText("Notification"),
        selectedColor: context.colorScheme.primary,
      );

  Widget get getNotificationIcon =>
      Observer(builder: (context) => buildNotificationIcon);

  Widget get buildNotificationIcon => Badge(
        child: const Icon(Icons.notifications_outlined),
        badgeContent: BorderContainer.all(radius: 50),
        elevation: mainVm.notificationIndicator ? 2 : 0,
        badgeColor: mainVm.notificationIndicator
            ? context.colorScheme.primary
            : Colors.transparent,
      );

  Text _buildText(String text) => Text(
        text,
        style: TextStyle(fontSize: context.width / 25),
      );
}

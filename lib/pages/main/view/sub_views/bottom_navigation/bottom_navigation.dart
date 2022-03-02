import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../../../../core/extensions/context_extensions.dart';
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
        Observer(builder: (_) {
          return BottomNavyBar(
            showElevation: false,
            selectedIndex: viewModel.currentIndex,
            items: <BottomNavyBarItem>[
              _homeIcon,
              _searchIcon,
              _notificationsIcon,
              _messagesIcon,
            ],
            onItemSelected: (index) => viewModel.changeIndex(index),
          );
        }),
      ],
    );
  }

  BottomNavyBarItem get _homeIcon => BottomNavyBarItem(
        icon: const Icon(Icons.home_outlined),
        activeColor: context.theme.colorScheme.primary,
        title: _buildText('Home'),
        inactiveColor: context.theme.colorScheme.secondary,
      );

  BottomNavyBarItem get _searchIcon => BottomNavyBarItem(
        icon: const Icon(Icons.search_outlined),
        activeColor: context.theme.colorScheme.primary,
        title: _buildText('Search'),
        inactiveColor: context.theme.colorScheme.secondary,
      );

  BottomNavyBarItem get _notificationsIcon => BottomNavyBarItem(
        icon: const Icon(Icons.notifications_outlined),
        activeColor: context.theme.colorScheme.primary,
        title: _buildText('Notification'),
        inactiveColor: context.theme.colorScheme.secondary,
      );

  BottomNavyBarItem get _messagesIcon => BottomNavyBarItem(
        icon: const Icon(Icons.mail_outline_outlined),
        activeColor: context.theme.colorScheme.primary,
        title: _buildText('Messages'),
        inactiveColor: context.theme.colorScheme.secondary,
      );

  _buildText(String text) => Text(
        text,
        style: TextStyle(fontSize: context.width / 24),
      );
}

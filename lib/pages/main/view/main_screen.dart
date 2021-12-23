import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../app/constants/app_constants.dart';
import '../../../core/base/view/base_view.dart';
import '../../../core/extensions/context_extensions.dart';
import '../../../core/extensions/int_extensions.dart';
import '../../../core/init/navigation/service/navigation_service.dart';
import '../view_model/main_view_view_model.dart';
import 'add_post/view/add_post_page.dart';
import 'home/view/home_view.dart';
import 'sub_views/bottom_navigation/bottom_navigation.dart';
import 'sub_views/drawer/main_screen_drawer.dart';

final MainViewViewModel mainVm = MainViewViewModel();

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends BaseView<MainScreen> {
  @override
  late BuildContext context;

  @override
  Widget build(BuildContext context) {
    this.context = context;
    _setViewModel(context);
    return Scaffold(
      appBar: _appBar,
      backgroundColor: AppColors.backGroundGrey,
      drawer: MainScreenDrawer(viewModel: mainVm),
      floatingActionButton: _fab,
      bottomNavigationBar: MainBottomNavigation(viewModel: mainVm),
      body: SafeArea(child: HomeView()),
    );
  }

  Widget get _fab => Observer(
        builder: (_) => AnimatedContainer(
          width: mainVm.isFabVisible ? context.height / 13 : 0,
          height: mainVm.isFabVisible ? context.height / 13 : 0,
          duration: 100.durationMilliseconds,
          child: _fabWidget,
        ),
      );

  Widget get _fabWidget => FloatingActionButton(
        backgroundColor: context.colorScheme.secondaryVariant,
        child: Icon(
          Icons.add_outlined,
          color: Colors.white,
          size: mainVm.isFabVisible ? context.height / 25 : 0,
        ),
        onPressed: () =>
            NavigationService.instance.customNavigateToPage(AddPostPage()),
      );

  AppBar get _appBar => AppBar(
        backgroundColor: AppColors.white,
        leading: _leading,
        centerTitle: true,
        title: Text(
          "Home",
          style: TextStyle(
            fontSize: 16,
            color: context.theme.colorScheme.primary,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.filter_alt_outlined,
              color: context.theme.colorScheme.primary,
            ),
            onPressed: () {},
          ),
        ],
      );

  Widget get _leading => Padding(
        padding: const EdgeInsets.all(10),
        child: Builder(builder: (context) {
          return GestureDetector(
            onTap: () => context.openDrawer,
            child: const CircleAvatar(
              backgroundImage: NetworkImage(
                'https://via.placeholder.com/140x100',
                scale: 20,
              ),
            ),
          );
        }),
      );

  _setViewModel(BuildContext context) {
    mainVm.setContext(context);
  }
}

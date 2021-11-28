// ignore_for_file: prefer_const_constructors

import 'package:Carafe/app/constants/constants_colors.dart';
import 'package:Carafe/core/base/view/base_view.dart';
import 'package:Carafe/core/base/view_model/base_view_model.dart';
import 'package:Carafe/core/constants/navigation/navigation_constants.dart';
import 'package:Carafe/core/init/navigation/service/navigation_service.dart';
import 'package:Carafe/core/widgets/custom_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/svg.dart';
import 'package:Carafe/core/extensions/context_extensions.dart';
import 'package:Carafe/core/widgets/border_container.dart';
import 'package:Carafe/view/authenticate/view/login/view/login_view.dart';
import 'package:Carafe/view/authenticate/view/signup/view/signup_view.dart';
import 'package:Carafe/view/authenticate/view_model/authenticate_view_model.dart';

class AuthenticateView extends StatefulWidget {
  AuthenticateView({Key? key}) : super(key: key);

  @override
  State<AuthenticateView> createState() => _AuthenticateViewState();
}

TabController? tabController;

class _AuthenticateViewState extends BaseView<AuthenticateView>
    with SingleTickerProviderStateMixin {
  final double paddingValue = 35;
  final AuthenticateViewModel authVm = AuthenticateViewModel();

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    tabController!.addListener(() {
      authVm.changeHeaderImage(tabController!.index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Observer(
      builder: (_) => Scaffold(
        backgroundColor: context.colorScheme.background,
        body: SafeArea(
          child: Column(
            children: [
              _buildImage,
              _buildTabBar,
              Expanded(
                child: _tabBarView,
              ),
            ],
          ),
        ),
      ),
    );
  }

  TabBarView get _tabBarView => TabBarView(
        controller: tabController,
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          LoginScreen(),
          SignupView(),
        ],
      );

  AnimatedContainer get _buildImage => AnimatedContainer(
        duration: context.duration100ms,
        height:
            context.mediaQuery.viewInsets.bottom > 0 ? 0 : context.height * 0.3,
        child: Center(
          child: SvgPicture.asset(authVm.headerImage),
        ),
      );

  BorderContainer get _buildTabBar => BorderContainer(
        bottomLeft: paddingValue,
        bottomRight: paddingValue,
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.only(left: paddingValue, right: paddingValue),
          child: _tabBar,
        ),
      );

  TabBar get _tabBar => TabBar(
        controller: tabController,
        labelColor: AppColors.secondary,
        indicatorColor: context.colorScheme.primary,
        indicatorWeight: 3,
        indicatorSize: TabBarIndicatorSize.label,
        // ignore: prefer_const_literals_to_create_immutables
        tabs: [
          Tab(text: "Login"),
          Tab(text: "Signup"),
        ],
      );
}

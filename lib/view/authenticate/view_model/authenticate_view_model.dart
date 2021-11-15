import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:Carafe/core/constants/svg/svg_constants.dart';
import 'package:Carafe/view/authenticate/authenticate_view.dart';
part 'authenticate_view_model.g.dart';

class AuthenticateViewModel = _AuthenticateViewModelBase
    with _$AuthenticateViewModel;

abstract class _AuthenticateViewModelBase with Store{
  int loginPageIndex = 0;
  int signupPageIndex = 1;

  @observable
  String headerImage = SVGConstants.instance.login;

  @action
  changeHeaderImage(int index) {
    switch (index) {
      case 0:
        headerImage = SVGConstants.instance.login;
        break;
      case 1:
        headerImage = SVGConstants.instance.signup;
        break;
    }
  }

  @action
  changeTabIndex(int index) {
    if (tabController != null) {
      tabController!.index = index;
    }
  }
}

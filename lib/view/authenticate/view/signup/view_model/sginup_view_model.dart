// ignore_for_file: overridden_fields

import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:Carafe/view/authenticate/view_model/authenticate_view_model.dart';
import 'package:Carafe/view/authenticate/view_model/base_authentication_view_model.dart';
part 'sginup_view_model.g.dart';

class SignupViewModel = _SignupViewModelBase with _$SignupViewModel;

abstract class _SignupViewModelBase extends IAuthenticationViewModel
    with Store {
  @override
  AuthenticateViewModel authVm = AuthenticateViewModel();

  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passworController = TextEditingController();

  @override
  changeTabIndex(int index) => authVm.changeTabIndex(index);
}

// ignore_for_file: override_on_non_overriding_member

import 'package:Carafe/view/authenticate/view_model/authenticate_view_model.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
part 'login_view_model.g.dart';

class LoginViewModel = _LoginViewModelBase with _$LoginViewModel;

abstract class _LoginViewModelBase with Store {


  @override
  AuthenticateViewModel authVm = AuthenticateViewModel();

  TextEditingController emailController = TextEditingController();
  TextEditingController passworController = TextEditingController();

  @action
  String s = "2s2";

  @override
  @action
  changeTabIndex(int index) => authVm.changeTabIndex(index);

}
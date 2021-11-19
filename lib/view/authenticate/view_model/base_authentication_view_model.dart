import 'package:flutter/src/widgets/framework.dart';
import '../../../core/base/view_model/base_view_model.dart';
import 'authenticate_view_model.dart';

abstract class IAuthenticationViewModel extends BaseViewModel {
  BuildContext? context;
  AuthenticateViewModel authVm = AuthenticateViewModel();
  void changeTabIndex(int index);
  @override
  setContext(BuildContext context);
}

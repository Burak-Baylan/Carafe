import 'package:Carafe/view/authenticate/view_model/authenticate_view_model.dart';

abstract class IAuthenticationViewModel{
  AuthenticateViewModel authVm = AuthenticateViewModel();
  void changeTabIndex(int index);
}
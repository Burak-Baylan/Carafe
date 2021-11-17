import 'package:Carafe/core/constants/navigation/navigation_constants.dart';
import 'package:Carafe/core/init/navigation/service/navigation_service.dart';

class PushToPage {
  static final PushToPage _instance = PushToPage._init();
  static PushToPage get instance => _instance;
  PushToPage._init();

  mainPage() => NavigationService.instance
      .navigateToPage(path: NavigationConstans.MAIN_VIEW, data: null);

  forgotPasswordPage() => NavigationService.instance.navigateToPage(
      path: NavigationConstans.FORGOT_PASSWORD_VIEW, data: null);
}

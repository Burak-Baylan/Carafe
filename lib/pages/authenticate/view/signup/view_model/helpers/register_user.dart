import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../../../../app/constants/app_constants.dart';
import '../../../../../../core/base/view_model/base_view_model.dart';
import '../../../../../../core/error/custom_error.dart';
import '../../../../../../core/firebase/auth/authentication/response/authentication_response.dart';
import '../../../../model/user_model.dart';
import '../sginup_view_model.dart';

class RegisterUser extends BaseViewModel {
  static RegisterUser? _instance;
  static RegisterUser get instance =>
      _instance = _instance == null ? RegisterUser._init() : _instance!;
  RegisterUser._init();

  late SignupViewModel vm;
  late AuthnenticationResponse authenticationResponse;

  register(
    AuthnenticationResponse authenticationResponse,
    SignupViewModel viewModel,
  ) async {
    vm = viewModel;
    this.authenticationResponse = authenticationResponse;

    bool isResponseOkey = authSignupResponseControl(authenticationResponse);

    if (isResponseOkey) {
      CustomError userCreateResponse =
          await userService.createUser(_getUserModel);

      bool isUserCrated = await firebaseSignupResponseControl(
          userCreateResponse, authenticationResponse);

      if (isUserCrated) {
        await authService.sendVerificationEmail(authenticationResponse.user!);
        vm.showSignupSuccessAlert();
        vm.clearAllTextInputs();
      }
    }
  }

  bool authSignupResponseControl(AuthnenticationResponse response) {
    if (response.error != null) {
      showAlert("Error", response.error!.errorMessage.toString(),
          context: vm.context!, disableNegativeButton: true);
      return false;
    }
    return true;
  }

  Future<bool> firebaseSignupResponseControl(
    CustomError response,
    AuthnenticationResponse authResponse,
  ) async {
    vm.currentTime;
    if (response.errorMessage == null) {
      return true;
    } else {
      await authService.deleteUser(authResponse.user!);
      showAlert("Error", response.errorMessage!,
          context: vm.context!, disableNegativeButton: true);
      return false;
    }
  }

  UserModel get _getUserModel => UserModel(
        user: authenticationResponse.user!,
        profileDescription: null,
        createdAt: Timestamp.now(),
        profilePrivacy: false,
        followersCount: 0,
        followingCount: 0,
        verified: false,
        profilePhotoBackgroundColor: AppColors.black,
        notifications: true,
      );

  @override
  setContext(BuildContext context) {}
}

import 'package:Carafe/app/constants/app_constants.dart';
import 'package:Carafe/core/base/view_model/base_view_model.dart';
import 'package:Carafe/core/error/custom_error.dart';
import 'package:Carafe/core/firebase/auth/authentication/response/authentication_response.dart';
import 'package:Carafe/app/models/user_model.dart';
import 'package:Carafe/view/authenticate/view/signup/view_model/sginup_view_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/widgets/framework.dart';

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

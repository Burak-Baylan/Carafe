import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/widgets/framework.dart';
import '../../../../../../app/constants/app_constants.dart';
import '../../../../../../core/base/view_model/base_view_model.dart';
import '../../../../../../core/data/custom_data.dart';
import '../../../../../../core/error/custom_error.dart';
import '../../../../model/user_model.dart';
import '../sginup_view_model.dart';

class RegisterUser extends BaseViewModel {
  static RegisterUser? _instance;
  static RegisterUser get instance =>
      _instance = _instance == null ? RegisterUser._init() : _instance!;
  RegisterUser._init();

  late SignupViewModel vm;
  late CustomData<UserCredential> authenticationResponse;

  Future register(
    CustomData<UserCredential> response,
    SignupViewModel viewModel,
  ) async {
    vm = viewModel;
    authenticationResponse = response;

    bool isResponseOkey = authSignupResponseControl(response);

    if (isResponseOkey) {
      CustomError userCreateResponse =
          await userService.createUser(_getUserModel);

      response.error = userCreateResponse;

      bool isUserCrated = await firebaseSignupResponseControl(response);

      if (isUserCrated) {
        await authService.sendVerificationEmail();
        vm.showSignupSuccessAlert();
        vm.clearAllTextInputs();
      }
    }
    return;
  }

  bool authSignupResponseControl(CustomData response) {
    if (response.error != null) {
      showAlert("Error", response.error!.errorMessage.toString(),
          context: vm.context!, disableNegativeButton: true);
      return false;
    }
    return true;
  }

  Future<bool> firebaseSignupResponseControl(
    CustomData<UserCredential> response,
  ) async {
    vm.currentTime;
    if (response.error!.errorMessage == null) {
      return true;
    } else {
      await authService.deleteUser(response.data!.user!);
      showAlert("Error", response.error!.errorMessage!,
          context: vm.context!, disableNegativeButton: true);
      return false;
    }
  }

  UserModel get _getUserModel => UserModel(
        userId: authenticationResponse.data!.user!.uid,
        email: vm.email!,
        username: vm.username!,
        photoUrl: null,
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

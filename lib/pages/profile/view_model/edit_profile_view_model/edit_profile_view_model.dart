import 'dart:io';
import 'package:Carafe/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';
import '../../../../core/alerts/loading_alert_dialog.dart';
import '../../../../core/base/view_model/base_view_model.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/extensions/string_extensions.dart';
import '../../../../core/helpers/rounded_bottom_sheet.dart';
import '../../../authenticate/model/user_model.dart';
import '../profile_view_model/profile_view_model.dart';
part 'edit_profile_view_model.g.dart';

class EditProfileViewModel = _EditProfileViewModelBase
    with _$EditProfileViewModel;

abstract class _EditProfileViewModelBase extends BaseViewModel with Store {
  @override
  BuildContext? context;

  @observable
  File? ppImageFile;

  @action
  void changePpImageFile(File? file) => ppImageFile = file;

  @override
  void setContext(BuildContext context) {
    this.context = context;
    prepareCurrentValues();
  }

  late UserModel userModel;
  late String oldDisplayName;
  late String oldDescription;
  late String oldWebsite;
  late Timestamp? oldBirthDate;
  late ProfileViewModel profileViewModel;
  late TextEditingController displayNameController;
  late TextEditingController descriptionController;
  late TextEditingController websiteController;
  late TextEditingController birthDateController;
  FocusNode displayNameFocusNode = FocusNode();
  FocusNode descriptionFocusNode = FocusNode();
  FocusNode websiteFocusNode = FocusNode();
  Timestamp? birthDate;
  var loadingPBar = LoadingAlertDialog.instance;

  void prepareCurrentValues() {
    oldDisplayName = userModel.displayName;
    oldDescription = userModel.profileDescription ?? '';
    oldWebsite = userModel.website ?? '';
    oldBirthDate = userModel.birthDate;
  }

  void setProfileViewModel(ProfileViewModel profileViewModel) {
    this.profileViewModel = profileViewModel;
    userModel = profileViewModel.userModel!;
    displayNameController = TextEditingController(text: userModel.displayName);
    descriptionController =
        TextEditingController(text: userModel.profileDescription);
    websiteController = TextEditingController(text: userModel.website);
    birthDateController = TextEditingController(
      text: profileViewModel.userModel!.birthDate != null
          ? DateFormat("MMMM d, yyyy")
              .format(profileViewModel.userModel!.birthDate!.toDate())
          : '',
    );
  }

  Future checkChanges() async {
    context!.closeKeyboard;
    startLoadingBar();
    String newDisplayName = displayNameController.text;
    String newDescription = descriptionController.text;
    String newWebsite = websiteController.text;
    Timestamp? newBirthDate = birthDate;

    if (isProfilePhotoChanged()) {
      await userManager.updateUserProfilePhoto(ppImageFile!);
    }

    if (isDisplayNameChanged()) {
      var displayNameValidate = newDisplayName.displayNameValidator;
      if (displayNameValidate != null) {
        dismissLoadingBar();
        showToast(displayNameValidate);
        return;
      }
      var response =
          await userManager.updateCurrentUserDisplayName(newDisplayName);
      if (response) {
        oldDisplayName = newDisplayName;
      }
    }

    if (isDescriptionChanged()) {
      var response =
          await userManager.updateCurrentUserDescription(newDescription);
      if (response) {
        oldDescription = newDescription;
      }
    }

    if (isWebsiteChanged()) {
      if (newWebsite != '') {
        dismissLoadingBar();
        showToast("Url type is not correct");
        return;
      }
      var response = await userManager.updateCurrentUserWebsite(newWebsite);
      if (response) {
        oldWebsite = newWebsite;
      }
    }

    if (isBirthDateChanged()) {
      if (newBirthDate != null) {
        var response =
            await userManager.updateCurrentUserBirthDate(newBirthDate);
        if (response) {
          oldBirthDate = newBirthDate;
        }
      }
    }

    dismissLoadingBar();
    mainVm.updateCurrentUserModel();
    profileViewModel.refreshPage();
    context!.pop;
  }

  void startLoadingBar() => loadingPBar.show(context!);
  void dismissLoadingBar() => loadingPBar.dismiss();

  bool isProfilePhotoChanged() => ppImageFile == null ? false : true;

  bool isDisplayNameChanged() =>
      oldDisplayName == displayNameController.text ? false : true;

  bool isDescriptionChanged() =>
      oldDescription == descriptionController.text ? false : true;

  bool isWebsiteChanged() =>
      oldWebsite == websiteController.text ? false : true;

  bool isBirthDateChanged() => oldBirthDate == birthDate ? false : true;

  void showDatePicker() {
    displayNameFocusNode.unfocus();
    descriptionFocusNode.unfocus();
    websiteFocusNode.unfocus();
    showDatePickerSheet(
      context: context!,
      onDateTimeSelected: (date) => selectDateTime(date),
    );
  }

  void selectDateTime(DateTime date) {
    var formattedDate = DateFormat("MMMM d, yyyy").format(date);
    birthDate = Timestamp.fromDate(date);
    birthDateController.text = formattedDate;
  }
}

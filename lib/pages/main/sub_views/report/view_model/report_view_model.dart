import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import '../../../../../core/alerts/alert_dialog/success_and_error_alert_dialog.dart';
import '../../../../../core/base/view_model/base_view_model.dart';
import '../../../../../core/extensions/context_extensions.dart';
import '../../../../../core/extensions/string_extensions.dart';
import '../../../../authenticate/model/user_model.dart';
import '../../../model/post_model.dart';
import '../../../model/reported_post_model.dart';
import '../../../model/reported_user_model.dart';
import '../view/report_view.dart';
part 'report_view_model.g.dart';

class ReportViewModel = _ReportViewModelBase with _$ReportViewModel;

abstract class _ReportViewModelBase extends BaseViewModel with Store {
  @override
  BuildContext? context;
  @override
  void setContext(BuildContext context) => this.context = context;

  void setReportType(ReportType reportType) => this.reportType = reportType;
  void setPostModel(PostModel? postModel) => this.postModel = postModel;
  void setUserModel(UserModel userModel) => this.userModel = userModel;

  PostModel? postModel;
  UserModel? userModel;

  late ReportType reportType;

  TextEditingController reportReasonTextFieldController =
      TextEditingController();
  TextEditingController emailTextFieldController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<void> report() async {
    if (!checkForms) return;
    if (reportType == ReportType.postReport) {
      reportPost();
    } else if (reportType == ReportType.userReport) {
      reportUser();
    }
  }

  Future<void> reportPost() async {
    var ref = firebaseConstants.reportedPostsCollection.doc();
    var response =
        await firebaseService.addDocument(ref, _reportedPostModel.toJson());
    if (response.errorMessage != null) {
      showErrorAlertDialog(context!);
      return;
    }
    showSuccessAlertDialog(context!).then((value) => context!.pop);
  }

  Future<void> reportUser() async {
    var ref = firebaseConstants.reportedUsersCollection.doc();
    var response =
        await firebaseService.addDocument(ref, _reportedUserModel.toJson());
    if (response.errorMessage != null) {
      showErrorAlertDialog(context!);
      return;
    }
    showSuccessAlertDialog(context!).then((value) => context!.pop);
  }

  bool get checkForms {
    if (!checkReasonForm) {
      return false;
    }
    if (!checkEmailForm) {
      return false;
    }
    return true;
  }

  bool get checkReasonForm {
    var text = reportReasonTextFieldController.text;
    if (text.isEmpty) {
      showToast('Reason cannot be empty');
      return false;
    }
    return true;
  }

  bool get checkEmailForm {
    var text = emailTextFieldController.text;
    if (!(formKey.currentState!.validate())) {
      return false;
    }
    if (text.isNotEmpty && !(text.isEmailValid)) {
      showToast('Email type is not correct');
      return false;
    }
    return true;
  }

  String? emailValidator(String? text) {
    if (text!.isNotEmpty && !(text.trim().isEmailValid)) {
      return "Email not valid";
    }
    return null;
  }

  ReportedPostModel get _reportedPostModel => ReportedPostModel(
        createdAt: currentTime,
        reportedPostRef: postModel!.postPath,
        reportedPostId: postModel!.postId,
        reporterId: authService.userId!,
        reportedId: userModel!.userId,
        reportReason: reportReasonTextFieldController.text,
        reporterEmail: emailTextFieldController.text,
      );

  ReportedUserModel get _reportedUserModel => ReportedUserModel(
        createdAt: currentTime,
        reportedUserId: userModel!.userId,
        reporterUserId: authService.userId!,
        reportReason: reportReasonTextFieldController.text,
        reporterEmail: emailTextFieldController.text,
      );
}

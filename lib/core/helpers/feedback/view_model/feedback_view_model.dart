import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
import '../../../../pages/main/model/feedback_model.dart';
import '../../../base/view_model/base_view_model.dart';
import '../../../extensions/context_extensions.dart';
import '../../internet_controller.dart';
part 'feedback_view_model.g.dart';

class FeedbackViewModel = _FeedbackViewModelBase with _$FeedbackViewModel;

abstract class _FeedbackViewModelBase extends BaseViewModel with Store {
  @override
  BuildContext? context;
  @override
  void setContext(BuildContext context) => this.context = context;

  TextEditingController feedbackTextController = TextEditingController();

  DocumentReference<Map<String, dynamic>> getFirebaseRef(String docId) =>
      firebaseConstants.feedbackCollectionRef.doc(docId);

  @action
  Future<void> send() async {
    if (!(await checkInternet)) return;
    if (!checkTextField) return;
    var ref = getFirebaseRef(randomId);
    var response = await firebaseService.addDocument(ref, getModel.toJson());
    if (response.errorMessage != null) {
      showErrorAlert;
      return;
    }
    context!.pop;
    showSuccessAlert;
  }

  Future<bool> get checkInternet async {
    if (!(await InternetController.check)) {
      showNoInternetAlert(context!);
      return false;
    }
    return true;
  }

  bool get checkTextField {
    String text = feedbackTextController.text;
    if (text.isEmpty) {
      showEmptyTextFieldError;
      return false;
    }
    return true;
  }

  void get showErrorAlert => showAlert(
        'Error',
        'Something went wrong. Please try again.',
        disableNegativeButton: true,
        positiveButtonText: 'Done',
        context: context!,
      );

  void get showSuccessAlert => showAlert(
        'Success',
        'Your feedback is sent. Thanks for your time :)',
        disableNegativeButton: true,
        positiveButtonText: 'Done',
        context: context!,
      );

  void get showEmptyTextFieldError => showAlert(
        'Error',
        'Feedback couldnt be empty. Please write something.',
        disableNegativeButton: true,
        positiveButtonText: 'Done',
        context: context!,
      );

  FeedbackModel get getModel => FeedbackModel(
        createdAt: currentTime,
        feedbackMessage: feedbackTextController.text,
        userId: authService.userId!,
      );
}

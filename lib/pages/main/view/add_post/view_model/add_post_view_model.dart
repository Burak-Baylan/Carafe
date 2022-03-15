import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
import '../../../../../app/constants/app_constants.dart';
import '../../../../../core/base/view_model/base_view_model.dart';
import '../../../../../core/error/custom_error.dart';
import '../../../../../core/extensions/context_extensions.dart';
import '../../../../../core/extensions/int_extensions.dart';
import '../../../../../core/helpers/image_picker/select_image.dart';
import '../../../../../core/helpers/internet_controller.dart';
import '../../../model/post_model.dart';
import '../../../model/replying_post_model.dart';
import 'helpers/add_post_alert_dialog_helper.dart';
import 'helpers/share_post.dart';
part 'add_post_view_model.g.dart';

class AddPostViewModel = _AddPostViewModelBase with _$AddPostViewModel;

abstract class _AddPostViewModelBase extends BaseViewModel with Store {
  @override
  BuildContext? context;
  @observable
  bool isWritable = true;
  @observable
  double circularBarValue = 0;
  @observable
  int textLength = 0;
  @observable
  Color progressBarColor = AppColors.secondary;
  @observable
  List<File?> images = [];
  @observable
  int imagesLength = 0;
  @observable
  String selectedCategory = PostContstants.ALL;
  @observable
  String? postText;
  @observable
  bool screenLockState = false;
  ScrollController scrollController = ScrollController();
  bool isAComment = false;
  CollectionReference? postAddingReference;
  PostModel? replyingPostPostModel;
  AddPostAlertDialogHelper addPostAlertDiaogHelper = AddPostAlertDialogHelper();
  SharePost postSharer = SharePost.instance;

  @action
  void selectCategory(String category) => selectedCategory = category;

  void scrollToLastItem() => scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: 300.durationMilliseconds,
        curve: Curves.fastOutSlowIn,
      );

  @override
  void setContext(BuildContext context) => this.context = context;

  @action
  void onPostTextChanged(String text) {
    textLength = text.length;
    circularBarValue = textLength / PostContstants.MAX_POST_TEXT_LENGTH;
    postText = text;
    _lengthController();
  }

  @action
  void changeScreenLockState() => screenLockState = !screenLockState;

  Future<void> sharePost(AddPostViewModel viewModel) async {
    if (!(await InternetController.check)) {
      showNoInternetAlert(context!);
      return;
    }
    if (textLength == 0 && images.isEmpty) return;
    changeScreenLockState();
    context!.closeKeyboard;
    CustomError response;
    if (viewModel.isAComment) {
      response = await shareComment(viewModel);
    } else {
      response = await postSharer.share(viewModel);
    }
    changeScreenLockState();
    if (response.errorMessage != null) {
      addPostAlertDiaogHelper.postSharingErrorAlert(
          context!, response.errorMessage!);
      return;
    }
    context!.pop;
  }

  Future<CustomError> shareComment(AddPostViewModel viewModel) async {
    var userModel = await firebaseManager
        .getAUserInformation(replyingPostPostModel!.authorId);
    if (userModel == null) {
      return CustomError('UserModel is null');
    }
    return await postSharer.share(
      viewModel,
      postRef: postAddingReference,
      replyingPostModel: ReplyingPostModel(
        replyingPostId: replyingPostPostModel!.postId,
        replyingUserId: replyingPostPostModel!.authorId,
        replyingUserToken: userModel.token,
      ),
    );
  }

  Future<void> get pickImageAlertSelector async =>
      SelectImage().showImageSelectorAlert(
          context: context!, onSelected: (File? image) => _putImage(image));

  Future<void> _putImage(File? file) async {
    if (file == null) return;
    if (imagesLength != 4) {
      images.add(file);
      imagesLength++;
    } else {
      addPostAlertDiaogHelper.putImageErrorAlert(context!);
    }
  }

  void deleteIndex(int index) {
    if (images.isEmpty) return;
    images[index] = null;
    List<File?> imageList = [];
    for (var i = 0; i < images.length; i++) {
      if (images[i] != null) imageList.add(images[i]!);
    }
    images = imageList;
    imagesLength = images.length;
  }

  @action
  void _lengthController() {
    if (textLength >= PostContstants.MAX_POST_TEXT_LENGTH) {
      isWritable = false;
      progressBarColor = PostContstants.MAX_LENGTH_COLOR;
    } else if (textLength >= PostContstants.WARNING_POST_TEXT_LENGTH) {
      progressBarColor = PostContstants.WARNING_LENGTH_COLOR;
    } else {
      progressBarColor = AppColors.secondary;
    }
  }

  Future<void> get controlAndCloseThePage async =>
      _control ? context!.pop : addPostAlertDiaogHelper.showQuitAlert(context!);

  Future<bool> canPageClose() async {
    if (_control) {
      return true;
    } else {
      await addPostAlertDiaogHelper.showQuitAlert(context!);
      return false;
    }
  }

  bool get _control => (textLength == 0 && images.isEmpty) ? true : false;
}

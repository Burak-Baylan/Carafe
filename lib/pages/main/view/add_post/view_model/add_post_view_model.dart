import 'dart:io';
import '../../../../../core/helpers/internet_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';
import '../../../../../app/constants/app_constants.dart';
import '../../../../../core/alerts/bottom_sheet/cupertino_action_sheet/custom_cupertino_action_sheet.dart';
import '../../../../../core/base/view_model/base_view_model.dart';
import '../../../../../core/error/custom_error.dart';
import '../../../../../core/extensions/context_extensions.dart';
import '../../../../../core/extensions/int_extensions.dart';
import '../../../../../core/helpers/image_picker.dart';
import '../../../../../core/permissions/permissions.dart';
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

  @action
  selectCategory(String category) => selectedCategory = category;

  scrollToLastItem() => scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: 300.durationMilliseconds,
        curve: Curves.fastOutSlowIn,
      );

  @override
  setContext(BuildContext context) => this.context = context;

  @action
  onPostTextChanged(String text) {
    textLength = text.length;
    circularBarValue = textLength / PostContstants.MAX_POST_TEXT_LENGTH;
    postText = text;
    _lengthController();
  }

  @action
  changeScreenLockState() => screenLockState = !screenLockState;

  Future sharePost(AddPostViewModel viewModel) async {
    if (!(await InternetController.check)){
      showNoInternetAlert(context!);
      return;
    }
    if (textLength == 0 && images.isEmpty) return;
    changeScreenLockState();
    CustomError response;
    if (viewModel.isAComment) {
      response = await SharePost.instance.share(
        viewModel,
        postRef: postAddingReference,
        replyingPostModel: ReplyingPostModel(
          replyingPostId: replyingPostPostModel!.postId,
          replyingUserId: replyingPostPostModel!.authorId,
        ),
      );
    } else {
      response = await SharePost.instance.share(viewModel);
    }
    changeScreenLockState();
    if (response.errorMessage != null) {
      addPostAlertDiaogHelper.postSharingErrorAlert(
          context!, response.errorMessage!);
      return;
    }
    context!.pop;
  }

  Future get pickImageAlertSelector async {
    showCupertinoModalPopup(
      context: context!,
      builder: (context) => CustomCupertinoActionSheet(
        cancelButtonText: "Cancel",
        actions: [
          _buildCupertinoItem("Camera", () => pickImageFromCamera),
          _buildCupertinoItem("Gallery", () => pickImageGallery),
        ],
        context: context,
      ),
    );
  }

  Widget _buildCupertinoItem(String text, Function() onPressed) =>
      CupertinoActionSheetAction(
        onPressed: () => onPressed(),
        child: Text(
          text,
          style: context?.theme.textTheme.headline6
              ?.copyWith(color: context?.colorScheme.primary),
        ),
      );

  Future _pickImage(ImageSource imageSource) async {
    if (imageSource == ImageSource.camera) {
      //if (!(await CameraPermission.instance.request())) return null;
      _putImage(await PickImage.instance.camera());
    } else {
      if (!(await Permissions.instance.storagePermission())) return null;
      _putImage(await PickImage.instance.gallery());
    }
  }

  Future get pickImageFromCamera async => _pickImage(ImageSource.camera);

  Future get pickImageGallery async => _pickImage(ImageSource.gallery);

  Future _putImage(File? file) async {
    if (file == null) return;
    if (imagesLength != 4) {
      images.add(file);
      imagesLength++;
    } else {
      addPostAlertDiaogHelper.putImageErrorAlert(context!);
    }
  }

  deleteIndex(int index) {
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
  _lengthController() {
    if (textLength >= PostContstants.MAX_POST_TEXT_LENGTH) {
      isWritable = false;
      progressBarColor = PostContstants.MAX_LENGTH_COLOR;
    } else if (textLength >= PostContstants.WARNING_POST_TEXT_LENGTH) {
      progressBarColor = PostContstants.WARNING_LENGTH_COLOR;
    } else {
      progressBarColor = AppColors.secondary;
    }
  }

  get controlAndCloseThePage =>
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

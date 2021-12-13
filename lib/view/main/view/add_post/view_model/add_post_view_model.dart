import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../../../app/constants/app_constants.dart';
import '../../../../../core/base/view_model/base_view_model.dart';
import '../../../../../core/extensions/context_extensions.dart';
import '../../../../../core/extensions/int_extensions.dart';
import '../../../../../core/helpers/image_picker.dart';
import '../../../../../core/widgets/cupertino_action_sheet/custom_cupertino_action_sheet.dart';
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
  int imageLength = 0;
  @observable
  String selectedCategory = PostContstants.ALL;
  @observable
  String? postText;
  @observable
  bool lockState = false;
  ScrollController scrollController = ScrollController();

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
  onTextChanged(String text) {
    textLength = text.length;
    circularBarValue = textLength / PostContstants.MAX_POST_TEXT_LENGTH;
    postText = text;
    _lengthController();
  }

  @action
  changeStateLock() => lockState = !lockState;

  Future sharePost(AddPostViewModel viewModel) async {
    if (textLength == 0 && images.isEmpty) return;
    changeStateLock();
    var response = await SharePost.instance.share(viewModel);
    changeStateLock();
    if (response.errorMessage != null) {
      showAlert(
        "Error",
        response.errorMessage!,
        context: context!,
        negativeButtonText: "Cancel",
        positiveButtonText: "Exit",
        onPressedPositiveButton: () => context!.pop,
      );
      return;
    }
    context!.pop;
  }

  Future get pickImage async {
    showCupertinoModalPopup(
      context: context!,
      builder: (context) => CustomCupertinoActionSheet(
        cancelButtonText: "Cancel",
        actions: [
          _buildItem("Camera", () => pickImageFromCamera),
          _buildItem("Gallery", () => pickImageGallery),
        ],
        context: context,
      ),
    );
  }

  Widget _buildItem(String text, Function() onPressed) =>
      CupertinoActionSheetAction(
        onPressed: () => onPressed(),
        child: Text(text),
      );

  Future get pickImageFromCamera async =>
      _putImage(await PickImage.instance.camera());

  Future get pickImageGallery async =>
      _putImage(await PickImage.instance.gallery());

  Future _putImage(File? file) async {
    if (file == null) return;
    if (imageLength != 4) {
      images.add(file);
      imageLength++;
    } else {
      showAlert(
        "Message",
        "You can only select 4 image.\nIf you want, you can delete one of the photos you have uploaded.",
        context: context!,
        disableNegativeButton: true,
      );
    }
  }

  deleteIndex(int index) {
    if (images.isEmpty) return;
    images[index] = null;
    List<File?> myImageList = [];
    for (var i = 0; i < images.length; i++) {
      if (images[i] != null) myImageList.add(images[i]!);
    }
    images = myImageList;
    imageLength = images.length;
  }

  @action
  _lengthController() {
    if (textLength >= PostContstants.MAX_POST_TEXT_LENGTH) {
      isWritable = false;
      progressBarColor = Colors.redAccent;
    } else if (textLength >= PostContstants.WARNING_POST_TEXT_LENGTH) {
      progressBarColor = Colors.orangeAccent;
    } else {
      progressBarColor = AppColors.secondary;
    }
  }

  get _showQuitAlert => showAlert(
        "Remove Post",
        "Are you sure you want to delete your post and exit.",
        context: context!,
        negativeButtonText: "Cancel",
        positiveButtonText: "Exit",
        onPressedPositiveButton: () => context!.pop,
      );

  get controlAndCloseThePage => _control ? context!.pop : _showQuitAlert;

  Future<bool> canPageClose() async {
    if (_control) {
      return true;
    } else {
      await _showQuitAlert;
      return false;
    }
  }

  bool get _control => (textLength == 0 && images.isEmpty) ? true : false;
}

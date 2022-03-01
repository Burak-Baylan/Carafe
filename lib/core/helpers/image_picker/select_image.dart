import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import '../../alerts/bottom_sheet/cupertino_action_sheet/custom_cupertino_action_sheet.dart';
import '../../extensions/context_extensions.dart';
import '../../permissions/permissions.dart';
import 'image_picker.dart';

class SelectImage {
  late Function(File? image) onSelected;
  late BuildContext context;
  void showImageSelectorAlert({
    required BuildContext context,
    required Function(File? image) onSelected,
  }) {
    this.context = context;
    this.onSelected = onSelected;
    showCupertinoModalPopup(
      context: context,
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
          style: context.theme.textTheme.headline6
              ?.copyWith(color: context.colorScheme.primary),
        ),
      );

  Future<void> _pickImage(ImageSource imageSource) async {
    if (imageSource == ImageSource.camera) {
      //if (!(await CameraPermission.instance.request())) return null;
      onSelected(await PickImage.instance.camera());
    } else {
      if (!(await Permissions.instance.storagePermission())) return null;
      onSelected(await PickImage.instance.gallery());
    }
  }

  Future<void> get pickImageFromCamera async => _pickImage(ImageSource.camera);
  Future<void> get pickImageGallery async => _pickImage(ImageSource.gallery);
}

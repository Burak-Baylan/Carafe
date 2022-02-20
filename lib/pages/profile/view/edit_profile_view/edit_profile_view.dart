import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/extensions/double_extensions.dart';
import '../../../../core/extensions/int_extensions.dart';
import '../../../../core/helpers/image_picker/select_image.dart';
import '../../../../core/widgets/animated_button.dart';
import '../../../../core/widgets/border_container.dart';
import '../../../main/view/sub_views/post_widget/post_widget/sub_widgets/profile_photo.dart';
import '../../view_model/edit_profile_view_model/edit_profile_view_model.dart';
import '../../view_model/profile_view_model/profile_view_model.dart';

class EditProfileView extends StatefulWidget {
  EditProfileView({
    Key? key,
    required this.profileViewModel,
  }) : super(key: key);

  ProfileViewModel profileViewModel;

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  EditProfileViewModel editProfileViewModel = EditProfileViewModel();

  @override
  void initState() {
    super.initState();
    editProfileViewModel.setProfileViewModel(widget.profileViewModel);
  }

  @override
  Widget build(BuildContext context) {
    editProfileViewModel.setContext(context);
    return Scaffold(
      appBar: _appBar,
      body: SingleChildScrollView(
        child: Container(
          margin: 15.0.edgeIntesetsAll,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              15.0.sizedBoxOnlyHeight,
              Align(child: changePhotoWidget, alignment: Alignment.center),
              15.0.sizedBoxOnlyHeight,
              _buildTitleText('Username'),
              _buildText(widget.profileViewModel.userModel!.username),
              const Divider(),
              5.sizedBoxOnlyHeight,
              _buildTitleText('Email'),
              _buildText(widget.profileViewModel.userModel!.email),
              const Divider(),
              15.0.sizedBoxOnlyHeight,
              buildTextForm(
                text: 'Display Name',
                controller: editProfileViewModel.displayNameController,
                focusNode: editProfileViewModel.displayNameFocusNode,
              ),
              15.0.sizedBoxOnlyHeight,
              buildTextForm(
                text: 'Description',
                maxLines: 3,
                controller: editProfileViewModel.descriptionController,
                focusNode: editProfileViewModel.descriptionFocusNode,
              ),
              15.0.sizedBoxOnlyHeight,
              buildTextForm(
                text: 'Website',
                controller: editProfileViewModel.websiteController,
                focusNode: editProfileViewModel.websiteFocusNode,
              ),
              15.0.sizedBoxOnlyHeight,
              GestureDetector(
                onTap: () => editProfileViewModel.showDatePicker(),
                child: buildTextForm(
                  text: 'Birth Date',
                  controller: editProfileViewModel.birthDateController,
                  enabled: false,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitleText(String text) => Text(
        text,
        style: context.theme.textTheme.headline6?.copyWith(
          fontSize: context.width / 27,
          color: context.colorScheme.secondary,
        ),
      );

  Widget _buildText(String text) => Text(
        text,
        style: context.theme.textTheme.headline6?.copyWith(
          fontSize: context.width / 25,
          color: Colors.black,
        ),
      );

  Widget buildTextForm({
    required String text,
    FocusNode? focusNode,
    bool enabled = true,
    TextEditingController? controller,
    int maxLines = 1,
    int? maxLength,
  }) =>
      BorderContainer.all(
        radius: 10,
        padding: 5.0.edgeIntesetsAll,
        color: Colors.grey[200],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text,
              style: context.theme.textTheme.headline6?.copyWith(
                color: context.colorScheme.secondary,
                fontSize: context.width / 27,
              ),
            ),
            TextFormField(
              enabled: enabled,
              focusNode: focusNode,
              controller: controller,
              autofocus: false,
              maxLines: maxLines,
              minLines: 1,
              maxLength: maxLength,
              decoration: const InputDecoration(border: InputBorder.none),
            ),
          ],
        ),
      );

  Widget get changePhotoWidget => GestureDetector(
        onTap: () => SelectImage().showImageSelectorAlert(
          context: context,
          onSelected: (image) => editProfileViewModel.changePpImageFile(image),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Observer(
              builder: (_) => ClipRRect(
                borderRadius: (context.width ~/ 3).borderRadiusCircular,
                child: ppImageWidget,
              ),
            ),
            BorderContainer.all(
              radius: 500,
              color: Colors.black.withOpacity(.2),
              height: context.width / 3,
              width: context.width / 3,
            ),
            SizedBox(
              height: context.width / 3,
              width: context.width / 3,
              child: Align(
                alignment: Alignment.center,
                child: Icon(
                  Icons.add_a_photo_outlined,
                  color: Colors.white,
                  size: context.width / 13,
                ),
              ),
            ),
          ],
        ),
      );

  Widget get ppImageWidget => PostProfilePhoto(
        imageUrl: widget.profileViewModel.userModel!.photoUrl,
        imageFile: editProfileViewModel.ppImageFile,
        height: context.width / 3,
        width: context.width / 3,
        onClicked: (provider) {},
      );

  AppBar get _appBar => AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () => context.pop,
        ),
        title: Text(
          "Edit Profile",
          style: TextStyle(
            fontSize: context.width / 20,
            color: context.theme.colorScheme.primary,
          ),
        ),
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: Size(context.width, 0),
          child: const Divider(height: 0),
        ),
        actions: [saveButton],
        iconTheme: IconThemeData(color: context.theme.colorScheme.primary),
      );

  Widget get saveButton => Container(
        padding: const EdgeInsets.only(right: 10, top: 13, bottom: 13),
        width: context.width * 0.23,
        height: 30,
        child: AnimatedButton(
          onPressed: () => editProfileViewModel.checkChanges(),
          child: FittedBox(
            child: Text(
              'Save',
              style: context.theme.textTheme.headline6?.copyWith(
                color: Colors.white,
                fontSize: context.width / 27,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
        ),
      );
}

import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../../../../../app/constants/app_constants.dart';
import '../../../../../../../core/extensions/context_extensions.dart';
import '../../../../../../../core/extensions/int_extensions.dart';
import '../../../../../../../core/widgets/border_container.dart';
import '../../../../../../../main.dart';
import '../../../../../../profile/view/profile_view/profile_view.dart';
import '../../../../../model/post_model.dart';
import '../view_model/post_view_model.dart';

class PostProfilePhoto extends StatelessWidget {
  PostProfilePhoto({
    Key? key,
    this.postModel,
    this.imageUrl,
    this.width,
    this.height,
    this.onClicked,
    this.postViewModel,
    this.imageFile,
    this.placeHolderImageUrl,
  }) : super(key: key);

  PostModel? postModel;
  String? imageUrl;
  double? width;
  double? height;
  Function(ImageProvider<Object>)? onClicked;
  PostViewModel? postViewModel;
  File? imageFile;
  String? placeHolderImageUrl;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? context.width / 8,
      height: height ?? context.width / 8,
      child: imageFile != null ? fileImageWidget : networkImageWidget,
    );
  }

  Widget get fileImageWidget => Image.file(imageFile!, fit: BoxFit.cover);

  Widget get networkImageWidget => CachedNetworkImage(
        fadeInDuration: 0.durationMilliseconds,
        filterQuality: FilterQuality.medium,
        placeholder: (context, url) => _placeHolder,
        placeholderFadeInDuration: 100.durationMilliseconds,
        imageBuilder: (context, provider) => _imageBuilder(provider),
        imageUrl: imageUrl ?? (placeHolderImageUrl ?? "https://bit.ly/3HTCLko"),
        fit: BoxFit.cover,
      );

  Widget _imageBuilder(ImageProvider provider) => Material(
        shape: const CircleBorder(),
        clipBehavior: Clip.antiAlias,
        color: Colors.transparent,
        child: Ink.image(
          width: width,
          height: height,
          fit: BoxFit.cover,
          image: provider,
          child: InkWell(
            onTap: () =>
                onClicked != null ? onClicked!(provider) : _sendToProfile(),
            splashColor: Colors.grey.shade100.withOpacity(.0),
          ),
        ),
      );

  Widget get _placeHolder =>
      BorderContainer.all(radius: 100, color: AppColors.placeHolderGray);

  void _sendToProfile() {
    mainVm.customNavigateToPage(
        page: ProfileView(userId: postModel!.authorId), animate: true);
    postViewModel != null ? postViewModel!.addToProfileVisits() : null;
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../../../../../app/constants/app_constants.dart';
import '../../../../../../../core/extensions/context_extensions.dart';
import '../../../../../../../core/extensions/int_extensions.dart';
import '../../../../../../../core/widgets/border_container.dart';
import '../../../../../model/post_model.dart';

class PostProfilePhoto extends StatelessWidget {
  PostProfilePhoto({
    Key? key,
    required this.postModel,
  }) : super(key: key);

  PostModel postModel;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.height * 0.075,
      height: context.height * 0.075,
      child: CachedNetworkImage(
        fadeInDuration: 0.durationMilliseconds,
        filterQuality: FilterQuality.medium,
        placeholder: (context, url) => _placeHolder,
        placeholderFadeInDuration: 100.durationMilliseconds,
        imageBuilder: (context, provider) => _imageBuilder(provider),
        imageUrl: postModel.imageLinks.isNotEmpty
            ? postModel.imageLinks[0]
            : "https://bit.ly/3HTCLko",
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _imageBuilder(ImageProvider provider) => Container(
        decoration: BoxDecoration(
          borderRadius: 50.radiusAll,
          border: Border.all(color: Colors.grey.shade500, width: 0.3),
          image: DecorationImage(fit: BoxFit.cover, image: provider),
        ),
      );

  Widget get _placeHolder => BorderContainer.all(
        radius: 100,
        color: AppColors.placeHolderGray,
      );
}

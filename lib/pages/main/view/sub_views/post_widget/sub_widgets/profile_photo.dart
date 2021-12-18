import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../../../app/constants/app_constants.dart';
import '../../../../../../core/extensions/context_extensions.dart';
import '../../../../../../core/extensions/int_extensions.dart';
import '../../../../../../core/widgets/border_container.dart';
import '../../../../model/post_model.dart';

class PostProfilePhoto extends StatelessWidget {
  PostProfilePhoto({
    Key? key,
    required this.postModel,
  }) : super(key: key);

  PostModel postModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.height * 0.075,
      height: context.height * 0.075,
      margin: const EdgeInsets.only(right: 3),
      child: CachedNetworkImage(
        fadeInDuration: 0.durationMilliseconds,
        filterQuality: FilterQuality.medium,
        placeholder: (context, url) => BorderContainer.all(
          radius: 100,
          color: AppColors.placeHolderGray,
        ),
        placeholderFadeInDuration: 100.durationMilliseconds,
        imageBuilder: (context, provider) => Container(
          decoration: BoxDecoration(
            borderRadius: 50.radiusAll,
            image: DecorationImage(fit: BoxFit.cover, image: provider),
          ),
        ),
        //TODO Delete Placeholder
        imageUrl: postModel.imageLinks.isNotEmpty
            ? postModel.imageLinks[0]
            : "https://via.placeholder.com/140x100",
        fit: BoxFit.cover,
      ),
    );
  }
}

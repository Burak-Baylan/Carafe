import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../../../../../../../app/constants/app_constants.dart';
import '../../../../../../../../../core/extensions/int_extensions.dart';
import '../../../../../../../../../core/helpers/random_id.dart';
import '../../../../../../../../../core/widgets/border_container.dart';

class PostImageWidget extends StatelessWidget {
  PostImageWidget({
    Key? key,
    required this.imageLink,
    required this.borderRadius,
    this.width = double.infinity,
    required this.height,
    required this.onPressedImage,
    required this.getProvider,
  }) : super(key: key);

  String imageLink;
  BorderRadiusGeometry borderRadius;
  double width;
  double height;
  Function(String imageTag) onPressedImage;
  Function(ImageProvider<Object>? p) getProvider;

  @override
  Widget build(BuildContext context) => _image();

  String tagForImage = getRandomId();

  Widget _image() {
    return CachedNetworkImage(
      fadeInDuration: 0.durationMilliseconds,
      filterQuality: FilterQuality.medium,
      placeholder: (context, url) => BorderContainer.all(
        radius: 10,
        color: AppColors.placeHolderGray,
      ),
      placeholderFadeInDuration: 100.durationMilliseconds,
      imageBuilder: (context, provider) {
        getProvider(provider);
        return _buildImageContainer(provider);
      },
      imageUrl: imageLink,
      fit: BoxFit.cover,
    );
  }

  Widget _buildImageContainer(ImageProvider<Object> provider) => Material(
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius,
          side: BorderSide(color: Colors.grey.shade500, width: 0.3),
        ),
        clipBehavior: Clip.antiAlias,
        color: Colors.transparent,
        child: Ink.image(
          width: width,
          height: height,
          image: provider,
          fit: BoxFit.cover,
          child: InkWell(
            onTap: () => onPressedImage(tagForImage),
            splashColor: Colors.grey.shade100.withOpacity(.0),
          ),
        ),
      );
}

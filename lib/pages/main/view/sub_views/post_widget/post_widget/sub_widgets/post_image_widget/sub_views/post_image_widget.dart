import 'package:Carafe/app/constants/app_constants.dart';
import 'package:Carafe/core/extensions/int_extensions.dart';
import 'package:Carafe/core/widgets/border_container.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PostImageWidget extends StatelessWidget {
  PostImageWidget(
      {Key? key,
      required this.imageLink,
      required this.borderRadius,
      this.width = double.infinity,
      required this.height,
      required this.onPressedImage,
      required this.getProvider})
      : super(key: key);

  String imageLink;
  BorderRadiusGeometry borderRadius;
  double width;
  double height;
  Function() onPressedImage;
  Function(ImageProvider<Object>? p) getProvider;

  @override
  Widget build(BuildContext context) => _image();

  Widget _image() => InkWell(
        onTap: () => onPressedImage(),
        child: Hero(
          tag: imageLink,
          child: CachedNetworkImage(
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
          ),
        ),
      );

  _buildImageContainer(ImageProvider<Object> provider) => Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          border: Border.all(color: Colors.grey.shade500, width: 0.3),
          image: DecorationImage(fit: BoxFit.cover, image: provider),
        ),
      );
}

import 'package:Carafe/app/constants/app_constants.dart';
import 'package:Carafe/core/widgets/border_container.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/extensions/int_extensions.dart';

class ImageWidgets extends StatelessWidget {
  ImageWidgets({Key? key, required this.images, required this.onPressedImage})
      : super(key: key);

  List<dynamic> images;
  late BuildContext context;
  late Widget body;
  List<ImageProvider<Object>?> imageProviders = [null, null, null, null];

  Function(List<ImageProvider<Object>?> imageProviders, List<dynamic> imageUrls,
      int index) onPressedImage;

  @override
  Widget build(BuildContext context) {
    this.context = context;
    _getImagesCount();
    return body;
  }

  _getImagesCount() {
    switch (images.length) {
      case 0:
        body = Container();
        break;
      case 1:
        body = buildOneImage(images);
        break;
      case 2:
        body = buildTwoImageLayout(images);
        break;
      case 3:
        body = buildThreeImageLayout(images);
        break;
      case 4:
        body = buildFourImageLayout(images);
        break;
      default:
    }
  }

  Widget buildOneImage(List<dynamic> images) => SizedBox(
        height: context.height / 3,
        child: _image(
          imageIndex: 0,
          height: context.height / 3,
          images: images,
          borderRadius: 10.radiusAll,
        ),
      );

  Widget buildTwoImageLayout(List<dynamic> images) => SizedBox(
        width: double.infinity,
        height: context.height / 3.5,
        child: Row(
          children: [
            Expanded(
              child: _image(
                imageIndex: 0,
                images: images,
                height: context.height / 3.5,
                borderRadius: 10.radiusTopLeftBottomLeft,
              ),
            ),
            3.sizedBoxOnlyWidth,
            Expanded(
              child: _image(
                imageIndex: 1,
                height: context.height / 3.5,
                images: images,
                borderRadius: 10.radiusTopRightBottomRight,
              ),
            ),
          ],
        ),
      );

  Widget buildThreeImageLayout(List<dynamic> images) => SizedBox(
        width: double.infinity,
        height: context.height / 3.5,
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: _image(
                images: images,
                height: (context.height / 3.5) + 3,
                borderRadius: 10.radiusTopLeftBottomLeft,
                imageIndex: 0,
              ),
            ),
            3.sizedBoxOnlyWidth,
            _expandedColumn(
              [
                _image(
                  images: images,
                  height: (((context.height / 3.5) / 2) - 1.5),
                  borderRadius: 10.radiusTopRight,
                  imageIndex: 1,
                ),
                3.sizedBoxOnlyHeight,
                _image(
                  images: images,
                  height: (((context.height / 3.5) / 2) - 1.5),
                  borderRadius: 10.radiusBottomRight,
                  imageIndex: 2,
                ),
              ],
            )
          ],
        ),
      );

  Widget buildFourImageLayout(List<dynamic> images) => SizedBox(
        height: context.height / 3.5,
        width: double.infinity,
        child: Row(
          children: [
            _expandedColumn([
              _image(
                borderRadius: 10.radiusTopLeft,
                height: (((context.height / 3.5) / 2) - 1.5),
                imageIndex: 0,
                images: images,
              ),
              3.sizedBoxOnlyHeight,
              _image(
                borderRadius: 10.radiusBottomLeft,
                height: (((context.height / 3.5) / 2) - 1.5),
                imageIndex: 1,
                images: images,
              ),
            ]),
            3.sizedBoxOnlyWidth,
            _expandedColumn([
              _image(
                borderRadius: 10.radiusTopRight,
                height: (((context.height / 3.5) / 2) - 1.5),
                imageIndex: 2,
                images: images,
              ),
              3.sizedBoxOnlyHeight,
              _image(
                borderRadius: 10.radiusBottomRight,
                height: (((context.height / 3.5) / 2) - 1.5),
                imageIndex: 3,
                images: images,
              ),
            ]),
          ],
        ),
      );

  Expanded _expandedColumn(List<Widget> children, {int flex = 1}) =>
      Expanded(flex: flex, child: Column(children: children));

  Widget _image({
    required List<dynamic> images,
    required BorderRadiusGeometry borderRadius,
    double width = double.infinity,
    required double height,
    required int imageIndex,
  }) =>
      InkWell(
        onTap: () => onPressedImage(imageProviders, images, imageIndex),
        child: Hero(
          tag: images[imageIndex],
          child: CachedNetworkImage(
            fadeInDuration: 0.durationMilliseconds,
            filterQuality: FilterQuality.medium,
            placeholder: (context, url) => BorderContainer.all(
              radius: 10,
              color: AppColors.placeHolderGray,
            ),
            placeholderFadeInDuration: 100.durationMilliseconds,
            imageBuilder: (context, provider) {
              imageProviders[imageIndex] = provider;
              return Container(
                width: width,
                height: height,
                decoration: BoxDecoration(
                  borderRadius: borderRadius,
                  image: DecorationImage(fit: BoxFit.cover, image: provider),
                ),
              );
            },
            imageUrl: images[imageIndex],
            fit: BoxFit.cover,
          ),
        ),
      );
}

import 'package:flutter/material.dart';
import '../../../../../../../../core/extensions/context_extensions.dart';
import '../../../../../../../../core/extensions/int_extensions.dart';
import 'sub_views/post_image_widget.dart';

class ImageWidgets extends StatelessWidget {
  ImageWidgets({
    Key? key,
    required this.images,
    required this.onPressedImage,
    this.fullSizeHeight,
    this.halfSizeHeight,
    this.quarterSizeHeight,
  }) : super(key: key);

  List<dynamic> images;
  late BuildContext context;
  late Widget body;
  List<ImageProvider<Object>?> imageProviders = [null, null, null, null];
  double? fullSizeHeight;
  double? halfSizeHeight;
  double? quarterSizeHeight;

  Function(
    List<ImageProvider<Object>?> imageProviders,
    List<dynamic> imageUrls,
    int index,
    String imageTag,
  ) onPressedImage;

  double get quarterSize =>
      (((halfSizeHeight ?? ((context.height) / 3.5)) / 2) - 1.5);
  double get halfSize => halfSizeHeight ?? context.height / 3.5;
  double get fullSize => fullSizeHeight ?? context.height / 3;

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
      height: fullSize,
      child: PostImageWidget(
        imageLink: images[0],
        borderRadius: 10.radiusAll,
        height: fullSize,
        onPressedImage: (tagForImage) =>
            onPressedImage(imageProviders, images, 0, tagForImage),
        getProvider: (prr) => imageProviders[0] = prr,
      ));

  Widget buildTwoImageLayout(List<dynamic> images) => SizedBox(
        width: double.infinity,
        height: halfSize,
        child: Row(
          children: [
            Expanded(
              child: PostImageWidget(
                imageLink: images[0],
                borderRadius: 10.radiusTopLeftBottomLeft,
                height: halfSize,
                onPressedImage: (tagForImage) =>
                    onPressedImage(imageProviders, images, 0, tagForImage),
                getProvider: (prr) => imageProviders[0] = prr,
              ),
            ),
            3.sizedBoxOnlyWidth,
            Expanded(
              child: PostImageWidget(
                imageLink: images[1],
                borderRadius: 10.radiusTopRightBottomRight,
                height: halfSize,
                onPressedImage: (tagForImage) =>
                    onPressedImage(imageProviders, images, 1, tagForImage),
                getProvider: (prr) => imageProviders[1] = prr,
              ),
            ),
          ],
        ),
      );

  Widget buildThreeImageLayout(List<dynamic> images) => SizedBox(
        width: double.infinity,
        height: halfSize,
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: PostImageWidget(
                imageLink: images[0],
                borderRadius: 10.radiusTopLeftBottomLeft,
                height: halfSize + 3,
                onPressedImage: (tagForImage) =>
                    onPressedImage(imageProviders, images, 0, tagForImage),
                getProvider: (provider) => imageProviders[0] = provider,
              ),
            ),
            3.sizedBoxOnlyWidth,
            _expandedColumn(
              [
                PostImageWidget(
                  imageLink: images[1],
                  borderRadius: 10.radiusTopRight,
                  height: quarterSize,
                  onPressedImage: (tagForImage) =>
                      onPressedImage(imageProviders, images, 1, tagForImage),
                  getProvider: (provider) => imageProviders[1] = provider,
                ),
                3.sizedBoxOnlyHeight,
                PostImageWidget(
                  imageLink: images[2],
                  borderRadius: 10.radiusBottomRight,
                  height: quarterSize,
                  onPressedImage: (tagForImage) =>
                      onPressedImage(imageProviders, images, 2, tagForImage),
                  getProvider: (provider) => imageProviders[2] = provider,
                ),
              ],
            )
          ],
        ),
      );

  Widget buildFourImageLayout(List<dynamic> images) => SizedBox(
        height: halfSize,
        width: double.infinity,
        child: Row(
          children: [
            _expandedColumn([
              PostImageWidget(
                imageLink: images[0],
                borderRadius: 10.radiusTopLeft,
                height: quarterSize,
                onPressedImage: (tagForImage) => onPressedImage(imageProviders, images, 0, tagForImage),
                getProvider: (provider) => imageProviders[0] = provider,
              ),
              3.sizedBoxOnlyHeight,
              PostImageWidget(
                imageLink: images[1],
                borderRadius: 10.radiusBottomLeft,
                height: quarterSize,
                onPressedImage: (tagForImage) => onPressedImage(imageProviders, images, 1, tagForImage),
                getProvider: (provider) => imageProviders[1] = provider,
              ),
            ]),
            3.sizedBoxOnlyWidth,
            _expandedColumn([
              PostImageWidget(
                imageLink: images[2],
                borderRadius: 10.radiusTopRight,
                height: quarterSize,
                onPressedImage: (tagForImage) => onPressedImage(imageProviders, images, 2, tagForImage),
                getProvider: (provider) => imageProviders[2] = provider,
              ),
              3.sizedBoxOnlyHeight,
              PostImageWidget(
                imageLink: images[3],
                borderRadius: 10.radiusBottomRight,
                height: quarterSize,
                onPressedImage: (tagForImage) => onPressedImage(imageProviders, images, 3, tagForImage),
                getProvider: (provider) => imageProviders[3] = provider,
              ),
            ]),
          ],
        ),
      );

  Expanded _expandedColumn(List<Widget> children, {int flex = 1}) =>
      Expanded(flex: flex, child: Column(children: children));
}

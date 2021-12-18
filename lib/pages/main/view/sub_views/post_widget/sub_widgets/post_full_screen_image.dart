import 'package:Carafe/core/extensions/context_extensions.dart';
import 'package:Carafe/core/widgets/full_screen_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';


class PostFullScreenImage extends StatelessWidget {
  PostFullScreenImage({
    Key? key,
    required this.imageUrl,
    required this.imageProvider,
  }) : super(key: key);

  String? imageUrl;
  ImageProvider<Object>? imageProvider;

  @override
  Widget build(BuildContext context) {
    return FullScreenImage(
      tag: imageUrl,
      imageWidget: _buildImageWidget(context),
    );
  }

  Widget _buildImageWidget(BuildContext context) {
    return SizedBox(
      width: context.width,
      height: context.height,
      child: PhotoView(
        backgroundDecoration: const BoxDecoration(color: Colors.black),
        maxScale: PhotoViewComputedScale.contained * 5,
        minScale: PhotoViewComputedScale.contained * 1,
        imageProvider: imageProvider,
      ),
    );
  }
}

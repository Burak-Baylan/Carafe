import 'dart:io';

import 'package:Carafe/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:photo_view/photo_view.dart';

class ZoomableImage extends StatefulWidget {
  ZoomableImage({
    required this.image,
    this.backgroundColor,
    this.width,
    this.height,
    this.minScale,
    this.maxScale,
  });

  File image;

  double? width;
  double? height;
  double? minScale;
  double? maxScale;
  Color? backgroundColor;

  @override
  State<ZoomableImage> createState() => _ZoomableImageState();
}

class _ZoomableImageState extends State<ZoomableImage> {
  Color? myColor;

  bool lockState = false;


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width ?? context.width,
      height: widget.height ?? context.height,
      child: Observer(builder: (_) {
        return PhotoView(
          backgroundDecoration: BoxDecoration(color: Colors.black),
          maxScale: PhotoViewComputedScale.contained * (widget.minScale ?? 5),
          minScale: PhotoViewComputedScale.contained * (widget.maxScale ?? 1),
          imageProvider: FileImage(widget.image),
        );
      }),
    );
  }
}

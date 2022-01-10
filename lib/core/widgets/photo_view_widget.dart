import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import '../extensions/context_extensions.dart';

class PhotoViewWidget extends StatefulWidget {
  PhotoViewWidget({
    required this.image,
    this.backgroundColor,
    this.width,
    this.height,
    this.minScale,
    this.maxScale,
    this.scaleStateChangedCallback,
  });

  ImageProvider<Object> image;

  double? width;
  double? height;
  double? minScale;
  double? maxScale;
  Color? backgroundColor;
  void Function(PhotoViewScaleState)? scaleStateChangedCallback;

  @override
  State<PhotoViewWidget> createState() => _PhotoViewWidgetState();
}

class _PhotoViewWidgetState extends State<PhotoViewWidget> {
  Color? myColor;
  bool lockState = false;

  @override
  Widget build(BuildContext context) => SizedBox(
        width: widget.width ?? context.width,
        height: widget.height ?? context.height,
        child: PhotoView(
          scaleStateChangedCallback: (state) =>
              widget.scaleStateChangedCallback != null
                  ? widget.scaleStateChangedCallback!(state)
                  : null,
          backgroundDecoration:
              BoxDecoration(color: widget.backgroundColor ?? Colors.transparent),
          maxScale: PhotoViewComputedScale.contained * (widget.minScale ?? 5),
          minScale: PhotoViewComputedScale.contained * (widget.maxScale ?? 1),
          initialScale:
              PhotoViewComputedScale.contained * (widget.maxScale ?? 1),
          imageProvider: widget.image,
        ),
      );
}

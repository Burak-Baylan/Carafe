import 'dart:io';

import 'package:flutter/material.dart';

class ImagesSizeGetter {
  static Future<ImageSize> getSize(File image) async =>
      await ImagesSizeGetter()._getSize(image);

  late int width;
  late int height;

  Future<ImageSize> _getSize(File image) async {
    await decodeImageFromList(
      image.readAsBytesSync(),
    ).then((value) {
      width = value.width;
      height = value.height;
    });

    return ImageSize(image: image, width: width, height: height);
  }
}

class ImageSize {
  File image;
  int width;
  int height;

  ImageSize({required this.image, required this.width, required this.height});

  @override
  String toString() {
    return "Width: $width || Height: $height || File: $image";
  }
}

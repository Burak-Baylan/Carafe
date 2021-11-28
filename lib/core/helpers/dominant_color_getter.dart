import 'dart:io';

import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

class DominantColorGetter {
  static Future<Color?> getColor(File image) async {
    var palette = await PaletteGenerator.fromImageProvider(FileImage(image));
    return palette.dominantColor?.color;
  }
}

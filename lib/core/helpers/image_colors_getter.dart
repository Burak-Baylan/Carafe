import 'dart:io';

import 'package:Carafe/app/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

class ImageColorsGetter {
  Future<Color> findSuitableColor(File image) async {
    Color? color;
    color = await darkMutedColor(image);
    if (color != null && color != AppColors.black) return color;
    color = await darkVibrantColor(image);
    if (color != null && color != AppColors.black) return color;
    color = await dominantColor(image);
    if (color != null && color != AppColors.black) return color;
    color = await lightMutedColor(image);
    if (color != null && color != AppColors.black) return color;
    color = await lightVibrantColor(image);
    if (color != null && color != AppColors.black) return color;
    color = await dominantColor(image);
    if (color != null && color != AppColors.black) return color;
    return AppColors.black;
  }

  Future<Color?> darkMutedColor(File image) async {
    var palette = await getPalette(image);
    return palette.darkMutedColor?.color;
  }

  Future<Color?> darkVibrantColor(File image) async {
    var palette = await getPalette(image);
    return palette.darkVibrantColor?.color;
  }

  Future<Color?> lightMutedColor(File image) async {
    var palette = await getPalette(image);
    return palette.lightMutedColor?.color;
  }

  Future<Color?> lightVibrantColor(File image) async {
    var palette = await getPalette(image);
    return palette.lightVibrantColor?.color;
  }

  Future<Color?> dominantColor(File image) async {
    var palette = await getPalette(image);
    return palette.dominantColor?.color;
  }

  Future<Color?> mutedColor(File image) async {
    var palette = await getPalette(image);
    return palette.mutedColor?.color;
  }

  Future<PaletteGenerator> getPalette(File image) async =>
      await PaletteGenerator.fromImageProvider(FileImage(image));
}

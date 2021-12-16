import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../../../../../core/extensions/color_extensions.dart';
import '../../../../../../../core/extensions/context_extensions.dart';
import '../../../../../../../core/extensions/string_extensions.dart';
import '../../../../../../../core/helpers/status_bar_helper.dart';
import '../../../../../../../core/widgets/full_screen_image.dart';
import 'home_page_full_screen_image_menu_button.dart';

class HomePageFullScreenImage extends StatefulWidget {
  HomePageFullScreenImage({
    Key? key,
    required this.imageProviders,
    required this.imageUrls,
    required this.imageIndex,
    required this.imagesDominantColor,
    this.onPageChanged,
  }) : super(key: key) {
    colorIndex = imageIndex;
  }

  List<ImageProvider<Object>?> imageProviders;
  List<dynamic> imageUrls;
  List<dynamic> imagesDominantColor;
  int imageIndex;
  Function(int index, CarouselPageChangedReason reason)? onPageChanged;
  int colorIndex = 0;

  @override
  State<HomePageFullScreenImage> createState() =>
      _HomePageFullScreenImageState();
}

class _HomePageFullScreenImageState extends State<HomePageFullScreenImage> {
  Color get imageDominantColor =>
      (widget.imagesDominantColor[widget.colorIndex] as String)
          .convertStringToColor;

  @override
  Widget build(BuildContext context) {
    imageDominantColor.changeStatusBarColor;
    return Scaffold(
      backgroundColor: imageDominantColor,
      body: _buildImageWidget,
    );
  }

  Widget get _buildImageWidget => CarouselSlider.builder(
        itemCount: widget.imageUrls.length,
        itemBuilder: (context, index, realIndex) => FullScreenImage(
          children: [_buildMoreButton],
          backgroundColor: imageDominantColor,
          tag: widget.imageUrls[index],
          image: widget.imageProviders[index],
        ),
        options: CarouselOptions(
          enlargeCenterPage: true,
          onPageChanged: (int index, CarouselPageChangedReason reason) =>
              changeIndex(index),
          viewportFraction: 1,
          height: context.height,
          enableInfiniteScroll: false,
          initialPage: widget.imageIndex,
          autoPlay: false,
        ),
      );

  Widget get _buildMoreButton =>
      Align(alignment: Alignment.topRight, child: _menuButton);

  Widget get _menuButton => HomePageFullScreenImageMenuButton(
      imageUrl: widget.imageUrls[widget.imageIndex]);

  changeIndex(int index) {
    StatusBarHelper.open();
    setState(() {
      widget.colorIndex = index;
    });
  }
}

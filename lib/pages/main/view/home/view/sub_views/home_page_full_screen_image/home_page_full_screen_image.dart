import 'package:carousel_slider/carousel_slider.dart';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../../../../../../core/extensions/color_extensions.dart';
import '../../../../../../../core/extensions/context_extensions.dart';
import '../../../../../../../core/extensions/int_extensions.dart';
import '../../../../../../../core/extensions/string_extensions.dart';
import '../../../../../../../core/widgets/full_screen_image.dart';
import '../../../../../../../core/widgets/small_button_for_full_size_images.dart';
import 'home_page_full_screen_image_menu_button.dart';
import 'view_model/home_page_full_screen_image_view_model.dart';

class HomePageFullScreenImage extends StatefulWidget {
  HomePageFullScreenImage({
    Key? key,
    required this.imageProviders,
    required this.imageUrls,
    required this.imageIndex,
    required this.imagesDominantColor,
    this.onPageChanged,
  }) : super(key: key);

  List<ImageProvider<Object>?> imageProviders;
  List<dynamic> imageUrls;
  List<dynamic> imagesDominantColor;
  int imageIndex;
  Function(int index, CarouselPageChangedReason reason)? onPageChanged;

  @override
  State<HomePageFullScreenImage> createState() =>
      _HomePageFullScreenImageState();
}

class _HomePageFullScreenImageState extends State<HomePageFullScreenImage> {
  @override
  Widget build(BuildContext context) {
    changeIndex(widget.imageIndex);
    return Scaffold(
      backgroundColor: imageDominantColor,
      body: _buildImageWidget,
    );
  }

  CarouselController controller = CarouselController();
  var fullScreenImageVm = HomePageFullScreenImageViewModel();
  final opacityDuration = 200.durationMilliseconds;

  Color get imageDominantColor =>
      (widget.imagesDominantColor[fullScreenImageVm.index] as String)
          .convertStringToColor;

  Widget get _buildImageWidget => Observer(
        builder: (_) => Container(
          color: fullScreenImageVm.color,
          child: Stack(
            children: [
              Align(alignment: Alignment.center, child: _carouselBuilder),
              Align(alignment: Alignment.topLeft, child: _buildBackButton),
              SafeArea(child: _buildMoreButton)
            ],
          ),
        ),
      );

  Widget get _carouselBuilder => Observer(
        builder: (context) => CarouselSlider.builder(
          itemCount: widget.imageUrls.length,
          itemBuilder: (context, index, realIndex) => _fullScreenImage(index),
          carouselController: controller,
          options: _carouselOptions,
        ),
      );

  Widget _fullScreenImage(int index) => Observer(
        builder: (_) => DismissiblePage(
          onDismiss: () => context.pop,
          direction: fullScreenImageVm.photoDismissDirection,
          backgroundColor: fullScreenImageVm.color,
          child: FullScreenImage(
            onImageTap: () => changeVisibility,
            scaleStateChangedCallback: (state) =>
                fullScreenImageVm.photoScaleStateChanged(state),
            disableBackButton: true,
            backgroundColor: fullScreenImageVm.color,
            tag: widget.imageUrls[index],
            image: widget.imageProviders[index],
          ),
        ),
      );

  CarouselOptions get _carouselOptions => CarouselOptions(
        scrollPhysics: fullScreenImageVm.sliderScrollPhysics,
        enlargeCenterPage: true,
        onPageChanged: (index, reason) => changeIndex(index),
        viewportFraction: 1,
        height: context.height,
        enableInfiniteScroll: false,
        initialPage: widget.imageIndex,
        autoPlay: false,
      );

  Widget get _buildBackButton => Observer(builder: (_) {
        imageDominantColor.withOpacity(0.5).changeBottomNavBarColor;
        return SafeArea(
          child: FullSizeImageSmallButton(
            opacity: fullScreenImageVm.visible ? 1 : 0,
            duration: opacityDuration,
            icon: Icons.chevron_left_sharp,
            onTap: () => context.pop,
          ),
        );
      });

  Widget get _buildMoreButton =>
      Align(alignment: Alignment.topRight, child: _menuButton);

  Widget get _menuButton => Observer(
        builder: (context) => AnimatedOpacity(
          duration: opacityDuration,
          opacity: fullScreenImageVm.visible ? 1 : 0,
          child: HomePageFullScreenImageMenuButton(
              imageUrl: widget.imageUrls[fullScreenImageVm.index]),
        ),
      );

  void get changeVisibility => fullScreenImageVm.changeVisiblity();

  changeIndex(int index) {
    fullScreenImageVm.changeIndex(index);
    imageDominantColor.changeStatusBarColor;
    fullScreenImageVm.setColor(imageDominantColor);
    imageDominantColor.withOpacity(0.5).changeBottomNavBarColor;
  }
}

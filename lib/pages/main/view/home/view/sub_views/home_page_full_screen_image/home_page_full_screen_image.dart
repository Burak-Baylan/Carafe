import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../../../../../../core/extensions/color_extensions.dart';
import '../../../../../../../core/extensions/context_extensions.dart';
import '../../../../../../../core/extensions/int_extensions.dart';
import '../../../../../../../core/extensions/string_extensions.dart';
import '../../../../../../../core/helpers/status_bar_helper.dart';
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
    required this.tag,
    this.onPageChanged,
  }) : super(key: key);

  List<ImageProvider<Object>?> imageProviders;
  List<dynamic> imageUrls;
  List<dynamic> imagesDominantColor;
  int imageIndex;
  Function(int index, CarouselPageChangedReason reason)? onPageChanged;
  String tag;

  @override
  State<HomePageFullScreenImage> createState() =>
      _HomePageFullScreenImageState();
}

class _HomePageFullScreenImageState extends State<HomePageFullScreenImage> {
  @override
  Widget build(BuildContext context) {
    _firstInit();
    return SafeArea(
      maintainBottomViewPadding: true,
      top: false,
      bottom: false,
      child: _buildImageWidget,
    );
  }

  CarouselController controller = CarouselController();
  var fullScreenImageVm = HomePageFullScreenImageViewModel();
  final opacityDuration = 200.durationMilliseconds;

  Color get imageDominantColor =>
      (widget.imagesDominantColor[fullScreenImageVm.index] as String)
          .convertStringToColor;

  Widget get _buildImageWidget => Observer(
        builder: (_) => AnimatedContainer(
          color: fullScreenImageVm.color,
          duration: 300.durationMilliseconds,
          child: Container(
            color: Colors.black.withOpacity(.3),
            child: buildStack,
          ),
        ),
      );

  Widget get buildStack {
    return Stack(
      children: [
        Align(alignment: Alignment.center, child: _carouselBuilder),
        Align(alignment: Alignment.topLeft, child: _buildBackButton),
        SafeArea(child: _buildMoreButton)
      ],
    );
  }

  Widget get _carouselBuilder => Observer(
        builder: (context) => CarouselSlider.builder(
          itemCount: widget.imageUrls.length,
          itemBuilder: (context, index, realIndex) => _fullScreenImage(index),
          carouselController: controller,
          options: _carouselOptions,
        ),
      );

  Widget _fullScreenImage(int index) => FullScreenImage(
        onImageTap: () => changeVisibility,
        disableBackButton: true,
        tag: widget.tag,
        image: widget.imageProviders[index],
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

  Widget get buildHomePageFullScreenImageMenuButton {
    return HomePageFullScreenImageMenuButton(
      imageUrl: widget.imageUrls[fullScreenImageVm.index],
    );
  }

  void get changeVisibility => fullScreenImageVm.changeVisiblity();

  void changeIndex(int index) {
    fullScreenImageVm.changeIndex(index);
    fullScreenImageVm.setColor(imageDominantColor);
  }

  void _firstInit() {
    if (fullScreenImageVm.firstInit) {
      changeIndex(widget.imageIndex);
      fullScreenImageVm.firstInit = false;
    }
  }

  @override
  void dispose() {
    StatusBarHelper.open();
    Colors.white.changeBottomNavBarColor;
    super.dispose();
  }
}

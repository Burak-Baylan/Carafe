import 'package:flutter/material.dart';

import '../../app/constants/app_constants.dart';
import '../extensions/color_extensions.dart';
import '../extensions/context_extensions.dart';
import '../extensions/int_extensions.dart';
import '../helpers/status_bar_helper.dart';
import 'small_button_for_full_size_images.dart';
import 'zoomable_image.dart';

class FullScreenImage extends StatefulWidget {
  FullScreenImage({
    Key? key,
    this.tag,
    this.image,
    this.children,
    this.imageWidget,
    this.onImageTap,
    this.backgroundColor,
  }) : super(key: key);

  String? tag = "";
  ImageProvider<Object>? image;
  Widget? imageWidget;
  List<Widget>? children;
  Function()? onImageTap;
  Color? backgroundColor;

  @override
  State<FullScreenImage> createState() => _FullScreenImageState();
}

class _FullScreenImageState extends State<FullScreenImage> {
  bool visible = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.height,
      width: context.width,
      color: widget.backgroundColor ?? AppColors.black,
      child: SafeArea(
        child: Hero(
          tag: widget.tag!,
          child: Stack(
            children: [
              Align(alignment: Alignment.center, child: _buildImage),
              _getWidgets,
            ],
          ),
        ),
      ),
    );
  }

  Widget get _getWidgets {
    List<Widget> widgets = [];
    widgets += <Widget>[
      Align(alignment: Alignment.topLeft, child: _buildBackButton),
    ];
    if (widget.children != null) {
      widgets += widget.children!;
    }
    return AnimatedOpacity(
      opacity: visible ? 1 : 0,
      duration: 300.durationMilliseconds,
      child: Stack(
        children: widgets,
      ),
    );
  }

  Widget get _buildImage => GestureDetector(
        onTap: () {
          if (widget.onImageTap != null) {
            widget.onImageTap!();
          }
          _changeVisibility();
        },
        child: widget.imageWidget ??
            ZoomableImage(
              image: widget.image!,
              backgroundColor: widget.backgroundColor,
            ),
      );

  _changeVisibility() {
    visible = !visible;
    if (visible) {
      StatusBarHelper.open();
    } else {
      StatusBarHelper.close();
    }
    setState(() {});
  }

  _closePage() => context.pop;

  Widget get _buildBackButton => FullSizeImageSmallButton(
        icon: Icons.chevron_left_sharp,
        onTap: () => _closePage(),
      );

  @override
  void initState() {
    super.initState();
    widget.backgroundColor != null
        ? widget.backgroundColor!.changeStatusBarColor
        : Colors.black.changeStatusBarColor;
  }

  @override
  void dispose() {
    StatusBarHelper.open();
    Colors.transparent.changeStatusBarColor;
    super.dispose();
  }
}

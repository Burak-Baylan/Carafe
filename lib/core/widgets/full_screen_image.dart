import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import '../extensions/color_extensions.dart';
import '../extensions/context_extensions.dart';
import '../extensions/int_extensions.dart';
import '../helpers/status_bar_helper.dart';
import 'photo_view_widget.dart';
import 'small_button_for_full_size_images.dart';

class FullScreenImage extends StatefulWidget {
  FullScreenImage({
    Key? key,
    this.tag,
    this.image,
    this.children,
    this.imageWidget,
    this.onImageTap,
    this.backgroundColor,
    this.height,
    this.width,
    this.disableBackButton = false,
    this.scaleStateChangedCallback,
  }) : super(key: key);

  String? tag = "";
  ImageProvider<Object>? image;
  Widget? imageWidget;
  List<Widget>? children;
  Function()? onImageTap;
  Color? backgroundColor;
  double? width;
  double? height;
  bool disableBackButton;
  void Function(PhotoViewScaleState)? scaleStateChangedCallback;

  @override
  State<FullScreenImage> createState() => _FullScreenImageState();
}

class _FullScreenImageState extends State<FullScreenImage> {
  bool visible = true;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(alignment: Alignment.center, child: _buildImage),
        _getWidgets,
      ],
  );
  }

  Widget get _getWidgets {
    List<Widget> widgets = [];
    if (!widget.disableBackButton) {
      var item = Align(alignment: Alignment.topLeft, child: _buildBackButton);
      widgets += <Widget>[item];
    }
    if (widget.children != null) {
      widgets += widget.children!;
    }
    return SafeArea(
      child: AnimatedOpacity(
        opacity: visible ? 1 : 0,
        duration: 300.durationMilliseconds,
        child: Stack(
          children: widgets,
        ),
      ),
    );
  }

  Widget get _buildImage => GestureDetector(
        onTap: () => onImageTap(),
        child: widget.imageWidget ?? photoView,
      );

  Widget get photoView => PhotoViewWidget(
        width: widget.width,
        height: widget.height,
        scaleStateChangedCallback: (state) =>
            widget.scaleStateChangedCallback != null
                ? widget.scaleStateChangedCallback!(state)
                : null,
        image: widget.image!,
        backgroundColor: widget.backgroundColor,
      );

  void _changeVisibility() {
    visible = !visible;
    if (visible) {
      StatusBarHelper.open();
      StatusBarHelper.edgeToEdgeScreen();
      Colors.transparent.changeBottomNavBarColor;
    } else {
      StatusBarHelper.close();
    }
  }

  void onImageTap() {
    if (widget.onImageTap != null) {
      widget.onImageTap!();
    }
    _changeVisibility();
  }

  void _closePage() => context.pop;

  Widget get _buildBackButton => FullSizeImageSmallButton(
        icon: Icons.chevron_left_sharp,
        onTap: () => _closePage(),
      );
}

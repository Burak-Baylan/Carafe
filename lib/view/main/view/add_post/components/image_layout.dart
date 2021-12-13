import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../core/base/view/base_view.dart';
import '../../../../../core/extensions/int_extensions.dart';
import '../../../../../core/init/navigation/navigator/navigator.dart';
import '../../../../../core/widgets/full_screen_image.dart';
import '../../../../../core/widgets/little_circle_button.dart';
import '../view_model/add_post_view_model.dart';

class AddPostImageLayout extends StatefulWidget {
  AddPostImageLayout({required this.index, required this.viewModel});

  int index;
  AddPostViewModel viewModel;

  @override
  State<AddPostImageLayout> createState() => _AddPostImageLayoutState();
}

class _AddPostImageLayoutState extends BaseView<AddPostImageLayout> {
  late ImageProvider<Object> _image;

  @override
  Widget build(BuildContext context) {
    _initializeValues();
    return Observer(
      builder: (_) => Container(
        width: 160,
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: _buildImage,
            ),
            Align(
              alignment: Alignment.topRight,
              child: _buildCloseButton,
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: _buildFullScreenButton,
            ),
          ],
        ),  
      ),
    );
  }

  Widget get _buildImage => Hero(
        tag: _image.toString(),
        child: GestureDetector(
          onTap: () => navigatoToFullScreenImage(),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: 15.radiusAll,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: _image,
              ),
            ),
          ),
        ),
      );

  Widget get _buildFullScreenButton => LittleCircleButton(
        onTap: () => navigatoToFullScreenImage(),
        icon: Icons.fullscreen_outlined,
        margin: const EdgeInsets.only(bottom: 5, right: 5),
      );

  Widget get _buildCloseButton => LittleCircleButton(
        onTap: () => widget.viewModel.deleteIndex(widget.index),
        icon: Icons.close_outlined,
        margin: const EdgeInsets.only(top: 5, right: 5),
      );

  navigatoToFullScreenImage() => PushToPage.instance
      .navigateToCustomPage(FullScreenImage(image: _image, tag: _image.toString()));

  scrollToLastItem() => widget.viewModel.scrollToLastItem();

  _initializeValues() {
    _image = FileImage(widget.viewModel.images[widget.index]!);
    afterBuild((_) => scrollToLastItem());
  }
}

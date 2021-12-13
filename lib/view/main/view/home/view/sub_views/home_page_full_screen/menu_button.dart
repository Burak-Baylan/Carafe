import 'package:Carafe/app/constants/app_constants.dart';
import 'package:Carafe/core/extensions/double_extensions.dart';
import 'package:Carafe/core/helpers/image_downloader.dart';
import 'package:Carafe/core/widgets/small_button_for_full_size_images.dart';
import 'package:flutter/material.dart';

class HomePageFullScreenImageMenuButton extends StatelessWidget {
  HomePageFullScreenImageMenuButton({
    Key? key,
    required this.imageUrl,
  }) : super(key: key);

  String imageUrl;

  @override
  Widget build(BuildContext context) {
    return _menuButton;
  }

  Widget get _menuButton {
    GlobalKey menuKey = GlobalKey();
    return Container(
      margin: 15.0.edgeIntesetsTopRight,
      child: Align(
        alignment: Alignment.topRight,
        child: Material(
          shape: const CircleBorder(),
          clipBehavior: Clip.hardEdge,
          color: Colors.transparent,
          child: PopupMenuButton<int>(
            key: menuKey,
            child: FullSizeImageSmallButton(
              margin: 0.0.edgeIntesetsAll,
              child: const Icon(
                Icons.more_vert_outlined,
                color: AppColors.white,
                size: 32,
              ),
              onTap: () {
                dynamic state = menuKey.currentState;
                state.showButtonMenu();
              },
            ),
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 1,
                child: Text(
                  "Save Photo",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
            onSelected: (value) async =>
                ImageDownloader.download(imageUrl),
            color: AppColors.secondary,
          ),
        ),
      ),
    );
  }
}

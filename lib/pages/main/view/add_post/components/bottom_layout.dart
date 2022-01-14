import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/extensions/context_extensions.dart';
import '../../../../../core/widgets/border_container.dart';
import '../view_model/add_post_view_model.dart';

class AddPostBottomLayout extends StatelessWidget {
  AddPostBottomLayout({
    required this.viewModel,
  });

  AddPostViewModel viewModel;
  late BuildContext _context;

  @override
  Widget build(BuildContext context) {
    _context = context;
    return BorderContainer(
      topLeft: 20,
      topRight: 20,
      color: Colors.white,
      child: Observer(
        builder: (_) => SizedBox(
          width: context.width,
          height: 50,
          child: Container(
            padding: const EdgeInsets.only(right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildIcons,
                _buildTextLengthCounter(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget get _buildIcons => IgnorePointer(
        ignoring: viewModel.screenLockState,
        child: IconButton(
          icon: const Icon(Icons.image_outlined),
          color: _context.colorScheme.secondary,
          iconSize: 25,
          onPressed: () async => await viewModel.pickImageAlertSelector,
        ),
      );

  Widget _buildTextLengthCounter(BuildContext context) => Stack(
        alignment: Alignment.center,
        children: [
          CircularProgressIndicator(
            value: viewModel.circularBarValue,
            backgroundColor: Colors.grey[300],
            valueColor:
                AlwaysStoppedAnimation<Color>(viewModel.progressBarColor),
          ),
          Text(
            viewModel.textLength.toString(),
            style: context.theme.textTheme.headline6
                ?.copyWith(color: viewModel.progressBarColor, fontSize: context.width / 26),
          ),
        ],
      );
}

import 'package:flutter/material.dart';
import '../../../../../../../../../core/extensions/int_extensions.dart';

class FullScreenPostBottomLayoutCountAndTextWidget extends StatelessWidget {
  FullScreenPostBottomLayoutCountAndTextWidget({
    Key? key,
    required this.onTap,
    required this.children,
  }) : super(key: key);

  void Function() onTap;
  List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Column(
        children: [
          10.sizedBoxOnlyHeight,
          Row(children: children),
          10.sizedBoxOnlyHeight,
        ],
      ),
    );
  }
}

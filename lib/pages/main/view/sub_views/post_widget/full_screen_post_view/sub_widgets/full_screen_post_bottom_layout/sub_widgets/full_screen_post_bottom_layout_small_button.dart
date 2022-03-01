import 'package:Carafe/core/extensions/int_extensions.dart';
import 'package:flutter/material.dart';
import '../../../../../../../../../core/extensions/context_extensions.dart';
import '../../../../../../../../../core/extensions/double_extensions.dart';

class FullScreenPostBottomLayoutSmallButton extends StatelessWidget {
  FullScreenPostBottomLayoutSmallButton({
    Key? key,
    required this.onTab,
    required this.icon,
    this.iconColor,
  }) : super(key: key);

  Function onTab;
  IconData icon;
  Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: 10.radiusAll,
      onTap: () => onTab(),
      child: Padding(
        padding: 3.0.edgeIntesetsAll,
        child: Icon(
          icon,
          size: context.width / 15,
          color: iconColor ?? context.theme.colorScheme.secondary,
        ),
      ),
    );
  }
}

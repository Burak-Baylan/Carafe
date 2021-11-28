import 'package:Carafe/core/widgets/border_container.dart';
import 'package:flutter/material.dart';

class LittleCircleButton extends StatelessWidget {
  LittleCircleButton({
    this.onTap,
    this.icon,
    this.opacity,
    this.margin = const EdgeInsets.only(bottom: 5, right: 5),
    this.padding = const EdgeInsets.all(5),
  });

  Function()? onTap;
  IconData? icon;
  double? opacity;
  EdgeInsetsGeometry? margin;
  EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return BorderContainer.all(
      margin: margin,
      padding: padding,
      radius: 100,
      color: Colors.black.withOpacity(opacity ?? 0.7),
      child: GestureDetector(
        onTap: onTap,
        child: Icon(
          icon,
          color: Colors.white,
          size: 18,
        ),
      ),
    );
  }
}

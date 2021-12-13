import 'package:Carafe/app/constants/app_constants.dart';
import 'package:Carafe/core/extensions/int_extensions.dart';
import 'package:Carafe/core/widgets/border_container.dart';
import 'package:flutter/material.dart';

class FullSizeImageSmallButton extends StatelessWidget {
  FullSizeImageSmallButton({
    Key? key,
    this.icon,
    this.iconColor = AppColors.white,
    this.iconSize = 32,
    this.onTap,
    this.opacity = 1,
    this.margin = const EdgeInsets.only(top: 15, left: 15),
    this.padding = const EdgeInsets.all(3),
    this.radius = 100,
    this.duration,
    this.backgroundColor,
    this.backgroundColorOpacity = 0.7,
    this.child,
  }) : super(key: key);

  final Function()? onTap;
  final double opacity;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final double? radius;
  final Duration? duration;
  final Color? backgroundColor;
  final double backgroundColorOpacity;
  final IconData? icon;
  final Color iconColor;
  final double iconSize;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: opacity,
      duration: duration ?? 300.durationMilliseconds,
      child: BorderContainer.all(
        margin: margin,
        padding: padding,
        radius: radius,
        color: backgroundColor != null
            ? backgroundColor!.withOpacity(backgroundColorOpacity)
            : Colors.black.withOpacity(backgroundColorOpacity),
        child: GestureDetector(
          onTap: () => onTap == null ? null : onTap!(),
          child: child ?? Icon(
            icon,
            color: iconColor,
            size: iconSize,
          ),
        ),
      ),
    );
  }
}

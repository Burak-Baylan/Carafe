import 'package:flutter/material.dart';

class BorderContainer extends StatelessWidget {
  double? topRight;
  double? topLeft;
  double? bottomRight;
  double? bottomLeft;
  EdgeInsetsGeometry? padding;
  Widget? child;
  Color? color;
  double? radius;

  BorderContainer({
    Key? key,
    required this.child,
    this.padding,
    this.topRight = 0,
    this.topLeft = 0,
    this.bottomRight = 0,
    this.bottomLeft = 0,
    this.color,
  }) : super(key: key);

  BorderContainer.all({
    Key? key,
    required this.child,
    required this.radius,
    this.padding,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      child: child,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.only(
          topRight:
              Radius.circular(topRight = radius == null ? topRight! : radius!),
          topLeft:
              Radius.circular(topLeft = radius == null ? topLeft! : radius!),
          bottomRight:
              Radius.circular(bottomRight = radius == null ? bottomRight! : radius!),
          bottomLeft:
              Radius.circular(bottomLeft = radius == null ? bottomLeft! : radius!),
        ),
      ),
    );
  }
}

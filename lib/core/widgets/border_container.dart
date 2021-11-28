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
  EdgeInsetsGeometry? margin;
  double? width;
  double? height;
  double elevation;
  Decoration? decoration;

  BorderContainer({
    Key? key,
    this.child,
    this.padding,
    this.topRight = 0,
    this.topLeft = 0,
    this.bottomRight = 0,
    this.bottomLeft = 0,
    this.color,
    this.margin,
    this.width,
    this.height,
    this.elevation = 0,
    this.decoration,
  }) : super(key: key);

  BorderContainer.all({
    Key? key,
    required this.radius,
    this.child,
    this.padding,
    this.color,
    this.margin,
    this.width,
    this.height,
    this.elevation = 0,
    this.decoration
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: decoration,
      margin: margin,
      child: Material(
        color: color,
        elevation: elevation,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topRight:
              Radius.circular(topRight = radius == null ? topRight! : radius!),
          topLeft:
              Radius.circular(topLeft = radius == null ? topLeft! : radius!),
          bottomRight: Radius.circular(
              bottomRight = radius == null ? bottomRight! : radius!),
          bottomLeft: Radius.circular(
              bottomLeft = radius == null ? bottomLeft! : radius!),
        )),
        child: Container(
          width: width,
          height: height,
          padding: padding,
          child: child,
        ),
      ),
    );
  }
}

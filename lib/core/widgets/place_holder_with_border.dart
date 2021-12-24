import 'package:Carafe/core/extensions/context_extensions.dart';
import 'package:Carafe/core/extensions/int_extensions.dart';
import 'package:flutter/material.dart';

class PlaceHolderWithBorder extends StatelessWidget {
  PlaceHolderWithBorder({
    Key? key,
    this.width,
    this.height,
    this.borderRadius = 4,
    this.color,
  }) : super(key: key);

  double? width;
  double? height;
  int borderRadius;
  Color? color;


  @override
  Widget build(BuildContext context) {
    _initializeValues(context);
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: borderRadius.borderRadiusCircular,
      ),
      width: width,
      height: height,
    );
  }

  _initializeValues(BuildContext context){
    width = width ?? context.width / 9;
    height = height ?? context.height / 70;
    color = color ?? Colors.grey[300];
  }
}

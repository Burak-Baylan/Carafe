import 'package:Carafe/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../extensions/double_extensions.dart';
import '../extensions/int_extensions.dart';

class BottomToTopAnimatedText extends StatelessWidget {
  BottomToTopAnimatedText({
    Key? key,
    required this.text,
    this.animate = true,
    this.fontSize = 12,
    this.color,
  }) : super(key: key);

  String text;
  bool animate;
  double fontSize;
  Color? color;

  String get randomId => const Uuid().v4();

  @override
  Widget build(BuildContext context) => AnimatedSwitcher(
        transitionBuilder: (child, animation) => animate
            ? this.animation(child, animation)
            : _buildText(text, context, fontSize: fontSize, color: color),
        duration: 200.durationMilliseconds,
        child: _buildText(text, context, fontSize: fontSize, color: color),
      );

  Widget _buildText(String text, BuildContext context,
          {double fontSize = 12, Color? color}) =>
      Text(
        text,
        key: ValueKey<String>(randomId),
        style: context.theme.textTheme.headline6?.copyWith(
          color: color ?? Colors.grey[700],
          fontSize: fontSize,
        ),
      );

  Widget animation(Widget child, Animation<double> animation) =>
      SlideTransition(
        child: child,
        position: Tween<Offset>(begin: 1.0.offsetY, end: 0.0.offsetXY)
            .animate(animation),
      );
}

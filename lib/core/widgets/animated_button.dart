import 'package:Carafe/core/extensions/int_extensions.dart';
import 'package:flutter/material.dart';

import '../extensions/context_extensions.dart';

class AnimatedButton extends StatefulWidget {
  AnimatedButton(
      {Key? key,
      required this.onPressed,
      this.child,
      this.onEnd,
      this.style,
      this.onSuccessIcon = Icons.done,
      this.onErrorIcon = Icons.error_outline,
      this.text})
      : super(key: key);

  Function onPressed;
  Function? onEnd;
  Widget? child;
  ButtonStyle? style;
  IconData onSuccessIcon;
  IconData onErrorIcon;
  String? text;

  @override
  State<AnimatedButton> createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton> {
  ButtonState _state = ButtonState.init;
  late bool _isInit;
  bool _isAnimating = true;

  @override
  Widget build(BuildContext context) {
    _initValues();
    return AnimatedContainer(
      width: _state == ButtonState.init ? context.width : 42,
      onEnd: () => setState(() => _isAnimating = !_isAnimating),
      duration: 200.durationMilliseconds,
      child: _isInit ? _button : _buildLoadingButton(),
    );
  }

  ElevatedButton get _button => ElevatedButton(
        style: widget.style ?? _buttonStyle(context),
        child: FittedBox(
          child: widget.child ??
              Text(
                widget.text ?? "Press",
                style: context.theme.textTheme.headline6?.copyWith(
                  color: Colors.white,
                  fontSize: context.width / 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
        ),
        onPressed: () => _onPressed(),
      );

  ButtonStyle _buttonStyle(BuildContext context) => ElevatedButton.styleFrom(
      shape: const StadiumBorder(), fixedSize: Size(context.width, 42));

  Widget _buildLoadingButton() {
    final Color color = context.colorScheme.secondaryVariant;

    return Container(
      width: 42,
      height: 42,
      padding: context.lowPadding,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
      child: const Center(
        child: FittedBox(
          child: CircularProgressIndicator(color: Colors.white),
        ),
      ),
    );
  }

  _initValues() {
    _isInit = _isAnimating || _state == ButtonState.init;
  }

  _onPressed() async {
    setState(() => _state = ButtonState.loading);
    try {
      await widget.onPressed();
    } catch (e) {
      setState(() => _state = ButtonState.init);
      print("ERROR FROM ANIMATED BUTTON _ONPRESSED_ $e");
    }
    setState(() => _state = ButtonState.init);
    if (widget.onEnd != null) {
      widget.onEnd!();
    }
  }
}

enum ButtonState { init, loading }

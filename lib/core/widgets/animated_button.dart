import 'package:Carafe/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class AnimatedButton extends StatefulWidget {
  AnimatedButton({
    Key? key,
    required this.child,
    required this.onPressed,
    this.onEnd,
    this.style,
    this.onSuccessIcon = Icons.done,
    this.onErrorIcon = Icons.error_outline,
  }) : super(key: key);

  Function onPressed;
  Function? onEnd;
  Widget child;
  ButtonStyle? style;
  IconData onSuccessIcon;
  IconData onErrorIcon;
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
      duration: context.duration200ms,
      child: _isInit ? _button : _buildSmallButton(),
    );
  }

  _initValues() {
    _isInit = _isAnimating || _state == ButtonState.init;
  }

  ElevatedButton get _button => ElevatedButton(
        style: widget.style ?? _buttonStyle(context),
        child: FittedBox(child: widget.child),
        onPressed: () => _onPressed(),
      );

  _onPressed() async {
    setState(() => _state = ButtonState.loading);
    await widget.onPressed();
    setState(() => _state = ButtonState.init);
    if (widget.onEnd != null) {
      widget.onEnd!();
    }
  }

  ButtonStyle _buttonStyle(BuildContext context) => ElevatedButton.styleFrom(
      shape: const StadiumBorder(), fixedSize: Size(context.width, 42));

  Widget _buildSmallButton() {

    final Color color = context.colorScheme.secondaryVariant;

    return Container(
      width: 42,
      height: 42,
      padding: context.lowPadding,
      decoration: BoxDecoration(
          shape: BoxShape.circle, color: color),
      child: const Center(
        child: CircularProgressIndicator(color: Colors.white),
      ),
    );
  }

}

enum ButtonState { init, loading}

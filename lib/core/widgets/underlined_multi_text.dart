import 'package:flutter/material.dart';
import 'package:Carafe/core/extensions/context_extensions.dart';

class UnderlinedMultiText extends StatelessWidget {
  UnderlinedMultiText({
    Key? key,
    required this.texts,
    this.decorateThose,
    this.decoration,
  }) : super(key: key);

  final List<String> texts;
  final List<int>? decorateThose;
  final TextDecoration? decoration;

  List<TextSpan> _textSpanList = [];

  final String _lengthErrorMessage =
      "The 'DecorateThose' length can't be greater than 'Texts' length.";

  late BuildContext context;

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return RichText(
      text: TextSpan(
        children: _execute(),
      ),
    );
  }

  List<TextSpan> _execute() {
    String? message = _compare();
    if (message != null) return <TextSpan>[_errorSpan(message)];
    _convertToTextSpan();
    return _textSpanList;
  }

  String? _compare() {
    if (decorateThose == null) return null;
    if (decorateThose!.length > texts.length) return _lengthErrorMessage;
  }

  _convertToTextSpan() {
    for (var i = 0; i < texts.length; i++) {
      _textSpanList.add(
        _buildTextSpan(
          text: texts[i],
          textColor: Colors.black,
        ),
      );
    }
    for (var i = 0; i < texts.length - 1; i++) {
      _decorate(i - 1, texts[i]);
    }
  }

  TextDecoration? _decorate(int index, String text) {
    if (decorateThose!.length - 1 <= index) {
      _textSpanList[decorateThose![index]] = _buildTextSpan(
        text: text,
        decoration: decoration,
        textColor: Colors.black,
      );
      return decoration;
    }
    return null;
  }

  TextSpan _buildTextSpan({
    required String text,
    TextDecoration? decoration,
    Color? textColor,
  }) {
    return TextSpan(
      text: text,
      style: TextStyle(decoration: decoration, color: textColor),
    );
  }

  TextSpan _errorSpan(String message) => _buildTextSpan(
        text: message,
        decoration: null,
        textColor: context.colorScheme.error,
      );
}

import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  ThemeData get theme => Theme.of(this);
  ColorScheme get colorScheme => theme.colorScheme;
}

extension ValueExtension on BuildContext {
  double get ultraLowValue => height * 0.005;
  double get lowValue => height * 0.01;
  double get normalValue => height * 0.02;
  double get mediumValue => height * 0.04;
  double get highValue => height * 0.1;
}

extension MediaQueryExtension on BuildContext {
  double get height => mediaQuery.size.height;
  double get width => mediaQuery.size.width;
}

extension PaddingExtension on BuildContext {
  EdgeInsets get ultraLowPadding => EdgeInsets.all(ultraLowValue);
  EdgeInsets get lowPadding => EdgeInsets.all(lowValue);
  EdgeInsets get normalPadding => EdgeInsets.all(normalValue);
  EdgeInsets get mediumPadding => EdgeInsets.all(mediumValue);
  EdgeInsets get highPadding => EdgeInsets.all(highValue);
}

extension PaddingAll on BuildContext {
  EdgeInsets get paddingLowVertical => EdgeInsets.symmetric(vertical: lowValue);
  EdgeInsets get paddingNormalVertical =>
      EdgeInsets.symmetric(vertical: normalValue);
  EdgeInsets get paddingMediumVertical =>
      EdgeInsets.symmetric(vertical: mediumValue);
  EdgeInsets get paddingHighVertical =>
      EdgeInsets.symmetric(vertical: highValue);

  EdgeInsets get paddingLowHorizontal =>
      EdgeInsets.symmetric(horizontal: lowValue);
  EdgeInsets get paddingNormalHorizontal =>
      EdgeInsets.symmetric(horizontal: normalValue);
  EdgeInsets get paddingMediumHorizontal =>
      EdgeInsets.symmetric(horizontal: mediumValue);
  EdgeInsets get paddingHighHorizontal =>
      EdgeInsets.symmetric(horizontal: highValue);
}

extension DurationExtension on BuildContext {
  Duration get duration100ms => const Duration(milliseconds: 100);
  Duration get duration200ms => const Duration(milliseconds: 200);
  Duration get duration300ms => const Duration(milliseconds: 300);
  Duration get duration2000ms => const Duration(milliseconds: 2000);
}

extension TextStyleExtensions on BuildContext {
  TextStyle get underlinedText =>
      const TextStyle(decoration: TextDecoration.underline);
}

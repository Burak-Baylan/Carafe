import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../app/constants/app_constants.dart';
import '../extensions/context_extensions.dart';
import 'border_container.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField({
    Key? key,
    required this.controller,
    this.labelText,
    this.icon,
    this.keyboardType = TextInputType.name,
    this.validator,
    this.obscureText = false,
    this.readOnly = false,
    this.hintText,
    this.focusNode,
    this.iconContainerColor,
    this.iconColor,
    this.leading,
    this.inputBorder,
    this.autoFocus = false,
    this.backgroundColor,
    this.maxLines,
    this.disableLeading = false,
    this.minLines,
    this.onTextChanged,
    this.fontSize,
    this.maxLength,
    this.hideCounterText,
  }) : super(key: key);

  final TextInputType? keyboardType;
  final TextEditingController controller;
  final String? labelText;
  final IconData? icon;
  final bool readOnly;
  final String? Function(String?)? validator;
  final String? hintText;
  final FocusNode? focusNode;
  final Color? iconContainerColor;
  final Color? iconColor;
  final Widget? leading;
  final InputBorder? inputBorder;
  final bool autoFocus;
  final Color? backgroundColor;
  final int? maxLines;
  final int? minLines;
  final bool disableLeading;
  final Function(String text)? onTextChanged;
  final double? fontSize;
  final int? maxLength;
  final bool? hideCounterText;
  bool obscureText;

  late BuildContext context;

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return BorderContainer.all(
      margin: _margin,
      padding: _padding,
      radius: context.lowValue,
      color: backgroundColor ?? AppColors.white,
      child: _formField,
    );
  }

  TextFormField get _formField => TextFormField(
        maxLength: maxLength,
        onChanged: (text) =>
            onTextChanged != null ? onTextChanged!(text) : null,
        minLines: minLines ?? 1,
        maxLines: maxLines ?? 1,
        autofocus: autoFocus,
        keyboardType: keyboardType,
        focusNode: focusNode,
        validator: validator,
        readOnly: readOnly,
        controller: controller,
        obscureText: obscureText,
        decoration: _buildInputDecoration(
          text: labelText,
          icon: icon,
        ),
        style: _textStyle,
      );

  InputDecoration _buildInputDecoration({
    required String? text,
    required IconData? icon,
  }) {
    return InputDecoration(
      counterText: hideCounterText == true ? "" : null,
      border: inputBorder,
      errorMaxLines: 3,
      labelStyle: TextStyle(
        color: context.colorScheme.primary,
      ),
      labelText: text,
      hintText: hintText,
      icon: disableLeading == false
          ? leading ?? _buildIconWithBorder(icon)
          : null,
    );
  }

  BorderContainer _buildIconWithBorder(IconData? icon) {
    return BorderContainer.all(
      padding: context.ultraLowPadding,
      radius: 5,
      color: iconContainerColor,
      child: Icon(
        icon,
        color: iconColor ?? context.colorScheme.primary,
      ),
    );
  }

  TextStyle get _textStyle => GoogleFonts.firaSans(
        fontSize: fontSize ?? 18,
        color: AppColors.secondary,
      );

  EdgeInsets get _margin => EdgeInsets.only(bottom: context.lowValue);

  EdgeInsets get _padding => EdgeInsets.symmetric(
      vertical: context.ultraLowValue, horizontal: context.lowValue);
}

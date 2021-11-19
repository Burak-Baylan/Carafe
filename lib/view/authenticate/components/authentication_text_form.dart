import 'package:flutter/material.dart';

import '../../../app/constants/constants_colors.dart';
import '../../../core/extensions/context_extensions.dart';
import '../../../core/widgets/border_container.dart';

class AuthTextFormField extends StatelessWidget {
  AuthTextFormField({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.icon,
    this.keyboardType = TextInputType.name,
    this.validator,
    this.obscureText = false,
    this.readOnly = false,
    this.hintText,
    this.focusNode,
  }) : super(key: key);

  final TextInputType? keyboardType;
  final TextEditingController controller;
  final String labelText;
  final IconData icon;
  final bool readOnly;
  final String? Function(String?)? validator;
  final String? hintText;
  final FocusNode? focusNode;
  bool obscureText;

  late BuildContext context;

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return BorderContainer.all(
      margin: _margin,
      padding: _padding,
      radius: context.lowValue,
      color: AppColors.white,
      child: _formField,
    );
  }

  TextFormField get _formField => TextFormField(
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
    required String text,
    required IconData icon,
  }) {
    return InputDecoration(
      errorMaxLines: 3,
      labelStyle: TextStyle(
        color: context.colorScheme.primary,
      ),
      labelText: text,
      hintText: hintText,
      icon: _buildIconWithBorder(icon),
    );
  }

  BorderContainer _buildIconWithBorder(IconData icon) {
    return BorderContainer.all(
      padding: context.ultraLowPadding,
      radius: 5,
      color: context.colorScheme.primary,
      child: Icon(
        icon,
        color: Colors.white,
      ),
    );
  }

  TextStyle get _textStyle => TextStyle(color: AppColors.secondary);

  EdgeInsets get _margin => EdgeInsets.only(bottom: context.lowValue);

  EdgeInsets get _padding => EdgeInsets.symmetric(
      vertical: context.ultraLowValue, horizontal: context.lowValue);
}

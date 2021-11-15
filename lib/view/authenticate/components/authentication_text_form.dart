import 'package:flutter/material.dart';
import 'package:Carafe/core/extensions/context_extensions.dart';
import 'package:Carafe/core/widgets/border_container.dart';

class AuthTextFormField extends StatelessWidget {
  AuthTextFormField({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.icon,
    this.obscureText = false,
  }) : super(key: key);

  final TextEditingController controller;
  final String labelText;
  final IconData icon;
  bool obscureText;

  late BuildContext context;

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: _buildInputDecoration(
        text: labelText,
        icon: icon,
      ),
    );
  }

  InputDecoration _buildInputDecoration({
    required String text,
    required IconData icon,
  }) {
    return InputDecoration(
      labelStyle: TextStyle(
        color: context.colorScheme.primary,
      ),
      labelText: text,
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
}

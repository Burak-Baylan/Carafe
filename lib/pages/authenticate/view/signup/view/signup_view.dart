// ignore_for_file: prefer_const_constructors

import 'package:Carafe/core/extensions/context_extensions.dart';
import 'package:Carafe/core/extensions/string_extensions.dart';
import 'package:Carafe/core/widgets/animated_button.dart';
import 'package:Carafe/core/widgets/custom_text_form.dart';
import 'package:Carafe/pages/authenticate/view/signup/view_model/sginup_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class SignupView extends StatefulWidget {
  SignupView({Key? key}) : super(key: key);

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final SignupViewModel _signupVm = SignupViewModel();

  @override
  Widget build(BuildContext context) {
    _signupVm.setContext(context);
    return Scaffold(
      backgroundColor: context.colorScheme.background,
      body: Padding(
        padding: context.paddingNormalHorizontal,
        child: Form(
          key: _signupVm.formKey,
          child: Column(
            children: [
              const Spacer(flex: 2),
              _usernameFormField,
              _emailFormField,
              _passwordFormFiled,
              const Spacer(flex: 6),
              _buildSignupButton,
              const Spacer(),
              _buildHaveAccountText,
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget get _usernameFormField => Observer(
        builder: (_) => CustomTextFormField(
          validator: (text) => _signupVm.usernameValidator(text),
          focusNode: _signupVm.usernameFocusNode,
          controller: _signupVm.usernameController,
          labelText: "Username",
          icon: Icons.person_outline,
          readOnly: _signupVm.usernameLock,
        ),
      );

  Widget get _emailFormField => Observer(
        builder: (_) => CustomTextFormField(
          keyboardType: TextInputType.emailAddress,
          focusNode: _signupVm.emailFocusNode,
          validator: (text) => text?.emailValidator,
          controller: _signupVm.emailController,
          labelText: "E-Mail",
          icon: Icons.email_outlined,
          readOnly: _signupVm.emailLock,
        ),
      );

  Widget get _passwordFormFiled => Observer(
        builder: (_) => CustomTextFormField(
          focusNode: _signupVm.passwordFocusNode,
          validator: (text) => text?.passwordValidator,
          controller: _signupVm.passworController,
          labelText: "Password",
          obscureText: true,
          icon: Icons.lock_outline_rounded,
          readOnly: _signupVm.passwordLock,
        ),
      );

  Widget get _buildSignupButton => Observer(
        builder: (_) => AnimatedButton(
          onPressed: () => _signupVm.signupControl(_signupVm),
          text: "Signup",
        ),
      );

  Widget get _buildHaveAccountText => Observer(
        builder: (_) => GestureDetector(
          onTap: () =>
              _signupVm.changeTabIndex(_signupVm.authVm.loginPageIndex),
          child: RichText(
            text: TextSpan(
              style: context.theme.textTheme.headline6,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                TextSpan(text: "Have an account? "),
                TextSpan(
                  text: "Login",
                  style: context.underlinedText,
                ),
              ],
            ),
          ),
        ),
      );
}

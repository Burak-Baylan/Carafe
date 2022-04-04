import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../core/extensions/context_extensions.dart';
import '../../../../../core/extensions/string_extensions.dart';
import '../../../../../core/init/navigation/navigator/navigator.dart';
import '../../../../../core/widgets/animated_button.dart';
import '../../../components/authentication_button.dart';
import '../../../../../core/widgets/custom_text_form.dart';
import '../view_model/login_view_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginViewModel _loginVm = LoginViewModel();

  @override
  Widget build(BuildContext context) {
    _loginVm.setContext(context);
    return Scaffold(
      backgroundColor: context.colorScheme.background,
      body: Padding(
        padding: context.paddingNormalHorizontal,
        child: Form(
          key: _loginVm.formKey,
          child: Column(
            children: [
              const Spacer(flex: 2),
              _emailFormField,
              _passwordFormField,
              const Spacer(),
              _buildForgotPasswordText,
              const Spacer(flex: 6),
              _buildLoginButton,
              const Spacer(),
              _buildDontAccountText,
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget get _buildDontAccountText => GestureDetector(
        onTap: () => _loginVm.changeTabIndex(_loginVm.authVm.signupPageIndex),
        child: RichText(
          text: TextSpan(
            style: context.theme.textTheme.headline6
                  ?.copyWith(color: context.colorScheme.secondary),
            children: [
              const TextSpan(text: "Don't have an account? "),
              TextSpan(
                text: "Signup",
                style: context.underlinedText,
              ),
            ],
          ),
        ),
      );

  Widget get _emailFormField => Observer(
        builder: (_) => CustomTextFormField(
          keyboardType: TextInputType.emailAddress,
          focusNode: _loginVm.emailFocusNode,
          validator: (text) => text?.emailValidator,
          readOnly: _loginVm.emailTextInputLock,
          controller: _loginVm.emailController,
          labelText: "E-Mail",
          icon: Icons.email_outlined,
        ),
      );

  Widget get _passwordFormField => Observer(
        builder: (_) => CustomTextFormField(
          focusNode: _loginVm.passwordFocusNode,
          validator: (text) => text?.passwordValidator,
          readOnly: _loginVm.passwordTextInputLock,
          controller: _loginVm.passworController,
          labelText: "Password",
          obscureText: true,
          icon: Icons.lock_outline_rounded,
        ),
      );

  Widget get _buildLoginButton => AnimatedButton(
        onPressed: () => _loginVm.loginControl(),
        text: "Login to app",
      );

  GestureDetector get _buildForgotPasswordText => GestureDetector(
        onTap: () => _loginVm.navigateToForgorPasswordPage(),
        child: Padding(
          padding:
              EdgeInsets.only(right: context.lowValue, top: context.lowValue),
          child: Align(
            child: Text(
              "Forgot Password?",
              style: context.theme.textTheme.subtitle2
                  ?.copyWith(fontSize: context.width / 25),
            ),
            alignment: Alignment.centerRight,
          ),
        ),
      );
}

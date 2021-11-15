import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:Carafe/core/extensions/context_extensions.dart';
import 'package:Carafe/view/authenticate/components/authentication_text_form.dart';
import 'package:Carafe/view/authenticate/components/authentication_button.dart';
import 'package:Carafe/view/authenticate/view/login/view_model/login_view_model.dart';
import 'package:Carafe/view/authenticate/view_model/authenticate_view_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginViewModel _loginVm = LoginViewModel();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => Scaffold(
        backgroundColor: Color(0xfff1f3f8),
        body: Padding(
          padding: context.paddingNormalHorizontal,
          child: Column(
            children: [
              Spacer(flex: 2),
              _emailFormField,
              _passwordFormFiled,
              Spacer(),
              _buildForgotPasswordText,
              Spacer(flex: 6),
              _buildLoginButton,
              Spacer(),
              _buildDontAccountText,
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  GestureDetector get _buildDontAccountText => GestureDetector(
        onTap: () => {_loginVm.changeTabIndex(_loginVm.authVm.signupPageIndex)},
        child: RichText(
          text: const TextSpan(
            style: TextStyle(color: Colors.black),
            children: [
              TextSpan(text: "Don't have an account? "),
              TextSpan(
                text: "Signup",
                style: TextStyle(
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
        ),
      );

  AuthTextFormField get _emailFormField => AuthTextFormField(
        controller: _loginVm.emailController,
        labelText: "E-Mail",
        icon: Icons.email_outlined,
      );

  AuthTextFormField get _passwordFormFiled => AuthTextFormField(
        controller: _loginVm.passworController,
        labelText: "Password",
        obscureText: true,
        icon: Icons.lock_outline_rounded,
      );

  AuthenticationButton get _buildLoginButton => AuthenticationButton(
        text: "Login to app",
        onPressed: () {},
      );

  Padding get _buildForgotPasswordText => Padding(
        padding:
            EdgeInsets.only(right: context.lowValue, top: context.lowValue),
        child: const Align(
          child: Text("Forgot Password?"),
          alignment: Alignment.centerRight,
        ),
      );
}

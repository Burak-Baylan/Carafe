import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:Carafe/core/extensions/context_extensions.dart';
import 'package:Carafe/view/authenticate/components/authentication_text_form.dart';
import 'package:Carafe/view/authenticate/components/authentication_button.dart';
import 'package:Carafe/view/authenticate/view/signup/view_model/sginup_view_model.dart';

class SignupView extends StatelessWidget {
  SignupView({Key? key}) : super(key: key);

  final SignupViewModel _signupViewModel = SignupViewModel();

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
              _usernameFormField,
              _emailFormField,
              _passwordFormFiled,
              Spacer(flex: 6),
              _buildLoginButton,
              Spacer(),
              _buildHaveAccountText,
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  AuthTextFormField get _usernameFormField => AuthTextFormField(
        controller: _signupViewModel.usernameController,
        labelText: "Username",
        icon: Icons.person_outline,
      );

  AuthTextFormField get _emailFormField => AuthTextFormField(
        controller: _signupViewModel.emailController,
        labelText: "E-Mail",
        icon: Icons.email_outlined,
      );

  AuthTextFormField get _passwordFormFiled => AuthTextFormField(
        controller: _signupViewModel.passworController,
        labelText: "Password",
        obscureText: true,
        icon: Icons.lock_outline_rounded,
      );

  AuthenticationButton get _buildLoginButton => AuthenticationButton(
        text: "Signup",
        onPressed: () {},
      );

    GestureDetector get _buildHaveAccountText => GestureDetector(
        onTap: () => {_signupViewModel.changeTabIndex(_signupViewModel.authVm.loginPageIndex)},
        child: RichText(
          text: const TextSpan(
            style: TextStyle(color: Colors.black),
            children: [
              TextSpan(text: "Have account? "),
              TextSpan(
                text: "Login",
                style: TextStyle(
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
        ),
      );
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/constants/svg/svg_constants.dart';
import '../../../../../core/extensions/context_extensions.dart';
import '../../../../../core/extensions/int_extensions.dart';
import '../../../../../core/extensions/string_extensions.dart';
import '../../../../../core/widgets/animated_button.dart';
import '../../../../../core/widgets/custom_text_form.dart';
import '../view_model/forgot_password_view_model.dart';

class ForgotPasswordView extends StatelessWidget {
  ForgotPasswordView({Key? key}) : super(key: key);

  late BuildContext context;
  ForgotPasswordViewModel forgotPassworVm = ForgotPasswordViewModel();

  @override
  Widget build(BuildContext context) {
    this.context = context;
    forgotPassworVm.setContext(context);
    return Scaffold(
      backgroundColor: context.colorScheme.background,
      appBar: _appBar,
      body: _body,
    );
  }

  Widget get _body => Padding(
        padding: context.lowPadding,
        child: Form(
          key: forgotPassworVm.formKey,
          child: Column(
            children: [
              _image,
              SizedBox(height: context.lowValue),
              _titleText,
              SizedBox(height: context.height * 0.01),
              _detailText,
              const Spacer(flex: 2),
              _emailTextInput,
              const Spacer(flex: 2),
              _sendButton,
              SizedBox(height: context.normalValue),
            ],
          ),
        ),
      );

  AnimatedButton get _sendButton => AnimatedButton(
      onPressed: () => forgotPassworVm.sendPasswordResetMail(), text: "Send");

  Text get _detailText => Text(
        "Enter your current account email and click the link in your mailbox to create your new password.",
        style: context.theme.textTheme.headline6?.copyWith(
            fontSize: context.width / 25, color: context.colorScheme.primary),
        textAlign: TextAlign.center,
      );

  Text get _titleText => Text(
        "Forgot Your\nPassword?",
        style: context.theme.textTheme.headline6?.copyWith(
          fontSize: context.width / 10,
          color: context.colorScheme.secondary,
        ),
        textAlign: TextAlign.center,
      );

  CustomTextFormField get _emailTextInput => CustomTextFormField(
      focusNode: forgotPassworVm.emailFocusNode,
      validator: (text) => text?.emailValidator,
      controller: forgotPassworVm.emailController,
      labelText: "E-Mail",
      icon: Icons.email_outlined,
      keyboardType: TextInputType.emailAddress,
      hintText: "Enter your current email");

  Align get _image => Align(
        alignment: Alignment.topCenter,
        child: AnimatedContainer(
          duration: 100.durationMilliseconds,
          height: context.mediaQuery.viewInsets.bottom > 0
              ? 0
              : context.height * 0.25,
          child: Center(
            child: SvgPicture.asset(SVGConstants.instance.forgotPassword),
          ),
        ),
      );

  AppBar get _appBar => AppBar(
        centerTitle: true,
        title: Text(
          "Forgot Password",
          style: context.theme.textTheme.headline6?.copyWith(
            fontSize: context.width / 25,
            color: Colors.white,
          ),
        ),
      );
}

import 'package:Carafe/core/extensions/string_extensions.dart';
import 'package:Carafe/core/widgets/animated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/constants/svg/svg_constants.dart';
import '../../../../../core/extensions/context_extensions.dart';
import '../../../components/authentication_text_form.dart';
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
        style: GoogleFonts.firaSans(
            fontSize: 14, color: context.colorScheme.primary),
        textAlign: TextAlign.center,
      );

  Text get _titleText => Text(
        "Forgot Your\nPassword?",
        style: GoogleFonts.firaSans(
            fontSize: 30, color: context.colorScheme.secondary),
        textAlign: TextAlign.center,
      );

  AuthTextFormField get _emailTextInput => AuthTextFormField(
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
          duration: context.duration100ms,
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
        title: Text("Forgot Password"),
      );
}

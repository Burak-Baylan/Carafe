import 'package:flutter/material.dart';
import '../../../../../core/extensions/context_extensions.dart';
import '../../../../../core/extensions/double_extensions.dart';
import '../../../../../core/extensions/int_extensions.dart';
import '../../../../../core/helpers/rounded_bottom_sheet.dart';
import '../../../../../core/widgets/bottom_sheet_top_rounded_container.dart';
import '../view_model/verification_request_sender_view_model.dart';

class VerificationRequestBottomSheet {
  static void show(BuildContext context) =>
      VerificationRequestBottomSheet().showSheet(context);

  VerificationSenderViewModel verificationSenderVm =
      VerificationSenderViewModel();

  late BuildContext context;

  void initiailizeValues() {
    verificationSenderVm.setContext(context);
  }

  void showSheet(BuildContext context) {
    this.context = context;
    initiailizeValues();
    showRoundedBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Container(
          margin: const EdgeInsets.only(top: 15, left: 15, right: 15),
          padding: context.mediaQuery.viewInsets,
          child: Wrap(
            children: [
              Column(
                children: [
                  const BottomSheetTopRoundedContainer(),
                  15.0.sizedBoxOnlyHeight,
                  buildInfoText,
                  buildDescritionText,
                  buildSendButon,
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget get buildInfoText {
    return Container(
      margin: 15.0.edgeIntesetsAll,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'You are sending a verification request.',
          style: context.theme.textTheme.headline6?.copyWith(
            color: context.colorScheme.primary,
            fontSize: context.width / 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget get buildDescritionText {
    return Container(
      margin: 15.0.edgeIntesetsRightLeft,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'We will contact you shortly with your account email.',
          style: context.theme.textTheme.headline6?.copyWith(
            color: context.colorScheme.secondary,
            fontSize: context.width / 26,
          ),
        ),
      ),
    );
  }

  Widget get buildSendButon {
    return Padding(
      padding: 15.0.edgeIntesetsAll,
      child: Align(
        alignment: Alignment.centerRight,
        child: TextButton(
          onPressed: () => verificationSenderVm.sendVerificationRequest(),
          child: SizedBox(width: context.width, child: getButtonText),
          style: getButtonStyle,
        ),
      ),
    );
  }

  Text get getButtonText => Text(
        'Send',
        textAlign: TextAlign.center,
        style: context.theme.textTheme.headline6?.copyWith(
          fontSize: context.width / 25,
          color: context.colorScheme.primary,
          fontWeight: FontWeight.bold,
        ),
      );

  ButtonStyle get getButtonStyle => TextButton.styleFrom(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: context.colorScheme.primary,
            width: 1,
            style: BorderStyle.solid,
          ),
          borderRadius: 50.radiusAll,
        ),
      );
}

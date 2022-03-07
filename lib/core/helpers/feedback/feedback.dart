import 'package:flutter/material.dart';
import '../../extensions/context_extensions.dart';
import '../../extensions/double_extensions.dart';
import '../../extensions/int_extensions.dart';
import '../../widgets/bottom_sheet_top_rounded_container.dart';
import '../../widgets/custom_text_form.dart';
import '../rounded_bottom_sheet.dart';
import 'view_model/feedback_view_model.dart';

class SendFeedback {
  static void show(BuildContext context) => SendFeedback().showSheet(context);

  late BuildContext context;
  FeedbackViewModel feedbackVm = FeedbackViewModel();

  void initiailizeValues() {
    feedbackVm.setContext(context);
  }

  void showSheet(BuildContext context) {
    this.context = context;
    initiailizeValues();
    showRoundedBottomSheet(
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
                  buildTextFormField,
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
          'What do you want to fix?',
          style: context.theme.textTheme.headline6?.copyWith(
            color: context.colorScheme.primary,
            fontSize: context.width / 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget get buildTextFormField => Container(
        margin: 6.0.edgeIntesetsOnlyRight,
        child: CustomTextFormField(
          controller: feedbackVm.feedbackTextController,
          fontSize: context.width / 28,
          icon: Icons.description_outlined,
          labelText: 'Your Feedback',
          backgroundColor: Colors.grey.shade50,
          maxLines: 6,
          maxLength: 500,
        ),
      );

  Widget get buildSendButon {
    return Padding(
      padding: 15.0.edgeIntesetsAll,
      child: Align(
        alignment: Alignment.centerRight,
        child: TextButton(
          onPressed: () => feedbackVm.send(),
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

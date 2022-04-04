import 'package:flutter/material.dart';
import '../../../../../../core/extensions/context_extensions.dart';
import '../../../../../../core/extensions/double_extensions.dart';
import '../../../../../../core/extensions/int_extensions.dart';
import '../../../../../../core/extensions/string_extensions.dart';
import '../../../../../../core/helpers/rounded_bottom_sheet.dart';
import '../../../../../../core/widgets/bottom_sheet_top_rounded_container.dart';
import '../../../../../../core/widgets/custom_text_form.dart';
import '../view_model/delete_account_sheet_view_model.dart';

class DeleteAccountSheet {
  static void show(BuildContext context) => DeleteAccountSheet().start(context);

  DeleteAccountViewModel deleteAccountVm = DeleteAccountViewModel();

  late BuildContext context;

  void initiailizeValues() {
    deleteAccountVm.setContext(context);
  }

  void start(BuildContext context) {
    this.context = context;
    initiailizeValues();
    showSheet();
  }

  void showSheet() {
    showRoundedBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => buildSkeleton,
    );
  }

  Widget get buildSkeleton {
    return Form(
      key: deleteAccountVm.formKey,
      child: Container(
        margin: const EdgeInsets.only(top: 15, left: 15, right: 15),
        padding: context.mediaQuery.viewInsets,
        child: Wrap(children: [buildColumn]),
      ),
    );
  }

  Widget get buildColumn {
    return Column(
      children: [
        const BottomSheetTopRoundedContainer(),
        15.0.sizedBoxOnlyHeight,
        buildInfoText,
        currentPasswordTextFormField,
        buildSendButon,
      ],
    );
  }

  Widget get buildInfoText {
    return Container(
      margin: 15.0.edgeIntesetsAll,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'You deleting your account.',
          style: context.theme.textTheme.headline6?.copyWith(
            color: context.colorScheme.primary,
            fontSize: context.width / 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget get currentPasswordTextFormField => Container(
        margin: 6.0.edgeIntesetsOnlyRight,
        child: CustomTextFormField(
          obscureText: true,
          controller: deleteAccountVm.controller,
          fontSize: context.width / 28,
          icon: Icons.lock_outline,
          labelText: 'Current Password',
          backgroundColor: Colors.grey.shade50,
          validator: (text) => text?.passwordValidator,
        ),
      );

  Widget get buildSendButon {
    return Padding(
      padding: 15.0.edgeIntesetsAll,
      child: Align(
        alignment: Alignment.centerRight,
        child: TextButton(
          onPressed: () => deleteAccountVm.delete(),
          child: SizedBox(width: context.width, child: getButtonText),
          style: getButtonStyle,
        ),
      ),
    );
  }

  Text get getButtonText => Text(
        'Delete Account',
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

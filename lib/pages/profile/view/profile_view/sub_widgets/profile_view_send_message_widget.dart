import 'package:Carafe/core/base/view/base_view.dart';
import 'package:Carafe/pages/profile/view_model/profile_view_model/profile_view_model.dart';
import 'package:flutter/material.dart';
import '../../../../../core/extensions/context_extensions.dart';
import '../../../../../core/extensions/double_extensions.dart';
import '../../../../../core/extensions/int_extensions.dart';
import '../../../../../core/widgets/border_container.dart';

class ProfileViewSendMessageWidget extends StatefulWidget {
  ProfileViewSendMessageWidget({Key? key}) : super(key: key);

  @override
  State<ProfileViewSendMessageWidget> createState() =>
      _ProfileViewSendMessageWidgetState();
}

class _ProfileViewSendMessageWidgetState
    extends State<ProfileViewSendMessageWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      customBorder: RoundedRectangleBorder(borderRadius: 50.radiusAll),
      child: BorderContainer.all(
        radius: 50,
        color: Colors.transparent,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey.shade500,
            width: .5,
          ),
          borderRadius: 50.radiusAll,
        ),
        padding: 3.0.edgeIntesetsAll,
        child: Icon(
          Icons.mail_outlined,
          color: context.colorScheme.secondary,
          size: context.width / 14,
        ),
      ),
    );
  }
}

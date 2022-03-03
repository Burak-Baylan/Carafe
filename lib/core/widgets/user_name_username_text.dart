import 'package:flutter/material.dart';
import '../../pages/authenticate/model/user_model.dart';
import '../extensions/context_extensions.dart';
import '../extensions/double_extensions.dart';

class UserNameUsernameText extends StatefulWidget {
  UserNameUsernameText({
    Key? key,
    required this.userModel,
    this.nameFontSize,
    this.usernameFontSize,
    this.buildWithColumn = false,
  }) : super(key: key);

  UserModel userModel;
  double? nameFontSize;
  double? usernameFontSize;
  bool buildWithColumn;

  @override
  State<UserNameUsernameText> createState() => _UserNameUsernameTextState();
}

class _UserNameUsernameTextState extends State<UserNameUsernameText> {
  Icon get verifiedIcon => Icon(
        Icons.check_circle,
        color: context.colorScheme.secondary,
        size: context.width / 27,
      );

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: widget.buildWithColumn
          ? Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: widgets,
            )
          : Row(mainAxisSize: MainAxisSize.min, children: widgets),
    );
  }

  List<Widget> get widgets => [
        Flexible(child: buildDisplayNameAndVerifiedIcon),
        3.5.sizedBoxOnlyWidth,
        Flexible(child: buildUsername),
      ];

  Widget get buildDisplayNameAndVerifiedIcon => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: _buildText(
              text: '' + widget.userModel.displayName,
              fontSize: widget.nameFontSize ?? context.width / 28,
            ),
          ),
          widget.userModel.verified ? verifiedIcon : Container(),
        ],
      );

  Widget get buildUsername => _buildText(
        text: '@' + widget.userModel.username,
        fontSize: widget.usernameFontSize ?? context.width / 30,
        textColor: Colors.grey[500],
      );

  Widget _buildText({
    required String text,
    required double fontSize,
    FontWeight fontWeight = FontWeight.bold,
    Color? textColor,
  }) =>
      Text(
        text.replaceAll("", "\u{200B}"),
        textWidthBasis: TextWidthBasis.longestLine,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: textColor,
        ),
      );
}

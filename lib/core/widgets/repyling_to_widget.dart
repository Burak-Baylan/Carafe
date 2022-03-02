import 'package:flutter/material.dart';
import '../../pages/authenticate/model/user_model.dart';
import '../../pages/profile/view/profile_view/profile_view.dart';
import '../base/view_model/base_view_model.dart';
import '../extensions/context_extensions.dart';
import 'place_holder_with_border.dart';

class ReplyingToWidget extends StatelessWidget {
  ReplyingToWidget(
      {Key? key,
      required this.future,
      required this.viewModel,
      this.text,
      this.firstTextStyle,
      this.secondTextStyle})
      : super(key: key);

  Future<UserModel?> future;
  BaseViewModel viewModel;
  String? text;
  TextStyle? firstTextStyle;
  TextStyle? secondTextStyle;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserModel?>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return _body(context, snapshot);
        }
        return Align(
          alignment: Alignment.centerLeft,
          child: PlaceHolderWithBorder(),
        );
      },
    );
  }

  Widget _body(
          BuildContext context, AsyncSnapshot<UserModel?> userModelSnapshot) =>
      Align(
        alignment: Alignment.centerLeft,
        child: InkWell(
          onTap: () => viewModel.customNavigateToPage(
            page: ProfileView(userId: userModelSnapshot.data!.userId),
            animate: true,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildText(
                context,
                text ?? "Replying to ",
                Colors.grey.shade600,
                firstTextStyle,
              ),
              _buildText(
                context,
                "@" + userModelSnapshot.data!.displayName,
                context.theme.colorScheme.secondary,
                secondTextStyle,
              ),
            ],
          ),
        ),
      );

  _buildText(
    BuildContext context,
    String text,
    Color color,
    TextStyle? textStyle,
  ) =>
      Text(
        text,
        style: textStyle ??
            context.theme.textTheme.headline6?.copyWith(color: color),
      );
}

import 'package:flutter/material.dart';
import '../../pages/authenticate/model/user_model.dart';
import '../extensions/context_extensions.dart';
import 'place_holder_with_border.dart';

class ReplyingToWidget extends StatelessWidget {
  ReplyingToWidget({
    Key? key,
    required this.future,
  }) : super(key: key);

  Future<UserModel?> future;

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

  Widget _body(BuildContext context, AsyncSnapshot<UserModel?> snapshot) =>
      Align(
        alignment: Alignment.centerLeft,
        child: InkWell(
          onTap: (){},
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildText(
                context,
                "Replying to ",
                Colors.grey.shade600,
              ),
              _buildText(
                context,
                "@" + snapshot.data!.displayName,
                context.theme.colorScheme.secondary,
              ),
            ],
          ),
        ),
      );

  _buildText(BuildContext context, String text, Color color) => Text(
        text,
        style: context.theme.textTheme.headline6?.copyWith(color: color),
      );
}

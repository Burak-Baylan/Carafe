import 'package:Carafe/core/extensions/context_extensions.dart';
import 'package:Carafe/core/widgets/place_holder_with_border.dart';
import 'package:Carafe/pages/authenticate/model/user_model.dart';
import 'package:flutter/material.dart';

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
                "Replying to ",
                Colors.grey.shade600,
              ),
              _buildText(
                "@" + snapshot.data!.username,
                context.theme.colorScheme.secondary,
              ),
            ],
          ),
        ),
      );

  _buildText(String text, Color color) => Text(
        text,
        style: TextStyle(color: color),
      );
}

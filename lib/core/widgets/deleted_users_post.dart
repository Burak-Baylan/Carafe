import 'package:flutter/material.dart';
import '../extensions/context_extensions.dart';
import '../extensions/double_extensions.dart';

class DeletedUsersPost extends StatelessWidget {
  DeletedUsersPost({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: 15.0.edgeIntesetsAll,
      child: Text(
        'The owner of this post was not found or the user has been deleted.',
        style: context.theme.textTheme.headline6?.copyWith(
          color: context.colorScheme.secondary,
          fontWeight: FontWeight.bold,
          fontSize: context.width / 21,
        ),
      ),
    );
  }
}

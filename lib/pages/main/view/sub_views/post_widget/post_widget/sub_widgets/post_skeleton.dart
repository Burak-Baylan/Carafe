import 'package:flutter/material.dart';
import '../../../../../../../core/extensions/context_extensions.dart';
import '../../../../../../../core/extensions/double_extensions.dart';
import '../../../../../../../core/widgets/border_container.dart';

class PostSkeleton extends StatelessWidget {
  PostSkeleton({
    Key? key,
    required this.child,
    required this.showReply,
  }) : super(key: key);

  bool showReply;
  Widget child;

  @override
  Widget build(BuildContext context) {
    return BorderContainer.all(
      elevation: showReply ? 0 : 5,
      radius: showReply ? 0 : 10,
      margin: showReply ? 0.0.edgeIntesetsAll : 15.0.edgeIntesetsRightLeft,
      width: context.width,
      child: child,
    );
  }
}

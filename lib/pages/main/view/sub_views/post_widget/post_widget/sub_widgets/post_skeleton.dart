import 'package:flutter/material.dart';
import '../../../../../../../core/extensions/context_extensions.dart';
import '../../../../../../../core/extensions/double_extensions.dart';
import '../../../../../../../core/widgets/border_container.dart';

class PostSkeleton extends StatelessWidget {
  PostSkeleton({
    Key? key,
    required this.child,
    required this.closeCardView,
  }) : super(key: key);

  bool closeCardView;
  Widget child;

  @override
  Widget build(BuildContext context) {
    return BorderContainer.all(
      elevation: closeCardView ? 0 : 5,
      radius: closeCardView ? 0 : 10,
      margin: closeCardView ? 0.0.edgeIntesetsAll : 15.0.edgeIntesetsRightLeft,
      width: context.width,
      color: Colors.white,
      child: child,
    );
  }
}

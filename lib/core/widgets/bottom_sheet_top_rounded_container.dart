import 'package:flutter/material.dart';

import '../extensions/context_extensions.dart';
import 'place_holder_with_border.dart';

class BottomSheetTopRoundedContainer extends StatelessWidget {
  const BottomSheetTopRoundedContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PlaceHolderWithBorder(
      height: context.height / 150,
      width: context.width / 12,
    );
  }
}

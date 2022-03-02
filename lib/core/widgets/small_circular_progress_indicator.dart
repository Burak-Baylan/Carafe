import 'package:flutter/material.dart';

class SmallCircularProgressIndicator extends StatelessWidget {
  const SmallCircularProgressIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 15,
      height: 15,
      child: CircularProgressIndicator(strokeWidth: 2.5),
    );
  }
}

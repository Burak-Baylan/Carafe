import 'package:Carafe/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class LoadingAlertDialog {
  static LoadingAlertDialog get instance => LoadingAlertDialog._init();
  LoadingAlertDialog._init();

  late BuildContext context;

  void show(BuildContext context, {bool dismissible = false}) {
    this.context = context;
    showDialog(
      context: context,
      barrierDismissible: dismissible,
      builder: (context) {
        return AlertDialog(
          shape: _shape,
          content: SizedBox(
            height: context.height / 6,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }

  void dismiss() => context.pop;

  ShapeBorder get _shape => RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      );
}

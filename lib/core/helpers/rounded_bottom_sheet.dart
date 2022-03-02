import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../extensions/context_extensions.dart';
import '../extensions/double_extensions.dart';
import '../extensions/int_extensions.dart';
import '../widgets/bottom_sheet_top_rounded_container.dart';

void showRoundedBottomSheet({
  required BuildContext context,
  required Widget Function(BuildContext) builder,
  Color? backgroundColor,
  double? elevation,
  ShapeBorder? shape,
  Clip? clipBehavior,
  BoxConstraints? constraints,
  Color? barrierColor,
  bool isScrollControlled = false,
  bool useRootNavigator = false,
  bool isDismissible = true,
  bool enableDrag = true,
  RouteSettings? routeSettings,
  AnimationController? transitionAnimationController,
}) {
  showModalBottomSheet(
    context: context,
    shape: shape ??
        RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: 20.radiusCircular,
            topRight: 20.radiusCircular,
          ),
        ),
    builder: (context) => builder(context),
    backgroundColor: backgroundColor,
    elevation: elevation,
    clipBehavior: clipBehavior,
    constraints: constraints,
    barrierColor: barrierColor,
    isScrollControlled: isScrollControlled,
    useRootNavigator: useRootNavigator,
    isDismissible: isDismissible,
    enableDrag: enableDrag,
    routeSettings: routeSettings,
    transitionAnimationController: transitionAnimationController,
  );
}

showDatePickerSheet({
  required BuildContext context,
  required void Function(DateTime) onDateTimeSelected,
}) {
  var selectedDate = Timestamp.now().toDate();
  showRoundedBottomSheet(
    context: context,
    builder: (context) {
      return SizedBox(
        height: context.height * 0.35,
        child: Column(
          children: [
            10.sizedBoxOnlyHeight,
            const Flexible(
              flex: 1,
              child: BottomSheetTopRoundedContainer(),
            ),
            10.sizedBoxOnlyHeight,
            Expanded(
              flex: 9,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                minimumDate: DateTime(selectedDate.year - 100),
                maximumDate: DateTime(selectedDate.year),
                initialDateTime: DateTime(selectedDate.year),
                onDateTimeChanged: (date) => selectedDate = date,
              ),
            ),
            Container(
              margin: 10.0.edgeIntesetsOnlyRight,
              child: Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    onDateTimeSelected(selectedDate);
                    context.pop;
                  },
                  child: Text(
                    'Done',
                    style: context.theme.textTheme.headline6?.copyWith(
                      color: context.colorScheme.primary,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      );
    },
  );
}

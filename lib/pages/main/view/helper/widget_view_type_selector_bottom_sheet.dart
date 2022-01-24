import 'package:flutter/material.dart';
import '../../../../app/managers/hive_manager.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/extensions/int_extensions.dart';
import '../../../../core/helpers/rounded_bottom_sheet.dart';
import '../../../../core/widgets/place_holder_with_border.dart';
import '../../../../main.dart';

class WidgetViewTypeSelectorBottomSheet {
  static show(BuildContext context) async =>
      WidgetViewTypeSelectorBottomSheet(context).build();

  WidgetViewTypeSelectorBottomSheet(this.context);

  BuildContext context;

  build() async {
    var type = await HiveManager.getPostWidgetViewType;
    showRoundedBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          10.sizedBoxOnlyHeight,
          PlaceHolderWithBorder(height: context.height / 75),
          10.sizedBoxOnlyHeight,
          ListTile(
            onTap: () => _clicked(() => mainVm.updatePostViewType(true)),
            trailing: type ? _checkmarkIcon : _bodylessWidget,
            title: _buildText('Flat View'),
          ),
          ListTile(
            onTap: () => _clicked(() => mainVm.updatePostViewType(false)),
            trailing: !type ? _checkmarkIcon : _bodylessWidget,
            title: _buildText('Card View'),
          ),
        ],
      ),
    );
  }

  void _clicked(Function() onTap) {
    onTap();
    context.pop;
  }

  Widget _buildText(String text) => Text(text,
      style: context.theme.textTheme.headline6
          ?.copyWith(color: context.colorScheme.secondary));

  Widget get _bodylessWidget => const SizedBox(width: 0, height: 0);

  Widget get _checkmarkIcon =>
      Icon(Icons.check, color: context.colorScheme.primary);
}

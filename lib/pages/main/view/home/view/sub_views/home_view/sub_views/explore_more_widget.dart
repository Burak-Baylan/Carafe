import '../../../../../../../../core/extensions/context_extensions.dart';
import '../../../../../../../../core/extensions/double_extensions.dart';
import 'package:flutter/material.dart';
import '../../../../../../../../main.dart';

class HomeViewExploreMoreWidget extends StatelessWidget {
  HomeViewExploreMoreWidget({
    Key? key,
    this.onClick,
  }) : super(key: key);

  Function? onClick;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        10.0.sizedBoxOnlyHeight,
        ListTile(
          onTap: () => onClick != null ? onClick!() : mainVm.changeIndex(1),
          leading: Icon(
            Icons.explore,
            color: context.colorScheme.secondary,
            size: context.width / 13,
          ),
          title: Text(
            'Explore More',
            style: context.theme.textTheme.headline6?.copyWith(
              color: context.colorScheme.secondary,
              fontSize: context.width / 23,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            'There is much more to discover...',
            style: context.theme.textTheme.headline6?.copyWith(
              color: context.colorScheme.secondary,
              fontSize: context.width / 30,
            ),
          ),
          trailing: Icon(
            Icons.chevron_right_sharp,
            color: context.colorScheme.secondary,
            size: context.width / 13,
          ),
        ),
        10.0.sizedBoxOnlyHeight,
      ],
    );
  }
}

import 'package:Carafe/core/constants/svg/svg_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../../../../core/extensions/context_extensions.dart';
import '../../../../../../../../core/extensions/double_extensions.dart';
import '../../../../../../../../main.dart';
import '../../../../view_model/home_view_model.dart';

class HomeViewPostsNotFoundView extends StatelessWidget {
  HomeViewPostsNotFoundView({
    Key? key,
    required this.homeViewModel,
    required this.onRefreshPressed,
  }) : super(key: key);

  HomeViewModel homeViewModel;
  Function onRefreshPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            SVGConstants.noFollowing,
            height: context.height / 5,
            width: context.width / 2,
          ),
          20.0.sizedBoxOnlyHeight,
          Text(
            'It seemy you are not following anyone.',
            textAlign: TextAlign.center,
            style: context.theme.textTheme.headline6?.copyWith(
              color: context.colorScheme.primary,
              fontSize: context.width / 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          10.0.sizedBoxOnlyHeight,
          FlatButton(
            onPressed: () => mainVm.changeIndex(1), // Search Page Index
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.explore,
                  color: context.colorScheme.secondary,
                  size: context.width / 13,
                ),
                5.0.sizedBoxOnlyWidth,
                Text(
                  'Explore People',
                  style: context.theme.textTheme.headline6?.copyWith(
                    color: context.colorScheme.secondary,
                    fontSize: context.width / 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          10.0.sizedBoxOnlyHeight,
          TextButton(
            onPressed: () => onRefreshPressed(),
            child: Text(
              "Refresh",
              style: TextStyle(
                fontSize: context.height / 45,
              ),
            ),
          )
        ],
      ),
    );
  }
}

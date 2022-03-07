import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../../app/constants/app_constants.dart';
import '../../../../../../core/base/view/base_view.dart';
import '../../../../../../core/extensions/context_extensions.dart';
import '../../../../../../core/extensions/double_extensions.dart';
import '../../../../../../core/extensions/int_extensions.dart';
import '../../../../../../core/extensions/widget_extension.dart';
import '../../../../../../core/widgets/small_circular_progress_indicator.dart';
import '../../../../../../main.dart';
import '../../post_widget/post_widget/sub_widgets/profile_photo.dart';

class MainDrawerHeader extends StatefulWidget {
  MainDrawerHeader({Key? key}) : super(key: key);

  @override
  State<MainDrawerHeader> createState() => _MainDrawerHeaderState();
}

class _MainDrawerHeaderState extends BaseView<MainDrawerHeader> {
  late BuildContext context;

  @override
  Widget build(BuildContext context) {
    this.context = context;
    _initializeValues();
    return _buildHeader(context);
  }

  int? followingCount;
  int? followersCount;

  Future<bool> _initializeValues() async {
    if (mainVm.authService.currentUser == null) return false;
    followingCount = await mainVm.userManager.getCurrentUserFollowingCount();
    followersCount = await mainVm.userManager.getCurrentUserFollowersCount();
    return true;
  }

  Widget _buildHeader(BuildContext context) {
    return FutureBuilder(
      future: _initializeValues(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return _errorWidget;
        }
        if (snapshot.hasData) {
          return _header;
        }
        return const SmallCircularProgressIndicator().center;
      },
    );
  }

  Widget get _errorWidget => Center(
        child: Text(
          'Something went wrong',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: GoogleFonts.sourceSansPro().fontFamily,
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
            fontSize: context.height / 40,
          ),
        ),
      );

  Widget get _header => Container(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            profilePhoto,
            10.0.sizedBoxOnlyHeight,
            buildText(
              text: mainVm.currentUserModel!.displayName,
              fontSize: context.width / 23,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            5.0.sizedBoxOnlyHeight,
            buildText(
              text: '@' + mainVm.currentUserModel!.username,
              fontSize: context.width / 24,
              color: Colors.grey.shade600,
            ),
            10.0.sizedBoxOnlyHeight,
            _followCounts,
          ],
        ),
      );

  Widget buildText({
    required String text,
    required double fontSize,
    FontWeight fontWeight = FontWeight.normal,
    Color color = Colors.black,
  }) {
    return Text(
      text,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: context.theme.textTheme.headline6?.copyWith(
        fontSize: fontSize,
        color: color,
        fontWeight: fontWeight,
      ),
    );
  }

  Widget get profilePhoto => PostProfilePhoto(
        height: context.width / 7.5,
        width: context.width / 7.5,
        imageUrl: mainVm.currentUserModel?.photoUrl,
        onClicked: (_) {
          context.pop;
          mainVm.navigateToProfileScreen();
        },
      );

  Row get _followCounts => Row(
        children: [
          _followCountsText("${followingCount?.shorten}", FontWeight.bold),
          _followCountsText(" Following", FontWeight.normal),
          10.0.sizedBoxOnlyWidth,
          _followCountsText("${followersCount?.shorten}", FontWeight.bold),
          _followCountsText(" Followers", FontWeight.normal),
        ],
      );

  Text _followCountsText(String text, FontWeight fontWeight) => Text(
        text,
        style: context.theme.textTheme.headline6?.copyWith(
          fontSize: context.width / 25,
          color: Colors.black,
          fontWeight: fontWeight,
        ),
      );
}

import 'package:flutter/material.dart';
import '../../../../core/base/view_model/base_view_model.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/extensions/double_extensions.dart';
import '../../../../core/widgets/user_name_username_text.dart';
import '../../../authenticate/model/user_model.dart';
import '../../../main/view/sub_views/post_widget/post_widget/sub_widgets/profile_photo.dart';
import '../../../profile/view/profile_view/profile_view.dart';

class SearchedUsersInformationWidget extends StatefulWidget {
  SearchedUsersInformationWidget({
    Key? key,
    required this.viewModel,
    required this.userModel,
    this.extraWidget,
  }) : super(key: key);

  BaseViewModel viewModel;
  UserModel userModel;
  Widget? extraWidget;

  @override
  State<SearchedUsersInformationWidget> createState() =>
      _SearchedUsersInformationWidgetState();
}

class _SearchedUsersInformationWidgetState
    extends State<SearchedUsersInformationWidget>
    with AutomaticKeepAliveClientMixin {
  Icon get verifiedIcon => Icon(
        Icons.check_circle,
        color: context.colorScheme.secondary,
        size: context.width / 27,
      );

  String? get profileDesc => widget.userModel.profileDescription;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => navigateToProfile(),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
            child: userInformations,
          ),
          10.0.sizedBoxOnlyHeight,
          Align(
            alignment: Alignment.centerLeft,
            child: widget.extraWidget ?? Container(),
          ),
          const Align(
            child: Divider(height: 0),
            alignment: Alignment.bottomCenter,
          ),
        ],
      ),
    );
  }

  Widget get userInformations => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildProfilePhoto,
          10.0.sizedBoxOnlyWidth,
          Expanded(child: buildNameAndDesc),
        ],
      );

  Widget get buildProfilePhoto => PostProfilePhoto(
        width: context.width / 8,
        height: context.width / 8,
        imageUrl: widget.userModel.photoUrl ?? 'https://bit.ly/3HTCLko',
        onClicked: (_) => navigateToProfile(),
      );

  Widget get buildNameAndDesc => Align(
        alignment: Alignment.centerLeft,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [buildUsername, buildDescription],
        ),
      );

  Widget get buildUsername => UserNameUsernameText(
        userModel: widget.userModel,
        buildWithColumn: true,
      );

  Widget get buildDescription => profileDesc != null
      ? _buildText(
          text: '${widget.userModel.profileDescription}',
          fontSize: context.width / 29,
        )
      : Container();

  Widget _buildText({
    required String text,
    required double fontSize,
    Color? color,
    FontWeight? fontWeight,
  }) =>
      Text(
        text,
        style: context.theme.textTheme.headline6?.copyWith(
          color: color,
          fontSize: fontSize,
          fontWeight: fontWeight,
        ),
      );

  void navigateToProfile() => widget.viewModel.customNavigateToPage(
      page: ProfileView(userId: widget.userModel.userId), animate: true);

  @override
  bool get wantKeepAlive => true;
}

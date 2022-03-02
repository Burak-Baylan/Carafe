import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../../../../../../../core/extensions/context_extensions.dart';
import '../../../../../../../../core/extensions/timestamp_extensions.dart';
import '../../../../../../../../core/widgets/center_dot_text.dart';
import '../../../../../../../../core/widgets/place_holder_with_border.dart';
import '../../../../../../../../core/widgets/repyling_to_widget.dart';
import '../../../../../../../../core/widgets/user_name_username_text.dart';
import '../../../../../../../authenticate/model/user_model.dart';
import '../../../../../../model/post_model.dart';
import '../../view_model/post_view_model.dart';
import 'post_menu/view/post_menu.dart';

class PostNameAndMenu extends StatelessWidget {
  PostNameAndMenu({
    Key? key,
    required this.postModel,
    required this.postViewModel,
    this.nameFontSize,
    this.mailFontSize,
    this.closeCenterDot = false,
    this.buildWithColumn = false,
    this.closeMenuButton = false,
    this.onPostPinnedOrUnpinned,
  }) : super(key: key);

  PostModel postModel;
  PostViewModel postViewModel;
  double? nameFontSize;
  double? mailFontSize;
  bool closeCenterDot;
  bool buildWithColumn;
  bool closeMenuButton;
  Function? onPostPinnedOrUnpinned;
  late BuildContext context;

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Observer(
        builder: (_) =>
            postViewModel.userModel != null ? _body() : _loadingWidget);
  }

  Widget _body() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
                child: _buildUserInformationLayout(postViewModel.userModel)),
            _buildTimeAgoTextAndMenuButton(),
          ],
        ),
        _replyedWidget,
      ],
    );
  }

  Widget _buildTimeAgoTextAndMenuButton() => closeMenuButton
      ? Container()
      : PostMenuButton(
          postModel: postModel,
          userModel: postViewModel.userModel!,
          postViewModel: postViewModel,
          onPostPinnedOrUnpinned: onPostPinnedOrUnpinned,
        );

  Widget get _buildTimeAgoText => Row(
        children: [
          CenterDotText(textColor: Colors.grey.shade500),
          _buildText(
            text: postModel.createdAt!.getTimeAgo,
            fontSize: context.width / 30,
            textColor: Colors.grey.shade500,
          ),
        ],
      );

  Widget get _replyedWidget {
    if (postModel.replyed == null || !postModel.replyed!) {
      return Container();
    } else {
      return ReplyingToWidget(
        future: postViewModel.firebaseManager
            .getAUserInformation(postModel.replyedUserId!),
        viewModel: postViewModel,
      );
    }
  }

  Widget get _loadingWidget => Row(
        children: [
          PlaceHolderWithBorder(),
          CenterDotText(),
          PlaceHolderWithBorder(),
        ],
      );

  Widget _buildUserInformationLayout(UserModel? userInformation) =>
      buildWithColumn
          ? IntrinsicHeight(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _userInformationTexts(userInformation),
              ),
            )
          : Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: _userInformationTexts(userInformation),
            );

  // if closeCenterDot == true, the post widget is full screen and
  // we don't want to show 'time ago' when the page full screen.
  List<Widget> _userInformationTexts(UserModel? userInformation) => [
        UserNameUsernameText(
          userModel: userInformation!,
          buildWithColumn: buildWithColumn,
        ),
        closeCenterDot ? Container() : _buildTimeAgoText
      ];

  Widget _buildText({
    required String text,
    required double fontSize,
    FontWeight fontWeight = FontWeight.bold,
    Color? textColor,
  }) =>
      Text(
        text.replaceAll("", "\u{200B}"),
        textWidthBasis: TextWidthBasis.longestLine,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: textColor,
        ),
      );
}

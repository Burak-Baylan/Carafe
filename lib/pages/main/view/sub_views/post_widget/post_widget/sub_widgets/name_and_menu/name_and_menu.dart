import 'package:Carafe/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import '../../../../../../../../core/extensions/timestamp_extensions.dart';
import '../../../../../../../../core/widgets/center_dot_text.dart';
import '../../../../../../../../core/widgets/place_holder_with_border.dart';
import '../../../../../../../../core/widgets/repyling_to_widget.dart';
import '../../../../../../../authenticate/model/user_model.dart';
import '../../../../../../model/post_model.dart';
import '../../../../../home/view_model/home_view_model.dart';
import '../../view_model/post_view_model.dart';
import 'post_menu/view/post_menu.dart';

class PostNameAndMenu extends StatelessWidget {
  PostNameAndMenu({
    Key? key,
    required this.postModel,
    required this.homeViewModel,
    required this.postViewModel,
    this.nameFontSize,
    this.mailFontSize,
    this.closeCenterDot = false,
    this.buildWithColumn = false,
  }) : super(key: key);

  PostModel postModel;
  HomeViewModel homeViewModel;
  PostViewModel postViewModel;
  double? nameFontSize;
  double? mailFontSize;
  bool closeCenterDot;
  bool buildWithColumn;
  late BuildContext context;

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return FutureBuilder<UserModel?>(
      future:
          homeViewModel.firebaseManager.getAUserInformation(postModel.authorId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data == null) return _loadingWidget;
          UserModel userModel = snapshot.data!;
          return _body(userModel);
        }
        return _loadingWidget;
      },
    );
  }

  Widget _body(UserModel userModel) => SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(child: _buildUserInformationLayout(userModel)),
                _buildTimeAgoTextAndMenuButton(userModel),
              ],
            ),
            _replyedWidget,
          ],
        ),
      );

  Widget _buildTimeAgoTextAndMenuButton(UserModel userModel) => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildTimeAgoText,
          PostMenuButton(
            postModel: postModel,
            viewModel: homeViewModel,
            userModel: userModel,
          ),
        ],
      );

  // if closeCenterDot == true, the post widget is full screen and
  // we don't want to show 'time ago' when the page full screen.
  Widget get _buildTimeAgoText => closeCenterDot
      ? Container()
      : Row(
          children: [
            CenterDotText(textColor: Colors.grey.shade500),
            _buildText(
                text: postModel.createdAt!.getTimeAgo,
                fontSize: context.width / 30,
                textColor: Colors.grey.shade500),
          ],
        );

  Widget get _replyedWidget {
    if (postModel.replyed == null || !postModel.replyed!) {
      return Container();
    } else {
      return ReplyingToWidget(
        future: homeViewModel.firebaseManager
            .getAUserInformation(postModel.replyedUserId!),
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
              children: _userInformationTexts(userInformation),
            );

  List<Widget> _userInformationTexts(UserModel? userInformation) => [
        _buildText(
            text: userInformation!.username,
            fontSize: nameFontSize ?? context.width / 28),
        closeCenterDot ? Container() : CenterDotText(),
        Expanded(
          child: _buildText(
            text: userInformation.email,
            fontSize: mailFontSize ?? context.width / 28,
            textColor: Colors.grey[500],
          ),
        ),
      ];

  Widget _buildText({
    required String text,
    required double fontSize,
    FontWeight fontWeight = FontWeight.bold,
    Color? textColor,
  }) =>
      Text(
        text,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
            fontSize: fontSize, fontWeight: fontWeight, color: textColor),
      );
}

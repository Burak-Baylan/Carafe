import 'package:flutter/material.dart';
import '../../../../../../../../core/widgets/center_dot_text.dart';
import '../../../../../../../../core/widgets/place_holder_with_border.dart';
import '../../../../../../../authenticate/model/user_model.dart';
import '../../../../../../model/post_model.dart';
import '../../../../../home/view_model/home_view_model.dart';
import 'post_menu/view/post_menu.dart';

class PostNameAndMenu extends StatelessWidget {
  PostNameAndMenu({
    Key? key,
    required this.postModel,
    required this.homeViewModel,
    this.nameFontSize = 13,
    this.mailFontSize = 13,
    this.closeCenterDot = false,
    this.buildWithColumn = false,
  }) : super(key: key);

  PostModel postModel;
  HomeViewModel homeViewModel;
  double nameFontSize;
  double mailFontSize;
  bool closeCenterDot;
  bool buildWithColumn;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserModel?>(
      future:
          homeViewModel.firebaseManager.getAUserInformation(postModel.authorId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data == null) return _loadingWidget;
          UserModel userModel = snapshot.data!;
          return SizedBox(
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Flexible(child: _buildLayout(userModel)),
                PostMenuButton(
                  postModel: postModel,
                  viewModel: homeViewModel,
                  userModel: userModel,
                ),
              ],
            ),
          );
        }
        return _loadingWidget;
      },
    );
  }

  Widget get _loadingWidget => Row(
        children: [
          PlaceHolderWithBorder(),
          CenterDotText(),
          PlaceHolderWithBorder(),
        ],
      );

  Widget _buildLayout(UserModel? userInformation) => buildWithColumn
      ? IntrinsicHeight(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: nameAndMenuChildren(userInformation),
          ),
        )
      : Row(
          mainAxisSize: MainAxisSize.max,
          children: nameAndMenuChildren(userInformation),
        );

  List<Widget> nameAndMenuChildren(UserModel? userInformation) => [
        _buildText(text: userInformation!.username, fontSize: nameFontSize),
        closeCenterDot ? Container() : CenterDotText(),
        Expanded(
          child: _buildText(
              text: userInformation.email,
              fontSize: mailFontSize,
              textColor: Colors.grey[500]),
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
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: textColor,
        ),
      );
}

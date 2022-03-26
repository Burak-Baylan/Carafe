import 'package:flutter/material.dart';
import '../../../../../../../../core/extensions/context_extensions.dart';
import '../../../../../../../../core/extensions/double_extensions.dart';
import '../../../../../../../../core/extensions/timestamp_extensions.dart';
import '../../../../../../../../core/widgets/center_dot_text.dart';
import '../../../../../../../authenticate/model/user_model.dart';
import '../../../../../../model/post_model.dart';
import '../../../../post_widget/post_widget/sub_widgets/profile_photo.dart';
import '../../sub_widgets.dart/post_status_text.dart';

class PostStatusPostWidgetTopLayout extends StatelessWidget {
  PostStatusPostWidgetTopLayout({
    Key? key,
    required this.postModel,
    required this.userModel,
  }) : super(key: key);

  PostModel postModel;
  UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: context.width / 10,
          height: context.width / 10,
          child: PostProfilePhoto(
            userId: postModel.authorId,
            onClicked: (_) => null,
            imageUrl: userModel.photoUrl,
          ),
        ),
        Flexible(
          child: Container(
            margin: 5.0.edgeIntesetsOnlyLeft,
            child: Row(
              children: [
                Flexible(
                  child: PostStatusText(
                    text: userModel.displayName,
                    fontSize: context.width / 28,
                  ),
                ),
                3.5.sizedBoxOnlyWidth,
                Flexible(
                  child: PostStatusText(
                    text: '@' + userModel.username,
                    fontSize: context.width / 30,
                    textColor: Colors.grey[500],
                  ),
                ),
                CenterDotText(
                  textColor: Colors.grey.shade500,
                ),
                PostStatusText(
                  text: postModel.createdAt!.getTimeAgo,
                  fontSize: context.width / 30,
                  textColor: Colors.grey[500],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

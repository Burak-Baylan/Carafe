import 'package:Carafe/core/extensions/double_extensions.dart';
import 'package:Carafe/core/extensions/int_extensions.dart';
import 'package:Carafe/pages/authenticate/model/user_model.dart';
import 'package:Carafe/pages/main/model/post_model.dart';
import 'package:Carafe/pages/main/view/sub_views/sub_views/view/sub_views/post_status_post_widget_layout/post_status_view_image_and_text.dart';
import 'package:Carafe/pages/main/view/sub_views/sub_views/view/sub_views/post_status_post_widget_layout/post_status_view_post_widget_top_layout.dart';
import 'package:flutter/material.dart';

class PostStatausViewPostWidget extends StatelessWidget {
  PostStatausViewPostWidget({
    Key? key,
    required this.postModel,
    required this.userModel,
  }) : super(key: key);

  PostModel postModel;
  UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: 10.0.edgeIntesetsAll,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PostStatusPostWidgetTopLayout(
            postModel: postModel,
            userModel: userModel,
          ),
          5.sizedBoxOnlyHeight,
          PostStatusViewImageAndText(postModel: postModel)
        ],
      ),
    );
  }
}

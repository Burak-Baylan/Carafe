import 'package:flutter/material.dart';
import '../../main.dart';
import '../../pages/main/model/post_model.dart';
import '../../pages/main/view/sub_views/post_widget/post_widget/post_widget.dart';
import '../extensions/context_extensions.dart';

class DeletedPostWidget extends StatefulWidget {
  DeletedPostWidget({Key? key, required this.postModel}) : super(key: key);

  PostModel postModel;

  @override
  State<DeletedPostWidget> createState() => _DeletedPostWidgetState();
}

class _DeletedPostWidgetState extends State<DeletedPostWidget> {
  @override
  Widget build(BuildContext context) {
    return buildBody();
  }

  Widget buildBody() {
    return PostWidget(
      model: widget.postModel,
      topInformation: Container(),
      ppWidget: Container(),
      topUserInformation: Container(),
      postText: buildText,
      image: Container(),
      onClicked: (postVm, model) => {},
      closeCardView: mainVm.isTypeFlatView,
    );
  }

  Widget get buildText {
    return Text(
      'This post has been deleted.',
      style: context.theme.textTheme.headline6?.copyWith(
        fontSize: context.width / 20,
        color: context.colorScheme.secondary,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../../../../../../../../../app/constants/app_constants.dart';
import '../../../../../../../../../../core/extensions/context_extensions.dart';
import '../../../../../../../../../../core/extensions/double_extensions.dart';
import '../../../../../../../../../../core/extensions/int_extensions.dart';
import '../../../../../../../../../../core/extensions/widget_extension.dart';
import '../../../../../../../../../../core/helpers/rounded_bottom_sheet.dart';
import '../../../../../../../../../../core/widgets/bottom_sheet_top_rounded_container.dart';
import '../../../../../../../../../authenticate/model/user_model.dart';
import '../../../../../../../../model/post_model.dart';
import '../../../../view_model/post_view_model.dart';
import '../view_model/post_menu_view_model.dart';
import 'sub_views/post_menu_items.dart';

class PostMenuButton extends StatelessWidget {
  PostMenuButton({
    Key? key,
    required this.postModel,
    required this.userModel,
    required this.postViewModel,
    this.onPostPinnedOrUnpinned,
  }) : super(key: key);

  PostModel postModel;
  UserModel userModel;
  PostViewModel postViewModel;
  GlobalKey menuKey = GlobalKey();
  PostMenuViewModel postMenuVm = PostMenuViewModel();
  Function? onPostPinnedOrUnpinned;

  @override
  Widget build(BuildContext context) {
    setViewModel(context);
    return PopupMenuButton<int>(
      key: menuKey,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: () => sheet(context),
        child: Icon(
          Icons.more_vert_outlined,
          color: Colors.grey[500],
          size: 20,
        ),
      ),
      itemBuilder: (context) => [],
      onSelected: (value) async => {},
      color: AppColors.secondary,
    );
  }

  sheet(BuildContext context) {
    showRoundedBottomSheet(
      context: context,
      builder: (context) => FutureBuilder<bool>(
        future: findItems(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (!snapshot.data!) {
              context.pop;
              return Container();
            }
            return sheetItems(context);
          }
          return const CircularProgressIndicator().center;
        },
      ),
    );
  }

  Future<bool> findItems() async {
    postMenuVm.findPostOwner();
    if (!postMenuVm.isItCurrentUserPost) {
      return await postMenuVm.findFollowButtonActionAndText();
    } else {
      return await postMenuVm.findPinButtonActionAndText();
    }
  }

  Widget sheetItems(BuildContext context) {
    return Wrap(children: [
      Container(
        margin: 10.0.edgeIntesetsTopBottom,
        child: Column(
          children: <Widget>[
                const Align(
                  alignment: Alignment.topCenter,
                  child: BottomSheetTopRoundedContainer(),
                ),
                15.sizedBoxOnlyHeight,
              ] +
              getSheetItems(context),
        ),
      ),
    ]);
  }

  List<Widget> getSheetItems(BuildContext context) {
    var menuItems = PostMenuItems(
      context: context,
      postMenuVm: postMenuVm,
      userModel: userModel,
      postModel: postModel,
      onPostPinnedOrUnpinned: onPostPinnedOrUnpinned,
    );
    if (postMenuVm.isItCurrentUserPost) {
      return menuItems.postOwnerItems();
    }
    return menuItems.somoneElsePostItems();
  }

  void setViewModel(BuildContext context) {
    postMenuVm.setContext(context);
    postMenuVm.setPostModel(postModel);
    postMenuVm.setUserModel(userModel);
    postMenuVm.setPostViewModel(postViewModel);
  }
}

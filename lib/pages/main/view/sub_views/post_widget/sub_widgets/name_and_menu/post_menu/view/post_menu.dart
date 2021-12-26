import 'package:flutter/material.dart';
import '../../../../../../../../../app/constants/app_constants.dart';
import '../../../../../../../../../core/extensions/context_extensions.dart';
import '../../../../../../../../../core/extensions/double_extensions.dart';
import '../../../../../../../../../core/extensions/int_extensions.dart';
import '../../../../../../../../../core/extensions/widget_extension.dart';
import '../../../../../../../../../core/widgets/place_holder_with_border.dart';
import '../../../../../../../../authenticate/model/user_model.dart';
import '../../../../../../../model/post_model.dart';
import '../../../../../../home/view_model/home_view_model.dart';
import '../view_model/post_menu_view_model.dart';
import 'sub_views/post_menu_items.dart';

class PostMenuButton extends StatelessWidget {
  PostMenuButton({
    Key? key,
    required this.postModel,
    required this.viewModel,
    required this.userModel,
  }) : super(key: key);

  PostModel postModel;
  HomeViewModel viewModel;
  UserModel userModel;
  GlobalKey menuKey = GlobalKey();
  PostMenuViewModel postMenuVm = PostMenuViewModel();

  @override
  Widget build(BuildContext context) {
    setViewModel(context);
    return PopupMenuButton<int>(
      key: menuKey,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: () => sheet(context),
        child: const Icon(
          Icons.more_vert_outlined,
          size: 20,
        ),
      ),
      itemBuilder: (context) => [],
      onSelected: (value) async => {},
      color: AppColors.secondary,
    );
  }

  sheet(BuildContext context) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: 20.radiusCircular,
          topRight: 20.radiusCircular,
        ),
      ),
      context: context,
      builder: (context) => FutureBuilder<bool>(
        future: findItems(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (!snapshot.data!) {
              return const Center(child: Text("Error"));
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
                Align(
                  alignment: Alignment.topCenter,
                  child: PlaceHolderWithBorder(height: context.height / 90),
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
    );
    if (postMenuVm.isItCurrentUserPost) {
      return menuItems.postOwnerItems();
    }
    return menuItems.somoneElsePostItems();
  }

  setViewModel(BuildContext context) {
    postMenuVm.setContext(context);
    postMenuVm.setPostModel(postModel);
    postMenuVm.setUserModel(userModel);
  }
}

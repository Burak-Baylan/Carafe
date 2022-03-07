import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../../../../core/extensions/context_extensions.dart';
import '../../../../../core/extensions/double_extensions.dart';
import '../../../../../core/extensions/widget_extension.dart';
import '../../../../../core/widgets/center_dot_text.dart';
import '../../../../../core/widgets/lite_post_widget.dart';
import '../../../../../core/widgets/small_circular_progress_indicator.dart';
import '../../../../../core/widgets/something_went_wrong_widget.dart';
import '../../../../../core/widgets/there_is_nothing_here_widget.dart';
import '../../../../authenticate/model/user_model.dart';
import '../../../../search/view/sub_views/searced_users_information_widget.dart';
import '../../../model/post_model.dart';
import '../view_model/users_list_view_model.dart';

class UsersListView extends StatefulWidget {
  UsersListView({
    Key? key,
    required this.appBarText,
    required this.userListType,
    required this.listingRef,
  }) : super(key: key);

  String appBarText;
  Query<Map<String, dynamic>> listingRef;
  UserListType userListType;

  @override
  State<UsersListView> createState() => _UsersListViewState();
}

class _UsersListViewState extends State<UsersListView> {
  late Future<List<UserModel>> future;
  UsersListViewModel usersListVm = UsersListViewModel();

  @override
  void initState() {
    usersListVm.setUserListType(widget.userListType);
    future = usersListVm.getData(widget.listingRef);
    usersListVm.setContext(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appBar,
      body: Column(children: [_buildBody]),
    );
  }

  Widget get _buildBody => Expanded(
        child: FutureBuilder<List<UserModel>>(
          future: future,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const SomethingWentWrongWidget();
            }
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data != null && snapshot.data!.isEmpty) {
                return const ThereIsNothingHereWidget();
              } else {
                return _buildUsersList(snapshot);
              }
            }
            return const SmallCircularProgressIndicator().center;
          },
        ),
      );

  Widget _buildUsersList(AsyncSnapshot<List<UserModel>> snapshot) => Observer(
        builder: (_) => ListView.builder(
          itemCount: usersListVm.usersList.length,
          controller: usersListVm.scrollController,
          physics: usersListVm.usersListScrollabe,
          itemBuilder: (context, index) => buildItem(index, snapshot.data!),
        ),
      );

  Widget buildItem(int index, List<UserModel> users) {
    var userModel = usersListVm.usersList[index];
    List<Widget> widgets = [];
    if (widget.userListType == UserListType.comments) {
      var postModel = usersListVm.postModel[index]!;
      widgets.add(getPostItem(postModel, userModel));
    } else {
      widgets.add(getUserItem(userModel));
    }
    widgets.add(bottomExtraWidget(index));
    return Column(children: widgets);
  }

  Widget getUserItem(UserModel userModel) {
    return SearchedUsersInformationWidget(
      viewModel: usersListVm,
      userModel: userModel,
    );
  }

  Widget getPostItem(PostModel postModel, UserModel userModel) {
    return InkWell(
      onTap: () => usersListVm.navigateToFullScreenView(postModel),
      child: LitePostWidget(
        postModel: postModel,
        userModel: userModel,
      ),
    );
  }

  Widget buildCommentTypeWidget(UserModel userModel, PostModel postModel) =>
      InkWell(
        onTap: () => usersListVm.navigateToFullScreenView(postModel),
        child: LitePostWidget(
          postModel: postModel,
          userModel: userModel,
        ),
      );

  Widget bottomExtraWidget(int index) =>
      usersListVm.usersList.length - 1 == index
          ? Column(
              children: [
                15.0.sizedBoxOnlyHeight,
                CenterDotText().center,
                (context.height / 10).sizedBoxOnlyHeight,
              ],
            )
          : Container();

  AppBar get _appBar => AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () => context.pop,
        ),
        title: Text(
          widget.appBarText,
          style: TextStyle(
            fontSize: context.width / 20,
            color: context.theme.colorScheme.primary,
          ),
        ),
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: Size(context.width, 1),
          child: const Divider(height: 0),
        ),
        iconTheme: IconThemeData(color: context.theme.colorScheme.primary),
      );
}

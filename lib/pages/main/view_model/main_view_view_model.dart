import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
import '../../../app/enums/post_view_type.dart';
import '../../../app/managers/hive_manager.dart';
import '../../../core/base/view_model/base_view_model.dart';
import '../../../core/extensions/int_extensions.dart';
import '../../../core/hive/hive_constants.dart';
import '../../authenticate/authenticate_view.dart';
import '../../authenticate/model/user_model.dart';
import '../../profile/view/profile_view/profile_view.dart';
import '../../search/view/search_view.dart';
import '../view/helper/post_view_type_selector_bottom_sheet.dart';
import '../view/home/view/sub_views/home_view/home_view.dart';
import '../view/main_screen.dart';
part 'main_view_view_model.g.dart';

class MainViewViewModel = _MainViewViewModelBase with _$MainViewViewModel;

abstract class _MainViewViewModelBase extends BaseViewModel with Store {
  @override
  void setContext(context) => this.context = context;
  @override
  BuildContext? context;
  @observable
  int currentIndex = 0;
  @observable
  bool isFabVisible = true;
  @observable
  PostViewType postViewType = PostViewType.FlatView;
  @observable
  UserModel? currentUserModel;
  @observable
  Widget startingPage = Container();
  @action
  Future<void> initalizeStartingPage(Widget page) async {
    startingPage = page;
  }

  final PageController pageController = PageController();
  List<Widget> screens = [
    const HomeView(),
    SearchView(),
  ];

  Future<void> startApp() async {
    if (auth.currentUser != null) {
      currentUserModel =
          await firebaseManager.getAUserInformation(authService.userId!);
      await userManager.getFollowingUsersIds();
      initalizeStartingPage(const MainScreen());
      changePostViewType(await HiveManager.getPostWidgetViewType);
    } else {
      initalizeStartingPage(AuthenticateView());
    }
  }

  @action
  void changePostViewType(bool type) {
    if (type) {
      postViewType = PostViewType.FlatView;
    } else if (postViewType == PostViewType.FlatView) {
      postViewType = PostViewType.CardView;
    }
  }

  bool get isTypeFlatView => postViewType == PostViewType.FlatView;

  @action
  void changeFabVisibility(bool visibility) => isFabVisible = visibility;

  @action
  void changeIndex(int index) {
    pageController.jumpToPage(index);
    switch (index) {
      case 0:
        _homeTabClicked(index);
        break;
      case 1:
        _searchTabClicked(index);
        currentIndex = index;
        break;
      case 2:
        currentIndex = index;
        break;
      case 3:
        currentIndex = index;
        break;
    }
  }

  void navigateToProfileScreen() => customNavigateToPage(
        page: ProfileView(userId: authService.userId!),
        animate: true,
      );

  @observable
  List<String> followingUsersIds = [""];

  @action
  void addToFollowing(String userId) => followingUsersIds.add(userId);
  @action
  void removeFromFollowing(String userId) => followingUsersIds.remove(userId);

  @action
  void updateFollowingUserIds(List<String> followingUsersIds) =>
      this.followingUsersIds = followingUsersIds;

  Future<void> updatePostViewType(bool data) async {
    await hiveHelper.putData<bool>(HiveConstants.BOX_APP_PREFERENCES,
        HiveConstants.KEY_POST_VIEW_TYPE_PREFERENCE, data);
    changePostViewType(data);
  }

  void showPostViewTypeSelector() =>
      PostViewTypeSelectorBottomSheet.show(context!);

  late ScrollController homeViewPostsScrollController;
  late ScrollController exploreViewPostsScrollController;

  void _homeTabClicked(int index) {
    if (currentIndex == 0) {
      sendToFirstIndex(homeViewPostsScrollController);
    }
    currentIndex = index;
  }

  void _searchTabClicked(int index) {
    if (currentIndex == 1) {
      sendToFirstIndex(exploreViewPostsScrollController);
    }
    currentIndex = index;
  }

  void sendToFirstIndex(ScrollController controller) {
    controller.animateTo(
      controller.position.minScrollExtent,
      duration: 300.durationMilliseconds,
      curve: Curves.fastOutSlowIn,
    );
  }
}

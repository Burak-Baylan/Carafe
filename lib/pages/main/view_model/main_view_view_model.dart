import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
import '../../../app/enums/post_view_type.dart';
import '../../../core/base/view_model/base_view_model.dart';
import '../../../core/extensions/int_extensions.dart';
import '../../../core/hive/hive_constants.dart';
import '../../search/view/search_view.dart';
import '../view/helper/widget_view_type_selector_bottom_sheet.dart';
import '../view/home/view/home_view.dart';
part 'main_view_view_model.g.dart';

class MainViewViewModel = _MainViewViewModelBase with _$MainViewViewModel;

abstract class _MainViewViewModelBase extends BaseViewModel with Store {
  @override
  setContext(context) => this.context = context;
  @override
  BuildContext? context;
  @observable
  int currentIndex = 0;
  @observable
  bool isFabVisible = true;
  @observable
  PostViewType postViewType = PostViewType.FlatView;

  final PageController pageController = PageController();
  List<Widget> screens = [
    HomeView(),
    SearchView(),
  ];

  @action
  changePostViewType(bool type) {
    if (type) {
      postViewType = PostViewType.FlatView;
    } else if (postViewType == PostViewType.FlatView) {
      postViewType = PostViewType.CardView;
    }
  }

  @action
  changeFabVisibility(bool visibility) => isFabVisible = visibility;

  @action
  changeIndex(int index) {
    pageController.jumpToPage(index);
    switch (index) {
      case 0:
        _homeTabClicked(index);
        break;
      case 1:
        _searchTabClicked(index);
        break;
      case 2:
        currentIndex = index;
        break;
      case 3:
        currentIndex = index;
        break;
    }
  }

  @observable
  List<String> followingUsersIds = [""];

  @action
  updateFollowingUserIds(List<String> followingUsersIds) =>
      this.followingUsersIds = followingUsersIds;

  Future<void> updatePostViewType(bool data) async {
    await hiveHelper.putData<bool>(HiveConstants.BOX_APP_PREFERENCES,
        HiveConstants.KEY_POST_VIEW_TYPE_PREFERENCE, data);
    changePostViewType(data);
  }

  showPostViewTypeSelector() =>
      WidgetViewTypeSelectorBottomSheet.show(context!);

  late ScrollController homeViewPostsScrollController;

  void _homeTabClicked(int index) {
    if (currentIndex == 0) {
      homeViewPostsScrollController.animateTo(
        homeViewPostsScrollController.position.minScrollExtent,
        duration: 300.durationMilliseconds,
        curve: Curves.fastOutSlowIn,
      );
    }
    currentIndex = index;
  }

  void _searchTabClicked(int index) {
    currentIndex = index;
  }
}

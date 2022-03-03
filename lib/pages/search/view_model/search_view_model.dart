import 'package:Carafe/core/firebase/firestore/manager/post_manager/post_manager.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import '../../../core/base/view_model/base_view_model.dart';
import '../../../main.dart';
import '../../authenticate/model/user_model.dart';
import '../../main/model/post_model.dart';
part 'search_view_model.g.dart';

class SearchViewModel = _SearchViewModelBase with _$SearchViewModel;

abstract class _SearchViewModelBase extends BaseViewModel with Store {
  @override
  BuildContext? context;

  @override
  setContext(BuildContext context) {
    this.context = context;
    postManager = firebasePostManager;
  }

  @observable
  List<PostModel> posts = [];
  @observable
  List<UserModel> searcedPople = [];
  @observable
  bool isSearching = false;
  @observable
  ScrollPhysics? searchPeopleScrollPhysics;
  ScrollController searchPeopleScrollController = ScrollController();
  late Future<List<PostModel>> mostLikedPostsFuture;
  FocusNode searchFocusNode = FocusNode();
  TextEditingController searchController = TextEditingController();
  String previousSearchText = '';
  PageController pageController = PageController();
  late FirebasePostManager postManager;

  @action
  void changePostsScrollable(ScrollPhysics? physics) =>
      searchPeopleScrollPhysics = physics;
  @action
  void lockScrollable() =>
      changePostsScrollable(const NeverScrollableScrollPhysics());
  @action
  openScrollable() => changePostsScrollable(null);
  @action
  void changeSearchingState() {
    isSearching = !isSearching;
    if (isSearching) {
      searchFocusNode.requestFocus();
      mainVm.changeFabVisibility(false);
      pageController.jumpToPage(1);
    } else {
      searchFocusNode.unfocus();
      mainVm.changeFabVisibility(true);
      pageController.jumpToPage(0);
    }
  }

  void clearSearchText() {
    searchController.clear();
    searcedPople.clear();
    lockScrollable();
    openScrollable();
  }

  bool searching = false;

  @action
  Future<void> searchPeoples(String text) async {
    if (text == previousSearchText) return;
    previousSearchText = text;
    searching = true;
    lockScrollable();
    searcedPople.clear();
    if (text.isEmpty) {
      searching = false;
      openScrollable();
      return;
    }
    var ref = firebaseConstants.getUserSearchQueryWithLimit(text.toLowerCase());
    var rawData = await firebaseService.getQuery(ref);
    searcedPople.clear();
    if (rawData.error != null) {
      showAlert("Error", 'Something went wrong.', context: context!);
    }
    List<UserModel> verifiedList = [];
    List<UserModel> notVerifiedList = [];
    for (var i in rawData.data!.docs) {
      var userModel = UserModel.fromJson(i.data());
      if (userModel.verified) {
        verifiedList.add(userModel);
      } else {
        notVerifiedList.add(userModel);
      }
    }
    searcedPople = verifiedList + notVerifiedList;
    searching = false;
    openScrollable();
  }
}

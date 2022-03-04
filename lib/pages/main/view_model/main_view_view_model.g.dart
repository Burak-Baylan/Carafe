// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_view_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MainViewViewModel on _MainViewViewModelBase, Store {
  final _$currentIndexAtom = Atom(name: '_MainViewViewModelBase.currentIndex');

  @override
  int get currentIndex {
    _$currentIndexAtom.reportRead();
    return super.currentIndex;
  }

  @override
  set currentIndex(int value) {
    _$currentIndexAtom.reportWrite(value, super.currentIndex, () {
      super.currentIndex = value;
    });
  }

  final _$isFabVisibleAtom = Atom(name: '_MainViewViewModelBase.isFabVisible');

  @override
  bool get isFabVisible {
    _$isFabVisibleAtom.reportRead();
    return super.isFabVisible;
  }

  @override
  set isFabVisible(bool value) {
    _$isFabVisibleAtom.reportWrite(value, super.isFabVisible, () {
      super.isFabVisible = value;
    });
  }

  final _$postViewTypeAtom = Atom(name: '_MainViewViewModelBase.postViewType');

  @override
  PostViewType get postViewType {
    _$postViewTypeAtom.reportRead();
    return super.postViewType;
  }

  @override
  set postViewType(PostViewType value) {
    _$postViewTypeAtom.reportWrite(value, super.postViewType, () {
      super.postViewType = value;
    });
  }

  final _$currentUserModelAtom =
      Atom(name: '_MainViewViewModelBase.currentUserModel');

  @override
  UserModel? get currentUserModel {
    _$currentUserModelAtom.reportRead();
    return super.currentUserModel;
  }

  @override
  set currentUserModel(UserModel? value) {
    _$currentUserModelAtom.reportWrite(value, super.currentUserModel, () {
      super.currentUserModel = value;
    });
  }

  final _$startingPageAtom = Atom(name: '_MainViewViewModelBase.startingPage');

  @override
  Widget get startingPage {
    _$startingPageAtom.reportRead();
    return super.startingPage;
  }

  @override
  set startingPage(Widget value) {
    _$startingPageAtom.reportWrite(value, super.startingPage, () {
      super.startingPage = value;
    });
  }

  final _$followingUsersIdsAtom =
      Atom(name: '_MainViewViewModelBase.followingUsersIds');

  @override
  List<String> get followingUsersIds {
    _$followingUsersIdsAtom.reportRead();
    return super.followingUsersIds;
  }

  @override
  set followingUsersIds(List<String> value) {
    _$followingUsersIdsAtom.reportWrite(value, super.followingUsersIds, () {
      super.followingUsersIds = value;
    });
  }

  final _$initalizeStartingPageAsyncAction =
      AsyncAction('_MainViewViewModelBase.initalizeStartingPage');

  @override
  Future<void> initalizeStartingPage(Widget page) {
    return _$initalizeStartingPageAsyncAction
        .run(() => super.initalizeStartingPage(page));
  }

  final _$_MainViewViewModelBaseActionController =
      ActionController(name: '_MainViewViewModelBase');

  @override
  void changePostViewType(bool type) {
    final _$actionInfo = _$_MainViewViewModelBaseActionController.startAction(
        name: '_MainViewViewModelBase.changePostViewType');
    try {
      return super.changePostViewType(type);
    } finally {
      _$_MainViewViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeFabVisibility(bool visibility) {
    final _$actionInfo = _$_MainViewViewModelBaseActionController.startAction(
        name: '_MainViewViewModelBase.changeFabVisibility');
    try {
      return super.changeFabVisibility(visibility);
    } finally {
      _$_MainViewViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeIndex(int index) {
    final _$actionInfo = _$_MainViewViewModelBaseActionController.startAction(
        name: '_MainViewViewModelBase.changeIndex');
    try {
      return super.changeIndex(index);
    } finally {
      _$_MainViewViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addToFollowing(String userId) {
    final _$actionInfo = _$_MainViewViewModelBaseActionController.startAction(
        name: '_MainViewViewModelBase.addToFollowing');
    try {
      return super.addToFollowing(userId);
    } finally {
      _$_MainViewViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeFromFollowing(String userId) {
    final _$actionInfo = _$_MainViewViewModelBaseActionController.startAction(
        name: '_MainViewViewModelBase.removeFromFollowing');
    try {
      return super.removeFromFollowing(userId);
    } finally {
      _$_MainViewViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateFollowingUserIds(List<String> followingUsersIds) {
    final _$actionInfo = _$_MainViewViewModelBaseActionController.startAction(
        name: '_MainViewViewModelBase.updateFollowingUserIds');
    try {
      return super.updateFollowingUserIds(followingUsersIds);
    } finally {
      _$_MainViewViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentIndex: ${currentIndex},
isFabVisible: ${isFabVisible},
postViewType: ${postViewType},
currentUserModel: ${currentUserModel},
startingPage: ${startingPage},
followingUsersIds: ${followingUsersIds}
    ''';
  }
}

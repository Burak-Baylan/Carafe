// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ProfileViewModel on _ProfileViewModelBase, Store {
  final _$userModelAtom = Atom(name: '_ProfileViewModelBase.userModel');

  @override
  UserModel? get userModel {
    _$userModelAtom.reportRead();
    return super.userModel;
  }

  @override
  set userModel(UserModel? value) {
    _$userModelAtom.reportWrite(value, super.userModel, () {
      super.userModel = value;
    });
  }

  final _$heightAtom = Atom(name: '_ProfileViewModelBase.height');

  @override
  double get height {
    _$heightAtom.reportRead();
    return super.height;
  }

  @override
  set height(double value) {
    _$heightAtom.reportWrite(value, super.height, () {
      super.height = value;
    });
  }

  final _$tabBarVisibilityAtom =
      Atom(name: '_ProfileViewModelBase.tabBarVisibility');

  @override
  bool get tabBarVisibility {
    _$tabBarVisibilityAtom.reportRead();
    return super.tabBarVisibility;
  }

  @override
  set tabBarVisibility(bool value) {
    _$tabBarVisibilityAtom.reportWrite(value, super.tabBarVisibility, () {
      super.tabBarVisibility = value;
    });
  }

  final _$isUserFollowingAtom =
      Atom(name: '_ProfileViewModelBase.isUserFollowing');

  @override
  bool? get isUserFollowing {
    _$isUserFollowingAtom.reportRead();
    return super.isUserFollowing;
  }

  @override
  set isUserFollowing(bool? value) {
    _$isUserFollowingAtom.reportWrite(value, super.isUserFollowing, () {
      super.isUserFollowing = value;
    });
  }

  final _$profileOwnerAtom = Atom(name: '_ProfileViewModelBase.profileOwner');

  @override
  bool get profileOwner {
    _$profileOwnerAtom.reportRead();
    return super.profileOwner;
  }

  @override
  set profileOwner(bool value) {
    _$profileOwnerAtom.reportWrite(value, super.profileOwner, () {
      super.profileOwner = value;
    });
  }

  final _$cartPhysicsAtom = Atom(name: '_ProfileViewModelBase.cartPhysics');

  @override
  ScrollPhysics? get cartPhysics {
    _$cartPhysicsAtom.reportRead();
    return super.cartPhysics;
  }

  @override
  set cartPhysics(ScrollPhysics? value) {
    _$cartPhysicsAtom.reportWrite(value, super.cartPhysics, () {
      super.cartPhysics = value;
    });
  }

  final _$pinnedPostAtom = Atom(name: '_ProfileViewModelBase.pinnedPost');

  @override
  PostModel? get pinnedPost {
    _$pinnedPostAtom.reportRead();
    return super.pinnedPost;
  }

  @override
  set pinnedPost(PostModel? value) {
    _$pinnedPostAtom.reportWrite(value, super.pinnedPost, () {
      super.pinnedPost = value;
    });
  }

  final _$followersCountAtom =
      Atom(name: '_ProfileViewModelBase.followersCount');

  @override
  int get followersCount {
    _$followersCountAtom.reportRead();
    return super.followersCount;
  }

  @override
  set followersCount(int value) {
    _$followersCountAtom.reportWrite(value, super.followersCount, () {
      super.followersCount = value;
    });
  }

  final _$followingCountAtom =
      Atom(name: '_ProfileViewModelBase.followingCount');

  @override
  int get followingCount {
    _$followingCountAtom.reportRead();
    return super.followingCount;
  }

  @override
  set followingCount(int value) {
    _$followingCountAtom.reportWrite(value, super.followingCount, () {
      super.followingCount = value;
    });
  }

  final _$ppUrlAtom = Atom(name: '_ProfileViewModelBase.ppUrl');

  @override
  String? get ppUrl {
    _$ppUrlAtom.reportRead();
    return super.ppUrl;
  }

  @override
  set ppUrl(String? value) {
    _$ppUrlAtom.reportWrite(value, super.ppUrl, () {
      super.ppUrl = value;
    });
  }

  final _$usernameAtom = Atom(name: '_ProfileViewModelBase.username');

  @override
  String get username {
    _$usernameAtom.reportRead();
    return super.username;
  }

  @override
  set username(String value) {
    _$usernameAtom.reportWrite(value, super.username, () {
      super.username = value;
    });
  }

  final _$displayNameAtom = Atom(name: '_ProfileViewModelBase.displayName');

  @override
  String get displayName {
    _$displayNameAtom.reportRead();
    return super.displayName;
  }

  @override
  set displayName(String value) {
    _$displayNameAtom.reportWrite(value, super.displayName, () {
      super.displayName = value;
    });
  }

  final _$descriptionAtom = Atom(name: '_ProfileViewModelBase.description');

  @override
  String? get description {
    _$descriptionAtom.reportRead();
    return super.description;
  }

  @override
  set description(String? value) {
    _$descriptionAtom.reportWrite(value, super.description, () {
      super.description = value;
    });
  }

  final _$websiteAtom = Atom(name: '_ProfileViewModelBase.website');

  @override
  String? get website {
    _$websiteAtom.reportRead();
    return super.website;
  }

  @override
  set website(String? value) {
    _$websiteAtom.reportWrite(value, super.website, () {
      super.website = value;
    });
  }

  final _$birthDateAtom = Atom(name: '_ProfileViewModelBase.birthDate');

  @override
  Timestamp? get birthDate {
    _$birthDateAtom.reportRead();
    return super.birthDate;
  }

  @override
  set birthDate(Timestamp? value) {
    _$birthDateAtom.reportWrite(value, super.birthDate, () {
      super.birthDate = value;
    });
  }

  final _$userPostsLengthAtom =
      Atom(name: '_ProfileViewModelBase.userPostsLength');

  @override
  int get userPostsLength {
    _$userPostsLengthAtom.reportRead();
    return super.userPostsLength;
  }

  @override
  set userPostsLength(int value) {
    _$userPostsLengthAtom.reportWrite(value, super.userPostsLength, () {
      super.userPostsLength = value;
    });
  }

  final _$initializeInformationsAsyncAction =
      AsyncAction('_ProfileViewModelBase.initializeInformations');

  @override
  Future<bool> initializeInformations() {
    return _$initializeInformationsAsyncAction
        .run(() => super.initializeInformations());
  }

  final _$followButtonClickedAsyncAction =
      AsyncAction('_ProfileViewModelBase.followButtonClicked');

  @override
  Future<dynamic> followButtonClicked(ProfileViewModel profileViewModel) {
    return _$followButtonClickedAsyncAction
        .run(() => super.followButtonClicked(profileViewModel));
  }

  final _$followUserAsyncAction =
      AsyncAction('_ProfileViewModelBase.followUser');

  @override
  Future<dynamic> followUser() {
    return _$followUserAsyncAction.run(() => super.followUser());
  }

  final _$unfollowUserAsyncAction =
      AsyncAction('_ProfileViewModelBase.unfollowUser');

  @override
  Future<dynamic> unfollowUser() {
    return _$unfollowUserAsyncAction.run(() => super.unfollowUser());
  }

  final _$getUserPinnedPostAsyncAction =
      AsyncAction('_ProfileViewModelBase.getUserPinnedPost');

  @override
  Future<PostModel?> getUserPinnedPost() {
    return _$getUserPinnedPostAsyncAction.run(() => super.getUserPinnedPost());
  }

  final _$_ProfileViewModelBaseActionController =
      ActionController(name: '_ProfileViewModelBase');

  @override
  dynamic changeTabBarVisibility() {
    final _$actionInfo = _$_ProfileViewModelBaseActionController.startAction(
        name: '_ProfileViewModelBase.changeTabBarVisibility');
    try {
      return super.changeTabBarVisibility();
    } finally {
      _$_ProfileViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic updateHeight(double height) {
    final _$actionInfo = _$_ProfileViewModelBaseActionController.startAction(
        name: '_ProfileViewModelBase.updateHeight');
    try {
      return super.updateHeight(height);
    } finally {
      _$_ProfileViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic cartScrollable(ScrollPhysics? physics) {
    final _$actionInfo = _$_ProfileViewModelBaseActionController.startAction(
        name: '_ProfileViewModelBase.cartScrollable');
    try {
      return super.cartScrollable(physics);
    } finally {
      _$_ProfileViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
userModel: ${userModel},
height: ${height},
tabBarVisibility: ${tabBarVisibility},
isUserFollowing: ${isUserFollowing},
profileOwner: ${profileOwner},
cartPhysics: ${cartPhysics},
pinnedPost: ${pinnedPost},
followersCount: ${followersCount},
followingCount: ${followingCount},
ppUrl: ${ppUrl},
username: ${username},
displayName: ${displayName},
description: ${description},
website: ${website},
birthDate: ${birthDate},
userPostsLength: ${userPostsLength}
    ''';
  }
}

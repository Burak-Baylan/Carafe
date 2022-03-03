// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users_profile_other_shares_page_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$UsersProfileOtherSharesPageViewModel
    on _UsersProfileOtherSharesPageViewModelBase, Store {
  final _$mediaPostsScrollPhysicsAtom = Atom(
      name:
          '_UsersProfileOtherSharesPageViewModelBase.mediaPostsScrollPhysics');

  @override
  ScrollPhysics? get mediaPostsScrollPhysics {
    _$mediaPostsScrollPhysicsAtom.reportRead();
    return super.mediaPostsScrollPhysics;
  }

  @override
  set mediaPostsScrollPhysics(ScrollPhysics? value) {
    _$mediaPostsScrollPhysicsAtom
        .reportWrite(value, super.mediaPostsScrollPhysics, () {
      super.mediaPostsScrollPhysics = value;
    });
  }

  final _$likedPostsScrollPhysicsAtom = Atom(
      name:
          '_UsersProfileOtherSharesPageViewModelBase.likedPostsScrollPhysics');

  @override
  ScrollPhysics? get likedPostsScrollPhysics {
    _$likedPostsScrollPhysicsAtom.reportRead();
    return super.likedPostsScrollPhysics;
  }

  @override
  set likedPostsScrollPhysics(ScrollPhysics? value) {
    _$likedPostsScrollPhysicsAtom
        .reportWrite(value, super.likedPostsScrollPhysics, () {
      super.likedPostsScrollPhysics = value;
    });
  }

  final _$getLikedPostsAsyncAction =
      AsyncAction('_UsersProfileOtherSharesPageViewModelBase.getLikedPosts');

  @override
  Future<void> getLikedPosts() {
    return _$getLikedPostsAsyncAction.run(() => super.getLikedPosts());
  }

  final _$getMoreLikedPostsAsyncAction = AsyncAction(
      '_UsersProfileOtherSharesPageViewModelBase.getMoreLikedPosts');

  @override
  Future<void> getMoreLikedPosts() {
    return _$getMoreLikedPostsAsyncAction.run(() => super.getMoreLikedPosts());
  }

  final _$_UsersProfileOtherSharesPageViewModelBaseActionController =
      ActionController(name: '_UsersProfileOtherSharesPageViewModelBase');

  @override
  void changeMediaPostsPhysics(ScrollPhysics physics) {
    final _$actionInfo =
        _$_UsersProfileOtherSharesPageViewModelBaseActionController.startAction(
            name:
                '_UsersProfileOtherSharesPageViewModelBase.changeMediaPostsPhysics');
    try {
      return super.changeMediaPostsPhysics(physics);
    } finally {
      _$_UsersProfileOtherSharesPageViewModelBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void lockMediaPostsPhysics() {
    final _$actionInfo =
        _$_UsersProfileOtherSharesPageViewModelBaseActionController.startAction(
            name:
                '_UsersProfileOtherSharesPageViewModelBase.lockMediaPostsPhysics');
    try {
      return super.lockMediaPostsPhysics();
    } finally {
      _$_UsersProfileOtherSharesPageViewModelBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void openMediaPostsPhysics() {
    final _$actionInfo =
        _$_UsersProfileOtherSharesPageViewModelBaseActionController.startAction(
            name:
                '_UsersProfileOtherSharesPageViewModelBase.openMediaPostsPhysics');
    try {
      return super.openMediaPostsPhysics();
    } finally {
      _$_UsersProfileOtherSharesPageViewModelBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void changeLikedPostsPhysics(ScrollPhysics physics) {
    final _$actionInfo =
        _$_UsersProfileOtherSharesPageViewModelBaseActionController.startAction(
            name:
                '_UsersProfileOtherSharesPageViewModelBase.changeLikedPostsPhysics');
    try {
      return super.changeLikedPostsPhysics(physics);
    } finally {
      _$_UsersProfileOtherSharesPageViewModelBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void lockLikedPostsPhysics() {
    final _$actionInfo =
        _$_UsersProfileOtherSharesPageViewModelBaseActionController.startAction(
            name:
                '_UsersProfileOtherSharesPageViewModelBase.lockLikedPostsPhysics');
    try {
      return super.lockLikedPostsPhysics();
    } finally {
      _$_UsersProfileOtherSharesPageViewModelBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void openLikedPostsPhysics() {
    final _$actionInfo =
        _$_UsersProfileOtherSharesPageViewModelBaseActionController.startAction(
            name:
                '_UsersProfileOtherSharesPageViewModelBase.openLikedPostsPhysics');
    try {
      return super.openLikedPostsPhysics();
    } finally {
      _$_UsersProfileOtherSharesPageViewModelBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
mediaPostsScrollPhysics: ${mediaPostsScrollPhysics},
likedPostsScrollPhysics: ${likedPostsScrollPhysics}
    ''';
  }
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saved_posts_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SavedPostsViewModel on _SavedPostsViewModelBase, Store {
  final _$postsScrollableAtom =
      Atom(name: '_SavedPostsViewModelBase.postsScrollable');

  @override
  ScrollPhysics? get postsScrollable {
    _$postsScrollableAtom.reportRead();
    return super.postsScrollable;
  }

  @override
  set postsScrollable(ScrollPhysics? value) {
    _$postsScrollableAtom.reportWrite(value, super.postsScrollable, () {
      super.postsScrollable = value;
    });
  }

  final _$showExploreWidgetAtom =
      Atom(name: '_SavedPostsViewModelBase.showExploreWidget');

  @override
  bool get showExploreWidget {
    _$showExploreWidgetAtom.reportRead();
    return super.showExploreWidget;
  }

  @override
  set showExploreWidget(bool value) {
    _$showExploreWidgetAtom.reportWrite(value, super.showExploreWidget, () {
      super.showExploreWidget = value;
    });
  }

  final _$getSavedPostsAsyncAction =
      AsyncAction('_SavedPostsViewModelBase.getSavedPosts');

  @override
  Future<List<PostModel>?> getSavedPosts() {
    return _$getSavedPostsAsyncAction.run(() => super.getSavedPosts());
  }

  final _$_SavedPostsViewModelBaseActionController =
      ActionController(name: '_SavedPostsViewModelBase');

  @override
  void changePostsScrollable(ScrollPhysics physics) {
    final _$actionInfo = _$_SavedPostsViewModelBaseActionController.startAction(
        name: '_SavedPostsViewModelBase.changePostsScrollable');
    try {
      return super.changePostsScrollable(physics);
    } finally {
      _$_SavedPostsViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void lockScrollable() {
    final _$actionInfo = _$_SavedPostsViewModelBaseActionController.startAction(
        name: '_SavedPostsViewModelBase.lockScrollable');
    try {
      return super.lockScrollable();
    } finally {
      _$_SavedPostsViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic openScrollable() {
    final _$actionInfo = _$_SavedPostsViewModelBaseActionController.startAction(
        name: '_SavedPostsViewModelBase.openScrollable');
    try {
      return super.openScrollable();
    } finally {
      _$_SavedPostsViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
postsScrollable: ${postsScrollable},
showExploreWidget: ${showExploreWidget}
    ''';
  }
}

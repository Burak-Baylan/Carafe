// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'explore_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ExploreViewModel on _ExploreViewModelBase, Store {
  final _$postsScrollableAtom =
      Atom(name: '_ExploreViewModelBase.postsScrollable');

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

  final _$getPostsAsyncAction = AsyncAction('_ExploreViewModelBase.getPosts');

  @override
  Future<List<PostModel>?> getPosts(String categoryName) {
    return _$getPostsAsyncAction.run(() => super.getPosts(categoryName));
  }

  final _$_ExploreViewModelBaseActionController =
      ActionController(name: '_ExploreViewModelBase');

  @override
  void changePostsScrollable(ScrollPhysics physics) {
    final _$actionInfo = _$_ExploreViewModelBaseActionController.startAction(
        name: '_ExploreViewModelBase.changePostsScrollable');
    try {
      return super.changePostsScrollable(physics);
    } finally {
      _$_ExploreViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void lockScrollable() {
    final _$actionInfo = _$_ExploreViewModelBaseActionController.startAction(
        name: '_ExploreViewModelBase.lockScrollable');
    try {
      return super.lockScrollable();
    } finally {
      _$_ExploreViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void openScrollable() {
    final _$actionInfo = _$_ExploreViewModelBaseActionController.startAction(
        name: '_ExploreViewModelBase.openScrollable');
    try {
      return super.openScrollable();
    } finally {
      _$_ExploreViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
postsScrollable: ${postsScrollable}
    ''';
  }
}

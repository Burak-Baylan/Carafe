// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CategoryViewModel on _CategoryViewModelBase, Store {
  final _$postsAtom = Atom(name: '_CategoryViewModelBase.posts');

  @override
  List<PostModel> get posts {
    _$postsAtom.reportRead();
    return super.posts;
  }

  @override
  set posts(List<PostModel> value) {
    _$postsAtom.reportWrite(value, super.posts, () {
      super.posts = value;
    });
  }

  final _$postsScrollableAtom =
      Atom(name: '_CategoryViewModelBase.postsScrollable');

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

  final _$getPostsAsyncAction = AsyncAction('_CategoryViewModelBase.getPosts');

  @override
  Future<void> getPosts() {
    return _$getPostsAsyncAction.run(() => super.getPosts());
  }

  final _$loadMorePostsAsyncAction =
      AsyncAction('_CategoryViewModelBase.loadMorePosts');

  @override
  Future<void> loadMorePosts() {
    return _$loadMorePostsAsyncAction.run(() => super.loadMorePosts());
  }

  final _$_CategoryViewModelBaseActionController =
      ActionController(name: '_CategoryViewModelBase');

  @override
  void changePostsScrollable(ScrollPhysics physics) {
    final _$actionInfo = _$_CategoryViewModelBaseActionController.startAction(
        name: '_CategoryViewModelBase.changePostsScrollable');
    try {
      return super.changePostsScrollable(physics);
    } finally {
      _$_CategoryViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void lockScrollable() {
    final _$actionInfo = _$_CategoryViewModelBaseActionController.startAction(
        name: '_CategoryViewModelBase.lockScrollable');
    try {
      return super.lockScrollable();
    } finally {
      _$_CategoryViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void openScrollable() {
    final _$actionInfo = _$_CategoryViewModelBaseActionController.startAction(
        name: '_CategoryViewModelBase.openScrollable');
    try {
      return super.openScrollable();
    } finally {
      _$_CategoryViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
posts: ${posts},
postsScrollable: ${postsScrollable}
    ''';
  }
}

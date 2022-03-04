// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeViewModel on _HomeViewModelBase, Store {
  final _$postsAtom = Atom(name: '_HomeViewModelBase.posts');

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
      Atom(name: '_HomeViewModelBase.postsScrollable');

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
      Atom(name: '_HomeViewModelBase.showExploreWidget');

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

  final _$getPostsAsyncAction = AsyncAction('_HomeViewModelBase.getPosts');

  @override
  Future<List<PostModel>> getPosts() {
    return _$getPostsAsyncAction.run(() => super.getPosts());
  }

  final _$_HomeViewModelBaseActionController =
      ActionController(name: '_HomeViewModelBase');

  @override
  void changePostsScrollable(ScrollPhysics physics) {
    final _$actionInfo = _$_HomeViewModelBaseActionController.startAction(
        name: '_HomeViewModelBase.changePostsScrollable');
    try {
      return super.changePostsScrollable(physics);
    } finally {
      _$_HomeViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void lockScrollable() {
    final _$actionInfo = _$_HomeViewModelBaseActionController.startAction(
        name: '_HomeViewModelBase.lockScrollable');
    try {
      return super.lockScrollable();
    } finally {
      _$_HomeViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic openScrollable() {
    final _$actionInfo = _$_HomeViewModelBaseActionController.startAction(
        name: '_HomeViewModelBase.openScrollable');
    try {
      return super.openScrollable();
    } finally {
      _$_HomeViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
posts: ${posts},
postsScrollable: ${postsScrollable},
showExploreWidget: ${showExploreWidget}
    ''';
  }
}

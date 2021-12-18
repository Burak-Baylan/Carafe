// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeViewModel on _HomeViewModelBase, Store {
  final _$fullScreenImageIndexAtom =
      Atom(name: '_HomeViewModelBase.fullScreenImageIndex');

  @override
  int get fullScreenImageIndex {
    _$fullScreenImageIndexAtom.reportRead();
    return super.fullScreenImageIndex;
  }

  @override
  set fullScreenImageIndex(int value) {
    _$fullScreenImageIndexAtom.reportWrite(value, super.fullScreenImageIndex,
        () {
      super.fullScreenImageIndex = value;
    });
  }

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

  final _$homeBodyAtom = Atom(name: '_HomeViewModelBase.homeBody');

  @override
  Widget get homeBody {
    _$homeBodyAtom.reportRead();
    return super.homeBody;
  }

  @override
  set homeBody(Widget value) {
    _$homeBodyAtom.reportWrite(value, super.homeBody, () {
      super.homeBody = value;
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

  final _$moreImageLoadingProgressStateAtom =
      Atom(name: '_HomeViewModelBase.moreImageLoadingProgressState');

  @override
  bool get moreImageLoadingProgressState {
    _$moreImageLoadingProgressStateAtom.reportRead();
    return super.moreImageLoadingProgressState;
  }

  @override
  set moreImageLoadingProgressState(bool value) {
    _$moreImageLoadingProgressStateAtom
        .reportWrite(value, super.moreImageLoadingProgressState, () {
      super.moreImageLoadingProgressState = value;
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
  dynamic changeHomeBody(Widget body) {
    final _$actionInfo = _$_HomeViewModelBaseActionController.startAction(
        name: '_HomeViewModelBase.changeHomeBody');
    try {
      return super.changeHomeBody(body);
    } finally {
      _$_HomeViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeFullScreenImageIndex(int index) {
    final _$actionInfo = _$_HomeViewModelBaseActionController.startAction(
        name: '_HomeViewModelBase.changeFullScreenImageIndex');
    try {
      return super.changeFullScreenImageIndex(index);
    } finally {
      _$_HomeViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changePostsScrollable(ScrollPhysics? physics) {
    final _$actionInfo = _$_HomeViewModelBaseActionController.startAction(
        name: '_HomeViewModelBase.changePostsScrollable');
    try {
      return super.changePostsScrollable(physics);
    } finally {
      _$_HomeViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic lockScrollable() {
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
  dynamic changeMoreImageLoadingProgressState() {
    final _$actionInfo = _$_HomeViewModelBaseActionController.startAction(
        name: '_HomeViewModelBase.changeMoreImageLoadingProgressState');
    try {
      return super.changeMoreImageLoadingProgressState();
    } finally {
      _$_HomeViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
fullScreenImageIndex: ${fullScreenImageIndex},
posts: ${posts},
homeBody: ${homeBody},
postsScrollable: ${postsScrollable},
moreImageLoadingProgressState: ${moreImageLoadingProgressState}
    ''';
  }
}
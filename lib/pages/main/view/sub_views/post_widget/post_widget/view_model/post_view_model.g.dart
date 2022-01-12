// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PostViewModel on _PostViewModelBase, Store {
  final _$moreCommentsLoadingProgressStateAtom =
      Atom(name: '_PostViewModelBase.moreCommentsLoadingProgressState');

  @override
  bool get moreCommentsLoadingProgressState {
    _$moreCommentsLoadingProgressStateAtom.reportRead();
    return super.moreCommentsLoadingProgressState;
  }

  @override
  set moreCommentsLoadingProgressState(bool value) {
    _$moreCommentsLoadingProgressStateAtom
        .reportWrite(value, super.moreCommentsLoadingProgressState, () {
      super.moreCommentsLoadingProgressState = value;
    });
  }

  final _$commentsScrollableAtom =
      Atom(name: '_PostViewModelBase.commentsScrollable');

  @override
  ScrollPhysics? get commentsScrollable {
    _$commentsScrollableAtom.reportRead();
    return super.commentsScrollable;
  }

  @override
  set commentsScrollable(ScrollPhysics? value) {
    _$commentsScrollableAtom.reportWrite(value, super.commentsScrollable, () {
      super.commentsScrollable = value;
    });
  }

  final _$likeIconAtom = Atom(name: '_PostViewModelBase.likeIcon');

  @override
  IconData get likeIcon {
    _$likeIconAtom.reportRead();
    return super.likeIcon;
  }

  @override
  set likeIcon(IconData value) {
    _$likeIconAtom.reportWrite(value, super.likeIcon, () {
      super.likeIcon = value;
    });
  }

  final _$postSaveIconAtom = Atom(name: '_PostViewModelBase.postSaveIcon');

  @override
  IconData get postSaveIcon {
    _$postSaveIconAtom.reportRead();
    return super.postSaveIcon;
  }

  @override
  set postSaveIcon(IconData value) {
    _$postSaveIconAtom.reportWrite(value, super.postSaveIcon, () {
      super.postSaveIcon = value;
    });
  }

  final _$commentsAtom = Atom(name: '_PostViewModelBase.comments');

  @override
  List<PostModel> get comments {
    _$commentsAtom.reportRead();
    return super.comments;
  }

  @override
  set comments(List<PostModel> value) {
    _$commentsAtom.reportWrite(value, super.comments, () {
      super.comments = value;
    });
  }

  final _$findLikeIconAsyncAction =
      AsyncAction('_PostViewModelBase.findLikeIcon');

  @override
  Future findLikeIcon() {
    return _$findLikeIconAsyncAction.run(() => super.findLikeIcon());
  }

  final _$findPostSaveIconAsyncAction =
      AsyncAction('_PostViewModelBase.findPostSaveIcon');

  @override
  Future findPostSaveIcon() {
    return _$findPostSaveIconAsyncAction.run(() => super.findPostSaveIcon());
  }

  final _$likeAsyncAction = AsyncAction('_PostViewModelBase.like');

  @override
  Future<dynamic> like() {
    return _$likeAsyncAction.run(() => super.like());
  }

  final _$saveAsyncAction = AsyncAction('_PostViewModelBase.save');

  @override
  Future<dynamic> save() {
    return _$saveAsyncAction.run(() => super.save());
  }

  final _$getCommentsAsyncAction =
      AsyncAction('_PostViewModelBase.getComments');

  @override
  Future<List<PostModel>> getComments() {
    return _$getCommentsAsyncAction.run(() => super.getComments());
  }

  final _$loadMoreCommentsAsyncAction =
      AsyncAction('_PostViewModelBase.loadMoreComments');

  @override
  Future<void> loadMoreComments() {
    return _$loadMoreCommentsAsyncAction.run(() => super.loadMoreComments());
  }

  final _$_PostViewModelBaseActionController =
      ActionController(name: '_PostViewModelBase');

  @override
  dynamic changeMoreCommentsLoadingProgressState() {
    final _$actionInfo = _$_PostViewModelBaseActionController.startAction(
        name: '_PostViewModelBase.changeMoreCommentsLoadingProgressState');
    try {
      return super.changeMoreCommentsLoadingProgressState();
    } finally {
      _$_PostViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeCommentsScrollable(ScrollPhysics? physics) {
    final _$actionInfo = _$_PostViewModelBaseActionController.startAction(
        name: '_PostViewModelBase.changeCommentsScrollable');
    try {
      return super.changeCommentsScrollable(physics);
    } finally {
      _$_PostViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic lockScrollable() {
    final _$actionInfo = _$_PostViewModelBaseActionController.startAction(
        name: '_PostViewModelBase.lockScrollable');
    try {
      return super.lockScrollable();
    } finally {
      _$_PostViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic openScrollable() {
    final _$actionInfo = _$_PostViewModelBaseActionController.startAction(
        name: '_PostViewModelBase.openScrollable');
    try {
      return super.openScrollable();
    } finally {
      _$_PostViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
moreCommentsLoadingProgressState: ${moreCommentsLoadingProgressState},
commentsScrollable: ${commentsScrollable},
likeIcon: ${likeIcon},
postSaveIcon: ${postSaveIcon},
comments: ${comments}
    ''';
  }
}

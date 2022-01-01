// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PostViewModel on _PostViewModelBase, Store {
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

  @override
  String toString() {
    return '''
likeIcon: ${likeIcon},
postSaveIcon: ${postSaveIcon}
    ''';
  }
}

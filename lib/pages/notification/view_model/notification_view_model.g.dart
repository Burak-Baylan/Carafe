// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$NotificationViewModel on _NotificationViewModelBase, Store {
  final _$postsScrollableAtom =
      Atom(name: '_NotificationViewModelBase.postsScrollable');

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

  final _$getNotificationsAsyncAction =
      AsyncAction('_NotificationViewModelBase.getNotifications');

  @override
  Future<void> getNotifications() {
    return _$getNotificationsAsyncAction.run(() => super.getNotifications());
  }

  final _$loadMoreNotificationsAsyncAction =
      AsyncAction('_NotificationViewModelBase.loadMoreNotifications');

  @override
  Future<void> loadMoreNotifications() {
    return _$loadMoreNotificationsAsyncAction
        .run(() => super.loadMoreNotifications());
  }

  final _$_NotificationViewModelBaseActionController =
      ActionController(name: '_NotificationViewModelBase');

  @override
  void changePostsScrollable(ScrollPhysics physics) {
    final _$actionInfo = _$_NotificationViewModelBaseActionController
        .startAction(name: '_NotificationViewModelBase.changePostsScrollable');
    try {
      return super.changePostsScrollable(physics);
    } finally {
      _$_NotificationViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void lockScrollable() {
    final _$actionInfo = _$_NotificationViewModelBaseActionController
        .startAction(name: '_NotificationViewModelBase.lockScrollable');
    try {
      return super.lockScrollable();
    } finally {
      _$_NotificationViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic openScrollable() {
    final _$actionInfo = _$_NotificationViewModelBaseActionController
        .startAction(name: '_NotificationViewModelBase.openScrollable');
    try {
      return super.openScrollable();
    } finally {
      _$_NotificationViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
postsScrollable: ${postsScrollable}
    ''';
  }
}

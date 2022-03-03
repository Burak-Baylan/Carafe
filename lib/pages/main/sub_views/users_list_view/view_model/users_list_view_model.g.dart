// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users_list_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$UsersListViewModel on _UsersListViewModelBase, Store {
  final _$usersListScrollabeAtom =
      Atom(name: '_UsersListViewModelBase.usersListScrollabe');

  @override
  ScrollPhysics get usersListScrollabe {
    _$usersListScrollabeAtom.reportRead();
    return super.usersListScrollabe;
  }

  @override
  set usersListScrollabe(ScrollPhysics value) {
    _$usersListScrollabeAtom.reportWrite(value, super.usersListScrollabe, () {
      super.usersListScrollabe = value;
    });
  }

  final _$getDataAsyncAction = AsyncAction('_UsersListViewModelBase.getData');

  @override
  Future<List<UserModel>> getData(Query<Map<String, dynamic>> ref) {
    return _$getDataAsyncAction.run(() => super.getData(ref));
  }

  final _$_UsersListViewModelBaseActionController =
      ActionController(name: '_UsersListViewModelBase');

  @override
  dynamic changePostsScrollable(ScrollPhysics physics) {
    final _$actionInfo = _$_UsersListViewModelBaseActionController.startAction(
        name: '_UsersListViewModelBase.changePostsScrollable');
    try {
      return super.changePostsScrollable(physics);
    } finally {
      _$_UsersListViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic lockScrollable() {
    final _$actionInfo = _$_UsersListViewModelBaseActionController.startAction(
        name: '_UsersListViewModelBase.lockScrollable');
    try {
      return super.lockScrollable();
    } finally {
      _$_UsersListViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic openScrollable() {
    final _$actionInfo = _$_UsersListViewModelBaseActionController.startAction(
        name: '_UsersListViewModelBase.openScrollable');
    try {
      return super.openScrollable();
    } finally {
      _$_UsersListViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
usersListScrollabe: ${usersListScrollabe}
    ''';
  }
}

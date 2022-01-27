// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ProfileViewModel on _ProfileViewModelBase, Store {
  final _$isUserFollowingAtom =
      Atom(name: '_ProfileViewModelBase.isUserFollowing');

  @override
  bool? get isUserFollowing {
    _$isUserFollowingAtom.reportRead();
    return super.isUserFollowing;
  }

  @override
  set isUserFollowing(bool? value) {
    _$isUserFollowingAtom.reportWrite(value, super.isUserFollowing, () {
      super.isUserFollowing = value;
    });
  }

  final _$profileOwnerAtom = Atom(name: '_ProfileViewModelBase.profileOwner');

  @override
  bool get profileOwner {
    _$profileOwnerAtom.reportRead();
    return super.profileOwner;
  }

  @override
  set profileOwner(bool value) {
    _$profileOwnerAtom.reportWrite(value, super.profileOwner, () {
      super.profileOwner = value;
    });
  }

  final _$followButtonClickedAsyncAction =
      AsyncAction('_ProfileViewModelBase.followButtonClicked');

  @override
  Future<dynamic> followButtonClicked() {
    return _$followButtonClickedAsyncAction
        .run(() => super.followButtonClicked());
  }

  final _$followUserAsyncAction =
      AsyncAction('_ProfileViewModelBase.followUser');

  @override
  Future<dynamic> followUser() {
    return _$followUserAsyncAction.run(() => super.followUser());
  }

  final _$unfollowUserAsyncAction =
      AsyncAction('_ProfileViewModelBase.unfollowUser');

  @override
  Future<dynamic> unfollowUser() {
    return _$unfollowUserAsyncAction.run(() => super.unfollowUser());
  }

  @override
  String toString() {
    return '''
isUserFollowing: ${isUserFollowing},
profileOwner: ${profileOwner}
    ''';
  }
}

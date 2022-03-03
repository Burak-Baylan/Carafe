// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SearchViewModel on _SearchViewModelBase, Store {
  final _$postsAtom = Atom(name: '_SearchViewModelBase.posts');

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

  final _$searcedPopleAtom = Atom(name: '_SearchViewModelBase.searcedPople');

  @override
  List<UserModel> get searcedPople {
    _$searcedPopleAtom.reportRead();
    return super.searcedPople;
  }

  @override
  set searcedPople(List<UserModel> value) {
    _$searcedPopleAtom.reportWrite(value, super.searcedPople, () {
      super.searcedPople = value;
    });
  }

  final _$isSearchingAtom = Atom(name: '_SearchViewModelBase.isSearching');

  @override
  bool get isSearching {
    _$isSearchingAtom.reportRead();
    return super.isSearching;
  }

  @override
  set isSearching(bool value) {
    _$isSearchingAtom.reportWrite(value, super.isSearching, () {
      super.isSearching = value;
    });
  }

  final _$searchPeopleScrollPhysicsAtom =
      Atom(name: '_SearchViewModelBase.searchPeopleScrollPhysics');

  @override
  ScrollPhysics? get searchPeopleScrollPhysics {
    _$searchPeopleScrollPhysicsAtom.reportRead();
    return super.searchPeopleScrollPhysics;
  }

  @override
  set searchPeopleScrollPhysics(ScrollPhysics? value) {
    _$searchPeopleScrollPhysicsAtom
        .reportWrite(value, super.searchPeopleScrollPhysics, () {
      super.searchPeopleScrollPhysics = value;
    });
  }

  final _$searchPeoplesAsyncAction =
      AsyncAction('_SearchViewModelBase.searchPeoples');

  @override
  Future<void> searchPeoples(String text) {
    return _$searchPeoplesAsyncAction.run(() => super.searchPeoples(text));
  }

  final _$_SearchViewModelBaseActionController =
      ActionController(name: '_SearchViewModelBase');

  @override
  void changePostsScrollable(ScrollPhysics? physics) {
    final _$actionInfo = _$_SearchViewModelBaseActionController.startAction(
        name: '_SearchViewModelBase.changePostsScrollable');
    try {
      return super.changePostsScrollable(physics);
    } finally {
      _$_SearchViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void lockScrollable() {
    final _$actionInfo = _$_SearchViewModelBaseActionController.startAction(
        name: '_SearchViewModelBase.lockScrollable');
    try {
      return super.lockScrollable();
    } finally {
      _$_SearchViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic openScrollable() {
    final _$actionInfo = _$_SearchViewModelBaseActionController.startAction(
        name: '_SearchViewModelBase.openScrollable');
    try {
      return super.openScrollable();
    } finally {
      _$_SearchViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeSearchingState() {
    final _$actionInfo = _$_SearchViewModelBaseActionController.startAction(
        name: '_SearchViewModelBase.changeSearchingState');
    try {
      return super.changeSearchingState();
    } finally {
      _$_SearchViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
posts: ${posts},
searcedPople: ${searcedPople},
isSearching: ${isSearching},
searchPeopleScrollPhysics: ${searchPeopleScrollPhysics}
    ''';
  }
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_menu_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PostMenuViewModel on _PostMenuViewModelBase, Store {
  final _$pinButtonTextAtom =
      Atom(name: '_PostMenuViewModelBase.pinButtonText');

  @override
  String get pinButtonText {
    _$pinButtonTextAtom.reportRead();
    return super.pinButtonText;
  }

  @override
  set pinButtonText(String value) {
    _$pinButtonTextAtom.reportWrite(value, super.pinButtonText, () {
      super.pinButtonText = value;
    });
  }

  final _$followButtonTextAtom =
      Atom(name: '_PostMenuViewModelBase.followButtonText');

  @override
  String get followButtonText {
    _$followButtonTextAtom.reportRead();
    return super.followButtonText;
  }

  @override
  set followButtonText(String value) {
    _$followButtonTextAtom.reportWrite(value, super.followButtonText, () {
      super.followButtonText = value;
    });
  }

  final _$findPinButtonActionAndTextAsyncAction =
      AsyncAction('_PostMenuViewModelBase.findPinButtonActionAndText');

  @override
  ObservableFuture<bool> findPinButtonActionAndText() {
    return ObservableFuture<bool>(_$findPinButtonActionAndTextAsyncAction
        .run(() => super.findPinButtonActionAndText()));
  }

  final _$findFollowButtonActionAndTextAsyncAction =
      AsyncAction('_PostMenuViewModelBase.findFollowButtonActionAndText');

  @override
  Future<bool> findFollowButtonActionAndText() {
    return _$findFollowButtonActionAndTextAsyncAction
        .run(() => super.findFollowButtonActionAndText());
  }

  @override
  String toString() {
    return '''
pinButtonText: ${pinButtonText},
followButtonText: ${followButtonText}
    ''';
  }
}

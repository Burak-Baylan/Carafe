// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_profile_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$EditProfileViewModel on _EditProfileViewModelBase, Store {
  final _$ppImageFileAtom = Atom(name: '_EditProfileViewModelBase.ppImageFile');

  @override
  File? get ppImageFile {
    _$ppImageFileAtom.reportRead();
    return super.ppImageFile;
  }

  @override
  set ppImageFile(File? value) {
    _$ppImageFileAtom.reportWrite(value, super.ppImageFile, () {
      super.ppImageFile = value;
    });
  }

  final _$_EditProfileViewModelBaseActionController =
      ActionController(name: '_EditProfileViewModelBase');

  @override
  void changePpImageFile(File? file) {
    final _$actionInfo = _$_EditProfileViewModelBaseActionController
        .startAction(name: '_EditProfileViewModelBase.changePpImageFile');
    try {
      return super.changePpImageFile(file);
    } finally {
      _$_EditProfileViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
ppImageFile: ${ppImageFile}
    ''';
  }
}

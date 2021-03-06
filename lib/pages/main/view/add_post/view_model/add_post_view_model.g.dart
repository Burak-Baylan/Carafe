// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_post_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AddPostViewModel on _AddPostViewModelBase, Store {
  final _$isWritableAtom = Atom(name: '_AddPostViewModelBase.isWritable');

  @override
  bool get isWritable {
    _$isWritableAtom.reportRead();
    return super.isWritable;
  }

  @override
  set isWritable(bool value) {
    _$isWritableAtom.reportWrite(value, super.isWritable, () {
      super.isWritable = value;
    });
  }

  final _$circularBarValueAtom =
      Atom(name: '_AddPostViewModelBase.circularBarValue');

  @override
  double get circularBarValue {
    _$circularBarValueAtom.reportRead();
    return super.circularBarValue;
  }

  @override
  set circularBarValue(double value) {
    _$circularBarValueAtom.reportWrite(value, super.circularBarValue, () {
      super.circularBarValue = value;
    });
  }

  final _$textLengthAtom = Atom(name: '_AddPostViewModelBase.textLength');

  @override
  int get textLength {
    _$textLengthAtom.reportRead();
    return super.textLength;
  }

  @override
  set textLength(int value) {
    _$textLengthAtom.reportWrite(value, super.textLength, () {
      super.textLength = value;
    });
  }

  final _$progressBarColorAtom =
      Atom(name: '_AddPostViewModelBase.progressBarColor');

  @override
  Color get progressBarColor {
    _$progressBarColorAtom.reportRead();
    return super.progressBarColor;
  }

  @override
  set progressBarColor(Color value) {
    _$progressBarColorAtom.reportWrite(value, super.progressBarColor, () {
      super.progressBarColor = value;
    });
  }

  final _$imagesAtom = Atom(name: '_AddPostViewModelBase.images');

  @override
  List<File?> get images {
    _$imagesAtom.reportRead();
    return super.images;
  }

  @override
  set images(List<File?> value) {
    _$imagesAtom.reportWrite(value, super.images, () {
      super.images = value;
    });
  }

  final _$imagesLengthAtom = Atom(name: '_AddPostViewModelBase.imagesLength');

  @override
  int get imagesLength {
    _$imagesLengthAtom.reportRead();
    return super.imagesLength;
  }

  @override
  set imagesLength(int value) {
    _$imagesLengthAtom.reportWrite(value, super.imagesLength, () {
      super.imagesLength = value;
    });
  }

  final _$selectedCategoryAtom =
      Atom(name: '_AddPostViewModelBase.selectedCategory');

  @override
  String get selectedCategory {
    _$selectedCategoryAtom.reportRead();
    return super.selectedCategory;
  }

  @override
  set selectedCategory(String value) {
    _$selectedCategoryAtom.reportWrite(value, super.selectedCategory, () {
      super.selectedCategory = value;
    });
  }

  final _$postTextAtom = Atom(name: '_AddPostViewModelBase.postText');

  @override
  String? get postText {
    _$postTextAtom.reportRead();
    return super.postText;
  }

  @override
  set postText(String? value) {
    _$postTextAtom.reportWrite(value, super.postText, () {
      super.postText = value;
    });
  }

  final _$screenLockStateAtom =
      Atom(name: '_AddPostViewModelBase.screenLockState');

  @override
  bool get screenLockState {
    _$screenLockStateAtom.reportRead();
    return super.screenLockState;
  }

  @override
  set screenLockState(bool value) {
    _$screenLockStateAtom.reportWrite(value, super.screenLockState, () {
      super.screenLockState = value;
    });
  }

  final _$_AddPostViewModelBaseActionController =
      ActionController(name: '_AddPostViewModelBase');

  @override
  void selectCategory(String category) {
    final _$actionInfo = _$_AddPostViewModelBaseActionController.startAction(
        name: '_AddPostViewModelBase.selectCategory');
    try {
      return super.selectCategory(category);
    } finally {
      _$_AddPostViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onPostTextChanged(String text) {
    final _$actionInfo = _$_AddPostViewModelBaseActionController.startAction(
        name: '_AddPostViewModelBase.onPostTextChanged');
    try {
      return super.onPostTextChanged(text);
    } finally {
      _$_AddPostViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeScreenLockState() {
    final _$actionInfo = _$_AddPostViewModelBaseActionController.startAction(
        name: '_AddPostViewModelBase.changeScreenLockState');
    try {
      return super.changeScreenLockState();
    } finally {
      _$_AddPostViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void _lengthController() {
    final _$actionInfo = _$_AddPostViewModelBaseActionController.startAction(
        name: '_AddPostViewModelBase._lengthController');
    try {
      return super._lengthController();
    } finally {
      _$_AddPostViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isWritable: ${isWritable},
circularBarValue: ${circularBarValue},
textLength: ${textLength},
progressBarColor: ${progressBarColor},
images: ${images},
imagesLength: ${imagesLength},
selectedCategory: ${selectedCategory},
postText: ${postText},
screenLockState: ${screenLockState}
    ''';
  }
}

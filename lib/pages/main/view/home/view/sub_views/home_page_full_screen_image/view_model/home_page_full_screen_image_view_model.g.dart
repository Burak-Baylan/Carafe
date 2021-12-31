// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_page_full_screen_image_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomePageFullScreenImageViewModel
    on _HomePageFullScreenImageViewModelBase, Store {
  final _$indexAtom = Atom(name: '_HomePageFullScreenImageViewModelBase.index');

  @override
  int get index {
    _$indexAtom.reportRead();
    return super.index;
  }

  @override
  set index(int value) {
    _$indexAtom.reportWrite(value, super.index, () {
      super.index = value;
    });
  }

  final _$visibleAtom =
      Atom(name: '_HomePageFullScreenImageViewModelBase.visible');

  @override
  bool get visible {
    _$visibleAtom.reportRead();
    return super.visible;
  }

  @override
  set visible(bool value) {
    _$visibleAtom.reportWrite(value, super.visible, () {
      super.visible = value;
    });
  }

  final _$sliderScrollPhysicsAtom =
      Atom(name: '_HomePageFullScreenImageViewModelBase.sliderScrollPhysics');

  @override
  ScrollPhysics get sliderScrollPhysics {
    _$sliderScrollPhysicsAtom.reportRead();
    return super.sliderScrollPhysics;
  }

  @override
  set sliderScrollPhysics(ScrollPhysics value) {
    _$sliderScrollPhysicsAtom.reportWrite(value, super.sliderScrollPhysics, () {
      super.sliderScrollPhysics = value;
    });
  }

  final _$photoDismissDirectionAtom =
      Atom(name: '_HomePageFullScreenImageViewModelBase.photoDismissDirection');

  @override
  DismissDirection get photoDismissDirection {
    _$photoDismissDirectionAtom.reportRead();
    return super.photoDismissDirection;
  }

  @override
  set photoDismissDirection(DismissDirection value) {
    _$photoDismissDirectionAtom.reportWrite(value, super.photoDismissDirection,
        () {
      super.photoDismissDirection = value;
    });
  }

  final _$colorAtom = Atom(name: '_HomePageFullScreenImageViewModelBase.color');

  @override
  Color get color {
    _$colorAtom.reportRead();
    return super.color;
  }

  @override
  set color(Color value) {
    _$colorAtom.reportWrite(value, super.color, () {
      super.color = value;
    });
  }

  final _$_HomePageFullScreenImageViewModelBaseActionController =
      ActionController(name: '_HomePageFullScreenImageViewModelBase');

  @override
  dynamic noneDissmisDirection() {
    final _$actionInfo =
        _$_HomePageFullScreenImageViewModelBaseActionController.startAction(
            name: '_HomePageFullScreenImageViewModelBase.noneDissmisDirection');
    try {
      return super.noneDissmisDirection();
    } finally {
      _$_HomePageFullScreenImageViewModelBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  dynamic verticalDismissDirection() {
    final _$actionInfo =
        _$_HomePageFullScreenImageViewModelBaseActionController.startAction(
            name:
                '_HomePageFullScreenImageViewModelBase.verticalDismissDirection');
    try {
      return super.verticalDismissDirection();
    } finally {
      _$_HomePageFullScreenImageViewModelBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  dynamic sliderNoneScrollPhysics() {
    final _$actionInfo =
        _$_HomePageFullScreenImageViewModelBaseActionController.startAction(
            name:
                '_HomePageFullScreenImageViewModelBase.sliderNoneScrollPhysics');
    try {
      return super.sliderNoneScrollPhysics();
    } finally {
      _$_HomePageFullScreenImageViewModelBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  dynamic sliderPageScrollPhysics() {
    final _$actionInfo =
        _$_HomePageFullScreenImageViewModelBaseActionController.startAction(
            name:
                '_HomePageFullScreenImageViewModelBase.sliderPageScrollPhysics');
    try {
      return super.sliderPageScrollPhysics();
    } finally {
      _$_HomePageFullScreenImageViewModelBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeVisiblity() {
    final _$actionInfo =
        _$_HomePageFullScreenImageViewModelBaseActionController.startAction(
            name: '_HomePageFullScreenImageViewModelBase.changeVisiblity');
    try {
      return super.changeVisiblity();
    } finally {
      _$_HomePageFullScreenImageViewModelBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeIndex(int index) {
    final _$actionInfo = _$_HomePageFullScreenImageViewModelBaseActionController
        .startAction(name: '_HomePageFullScreenImageViewModelBase.changeIndex');
    try {
      return super.changeIndex(index);
    } finally {
      _$_HomePageFullScreenImageViewModelBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  dynamic setColor(Color color) {
    final _$actionInfo = _$_HomePageFullScreenImageViewModelBaseActionController
        .startAction(name: '_HomePageFullScreenImageViewModelBase.setColor');
    try {
      return super.setColor(color);
    } finally {
      _$_HomePageFullScreenImageViewModelBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  dynamic photoScaleStateChanged(PhotoViewScaleState state) {
    final _$actionInfo =
        _$_HomePageFullScreenImageViewModelBaseActionController.startAction(
            name:
                '_HomePageFullScreenImageViewModelBase.photoScaleStateChanged');
    try {
      return super.photoScaleStateChanged(state);
    } finally {
      _$_HomePageFullScreenImageViewModelBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
index: ${index},
visible: ${visible},
sliderScrollPhysics: ${sliderScrollPhysics},
photoDismissDirection: ${photoDismissDirection},
color: ${color}
    ''';
  }
}

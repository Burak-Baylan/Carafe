import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:photo_view/photo_view.dart';
part 'home_page_full_screen_image_view_model.g.dart';

class HomePageFullScreenImageViewModel = _HomePageFullScreenImageViewModelBase
    with _$HomePageFullScreenImageViewModel;

abstract class _HomePageFullScreenImageViewModelBase with Store {
  @observable
  int index = 0;
  @observable
  bool visible = true;
  @observable
  ScrollPhysics sliderScrollPhysics = const PageScrollPhysics();
  @observable
  Color color = Colors.black.withOpacity(0.5);
  @action
  sliderNoneScrollPhysics() =>
      sliderScrollPhysics = const NeverScrollableScrollPhysics();
  @action
  sliderPageScrollPhysics() =>
      sliderScrollPhysics = const BouncingScrollPhysics();
  @action
  changeVisiblity() => visible = !visible;
  @action
  changeIndex(int index) => this.index = index;
  @action
  setColor(Color color) => this.color = color;
  @observable
  bool dismissCloseState = false;
  @action
  closePhotoDismissible() => dismissCloseState = true;
  @action
  openPhotoDismissible() => dismissCloseState = false;

  @action
  photoScaleStateChanged(PhotoViewScaleState state) {
    print("STATE |||| $state");
    if (state == PhotoViewScaleState.initial) {
      sliderPageScrollPhysics();
      openPhotoDismissible();
    } else {
      sliderNoneScrollPhysics();
      closePhotoDismissible();
    }
  }
}

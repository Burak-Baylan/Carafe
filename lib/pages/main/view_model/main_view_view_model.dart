import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../../core/base/view_model/base_view_model.dart';

part 'main_view_view_model.g.dart';

class MainViewViewModel = _MainViewViewModelBase with _$MainViewViewModel;

abstract class _MainViewViewModelBase extends BaseViewModel with Store {
  @override
  BuildContext? context;

  @observable
  int currentIndex = 0;

  @observable
  bool isFabVisible = true;

  @action
  changeFabVisibility(bool visibility) => isFabVisible = visibility;

  setContext(context) => this.context = context;

  @action
  changeIndex(int index) {
    switch (index) {
      case 0:
        currentIndex = index;
        break;
      case 1:
        currentIndex = index;
        break;
      case 2:
        currentIndex = index;
        break;
      case 3:
        currentIndex = index;
        break;
    }
  }
}

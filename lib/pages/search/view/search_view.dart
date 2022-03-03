import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../../core/extensions/double_extensions.dart';
import '../../../main.dart';
import '../view_model/search_view_model.dart';
import 'sub_views/app_bar/search_view_app_bar.dart';
import 'sub_views/app_bar/search_view_searching_app_bar.dart';
import 'sub_views/main_screens/explore_body.dart';
import 'sub_views/main_screens/search_body.dart';

class SearchView extends StatefulWidget {
  SearchView({
    Key? key,
    this.showAppBarBackButton = false,
  }) : super(key: key);

  bool showAppBarBackButton;

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView>
    with AutomaticKeepAliveClientMixin {
  SearchViewModel searchViewModel = SearchViewModel();

  @override
  void initState() {
    searchViewModel.setContext(context);
    exploreView = SearchViewExploreBody(searchViewModel: searchViewModel);
    pages = [
      exploreView,
      SearchViewSearchBody(searchViewModel: searchViewModel)
    ];
    super.initState();
  }

  late Widget exploreView;
  late List<Widget> pages;

  Future<bool> _onWillPop() async {
    mainVm.changeIndex(0);
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: kToolbarHeight.sizeFromHeight,
          child: Observer(
            builder: (context) => searchViewModel.isSearching
                ? SearchViewSearchingAppBar(searchViewModel: searchViewModel)
                : SearchViewAppBar(
                    context: this.context,
                    searchViewModel: searchViewModel,
                    showAppBarBackButton: widget.showAppBarBackButton,
                  ),
          ),
        ),
        body: PageView(
          controller: searchViewModel.pageController,
          children: pages,
          physics: const NeverScrollableScrollPhysics(),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

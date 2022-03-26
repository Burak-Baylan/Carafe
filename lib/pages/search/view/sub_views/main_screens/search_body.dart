import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../../../../core/extensions/context_extensions.dart';
import '../../../../../core/extensions/double_extensions.dart';
import '../../../../main/view/sub_views/post_widget/full_screen_post_view/sub_widgets/more_comments_loading_widget.dart';
import '../../../view_model/search_view_model.dart';
import '../searced_users_information_widget.dart';

class SearchViewSearchBody extends StatefulWidget {
  SearchViewSearchBody({
    Key? key,
    required this.searchViewModel,
  }) : super(key: key);

  SearchViewModel searchViewModel;

  @override
  _SearchViewSearchBodyState createState() => _SearchViewSearchBodyState();
}

class _SearchViewSearchBodyState extends State<SearchViewSearchBody>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return _searchBody();
  }

  Widget _searchBody() {
    return Observer(
      builder: (context) => ListView.builder(
        controller: widget.searchViewModel.searchPeopleScrollController,
        physics: widget.searchViewModel.searchPeopleScrollPhysics,
        shrinkWrap: true,
        itemCount: widget.searchViewModel.searcedPople.length + 1,
        itemBuilder: (context, index) => buildSearchBody(index),
      ),
    );
  }

  Widget buildSearchBody(int index) {
    if (widget.searchViewModel.searching) {
      return Padding(
        padding: 10.0.edgeIntesetsOnlyTop,
        child: const Center(child: MoreCommentsLoadingWidget()),
      );
    }
    if (widget.searchViewModel.searchController.text.isEmpty) {
      return _buildSearchInfoText('Search for people');
    }
    if (widget.searchViewModel.searcedPople.isEmpty) {
      return _buildSearchInfoText('Search not found');
    }
    if (index <= widget.searchViewModel.searcedPople.length - 1) {
      return SearchedUsersInformationWidget(
        userModel: widget.searchViewModel.searcedPople[index],
      );
    }
    return Container();
  }

  Widget _buildSearchInfoText(String text) => Padding(
        padding: 10.0.edgeIntesetsOnlyTop,
        child: Center(
          child: Text(
            text,
            style: context.theme.textTheme.headline6?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: context.width / 25,
              color: Colors.blueGrey[500],
            ),
          ),
        ),
      );

  @override
  bool get wantKeepAlive => true;
}

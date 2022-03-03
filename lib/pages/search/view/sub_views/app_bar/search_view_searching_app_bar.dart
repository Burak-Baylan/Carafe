import 'package:flutter/material.dart';
import '../../../../../app/constants/app_constants.dart';
import '../../../../../core/extensions/context_extensions.dart';
import '../../../../../core/extensions/double_extensions.dart';
import '../../../../../core/extensions/int_extensions.dart';
import '../../../view_model/search_view_model.dart';

class SearchViewSearchingAppBar extends StatefulWidget {
  SearchViewSearchingAppBar({
    Key? key,
    required this.searchViewModel,
  }) : super(key: key);

  SearchViewModel searchViewModel;

  @override
  State<SearchViewSearchingAppBar> createState() =>
      _SearchViewSearchingAppBarState();
}

class _SearchViewSearchingAppBarState extends State<SearchViewSearchingAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      bottom: PreferredSize(
        preferredSize: 1.5.sizeFromHeight,
        child: const Divider(height: 0, thickness: 1),
      ),
      elevation: 0,
      backgroundColor: AppColors.white,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: context.colorScheme.primary,
        ),
        onPressed: () => widget.searchViewModel.changeSearchingState(),
      ),
      centerTitle: true,
      title: _title,
    );
  }

  Widget get _title => TextFormField(
        onChanged: (text) => widget.searchViewModel.searchPeoples(text),
        focusNode: widget.searchViewModel.searchFocusNode,
        controller: widget.searchViewModel.searchController,
        style: context.theme.textTheme.headline6?.copyWith(
          fontSize: context.width / 23,
          color: context.colorScheme.secondary,
        ),
        decoration: decoration,
      );

  InputDecoration get decoration => InputDecoration(
        isCollapsed: true,
        hintStyle: context.theme.textTheme.headline6?.copyWith(
          fontSize: context.width / 23,
          color: Colors.blueGrey.shade400,
        ),
        hintText: 'Search People',
        border: InputBorder.none,
        suffix: InkWell(
          borderRadius: 1000.borderRadiusCircular,
          onTap: () => widget.searchViewModel.clearSearchText(),
          child: SizedBox(
            height: context.width / 17,
            width: context.width / 17,
            child: Icon(
              Icons.close,
              color: context.colorScheme.secondary,
              size: context.width / 23,
            ),
          ),
        ),
      );
}

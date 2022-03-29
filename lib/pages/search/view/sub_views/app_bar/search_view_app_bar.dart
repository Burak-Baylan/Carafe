import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../../../../app/constants/app_constants.dart';
import '../../../../../core/extensions/context_extensions.dart';
import '../../../../../core/extensions/double_extensions.dart';
import '../../../../../core/extensions/int_extensions.dart';
import '../../../../../main.dart';
import '../../../../main/view/sub_views/post_widget/post_widget/sub_widgets/profile_photo.dart';
import '../../../view_model/search_view_model.dart';

class SearchViewAppBar extends StatefulWidget {
  SearchViewAppBar({
    Key? key,
    required this.context,
    required this.searchViewModel,
    this.showAppBarBackButton = false,
  }) : super(key: key);

  BuildContext context;
  SearchViewModel searchViewModel;
  bool showAppBarBackButton;

  @override
  State<SearchViewAppBar> createState() => _SearchViewAppBarState();
}

class _SearchViewAppBarState extends State<SearchViewAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      bottom: PreferredSize(
        preferredSize: 1.5.sizeFromHeight,
        child: const Divider(height: 0, thickness: 1),
      ),
      elevation: 0,
      backgroundColor: AppColors.white,
      leading: buildLeading,
      centerTitle: true,
      title: searchBar,
    );
  }

  Widget get searchBar => GestureDetector(
        onTap: () => widget.searchViewModel.changeSearchingState(),
        child: Container(
          alignment: Alignment.centerLeft,
          width: double.infinity,
          height: kToolbarHeight - 20,
          padding: 10.0.edgeIntesetsOnlyLeft,
          margin: 7.0.edgeIntesetsOnlyRight,
          decoration: BoxDecoration(
            color: Colors.grey[100],
            border: Border.all(
              width: 0.5,
              color: Colors.grey.shade400,
            ),
            borderRadius: 20.radiusAll,
          ),
          child: Text(
            "Search People",
            style: context.theme.textTheme.headline6?.copyWith(
              fontSize: context.width / 23,
              color: Colors.blueGrey.shade400,
            ),
          ),
        ),
      );

  Widget get buildLeading => widget.showAppBarBackButton
      ? Container(
          margin: 7.0.edgeIntesetsAll,
          child: InkWell(
            borderRadius: 50.radiusAll,
            onTap: () => context.pop,
            child: Icon(Icons.arrow_back_ios_rounded,
                color: context.colorScheme.primary),
          ),
        )
      : Container(
          margin: 7.0.edgeIntesetsAll,
          child: Observer(
            builder: (_) => PostProfilePhoto(
              imageUrl: (mainVm.currentUserModel)?.photoUrl,
              onClicked: (_) => widget.context.openDrawer,
            ),
          ),
        );
}

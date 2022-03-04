import 'package:flutter/material.dart';
import '../../../app/enums/post_view_type.dart';
import '../../../core/extensions/context_extensions.dart';
import '../../../core/extensions/double_extensions.dart';
import '../../../core/extensions/widget_extension.dart';
import '../../../core/widgets/center_dot_text.dart';
import '../../../core/widgets/small_circular_progress_indicator.dart';
import '../../../core/widgets/something_went_wrong_widget.dart';
import '../../../core/widgets/there_is_nothing_here_widget.dart';
import '../../../main.dart';
import '../../main/view/sub_views/post_widget/post_widget/post_widget.dart';
import '../view_model/category_view_model.dart';

class CategoryView extends StatefulWidget {
  CategoryView({
    Key? key,
    required this.categoryName,
  }) : super(key: key);

  String categoryName;

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  CategoryViewModel categoryVm = CategoryViewModel();

  @override
  void initState() {
    categoryVm.setContext(context);
    categoryVm.initializeValues();
    categoryVm.setCategoryName(widget.categoryName);
    postFuture = categoryVm.getPosts();
    super.initState();
  }

  late Future postFuture;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      backgroundColor: Colors.white,
      body: FutureBuilder(
        future: postFuture,
        builder: (context, snapshot) => findWidget(snapshot),
      ),
    );
  }

  Widget findWidget(AsyncSnapshot<Object?> snapshot) {
    if (snapshot.error != null) {
      return const SomethingWentWrongWidget();
    }
    if (snapshot.connectionState == ConnectionState.done &&
        categoryVm.posts.isEmpty) {
      return const ThereIsNothingHereWidget();
    }
    if (snapshot.connectionState == ConnectionState.done &&
        categoryVm.posts.isNotEmpty) {
      return listViewBuilder;
    }
    return const SmallCircularProgressIndicator().center;
  }

  Widget get listViewBuilder => ListView.builder(
        itemCount: categoryVm.posts.length,
        physics: categoryVm.postsScrollable,
        controller: categoryVm.controller,
        itemBuilder: (context, index) {
          return buildPostWidget(index);
        },
      );

  Widget buildPostWidget(int index) {
    List<Widget> widgets = [];
    var postWidget = PostWidget(
      model: categoryVm.posts[index],
      closeCardView:
          mainVm.postViewType == PostViewType.CardView ? false : true,
    );
    widgets.add(postWidget);
    if (index == categoryVm.posts.length - 1) {
      widgets.add(25.0.sizedBoxOnlyHeight);
      widgets.add(CenterDotText());
      widgets.add(25.0.sizedBoxOnlyHeight);
    }
    return Column(children: widgets);
  }

  AppBar get appBar => AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () => context.pop,
        ),
        title: Text(
          widget.categoryName,
          style: TextStyle(
            fontSize: context.width / 20,
            color: context.theme.colorScheme.primary,
          ),
        ),
        bottom: PreferredSize(
          child: const Divider(height: 0),
          preferredSize: Size(context.width, 1),
        ),
        iconTheme: IconThemeData(color: context.theme.colorScheme.primary),
      );
}

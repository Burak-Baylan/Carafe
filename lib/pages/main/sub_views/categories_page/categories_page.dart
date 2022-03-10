import 'package:flutter/material.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../search/view/sub_views/main_screens/explore_body.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({Key? key}) : super(key: key);

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: SearchViewExploreBody(),
    );
  }

  AppBar get appBar => AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () => context.pop,
        ),
        title: Text(
          'Categories',
          style: TextStyle(
            fontSize: context.width / 20,
            color: context.theme.colorScheme.primary,
          ),
        ),
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: Size(context.width, 1),
          child: const Divider(height: 0),
        ),
        iconTheme: IconThemeData(color: context.theme.colorScheme.primary),
      );
}

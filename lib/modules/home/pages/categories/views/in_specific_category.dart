import 'package:flutter/material.dart';
import 'package:news/core/models/sources_model.dart';
import 'package:news/core/services/apis/api_manager.dart';
import 'package:news/modules/home/pages/categories/widgets/tab_bar_of_sources.dart';

class InSpecificCategoryView extends StatefulWidget {
  final String categoryId;

  const InSpecificCategoryView({super.key, required this.categoryId});

  @override
  State<InSpecificCategoryView> createState() => _InSpecificCategoryViewState();
}

class _InSpecificCategoryViewState extends State<InSpecificCategoryView> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ApiManager.getSourcesByCategoryId(widget.categoryId),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text("Something went wrong!"));
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          List<Source> sources = snapshot.data?.sources ?? [];
          if (snapshot.data?.code != null) {
            print('${snapshot.data?.message}');
            return const SizedBox();
          }
          return TabBarOfSources(
            sources: sources,
          );
        }
      },
    );
  }
}

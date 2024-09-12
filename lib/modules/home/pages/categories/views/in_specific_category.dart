import 'package:flutter/material.dart';
import 'package:news/core/api_errors/api_errors.dart';
import 'package:news/core/models/sources_model.dart';
import 'package:news/core/providers/home/home_provider.dart';
import 'package:news/modules/home/pages/categories/widgets/tab_bar_of_sources.dart';
import 'package:provider/provider.dart';

class InSpecificCategoryView extends StatelessWidget {
  const InSpecificCategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    HomeProvider homeProvider = Provider.of(context);
    return FutureBuilder(
      future: homeProvider.getSourcesByCurrentCategoryId(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          String message = ApiErrors.checkApiError(snapshot.error!, context);
          return Center(child: Text(message));
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          List<Source> sources = snapshot.data?.sources ?? [];
          if (snapshot.data?.code != null) {
            return Center(
                child: Text(
                    textAlign: TextAlign.center,
                    "${snapshot.data!.code}\n${snapshot.data!.message}"));
          }
          return TabBarOfSources(
            sources: sources,
          );
        }
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:news/core/api_errors/api_errors.dart';
import 'package:news/core/models/news_model.dart';
import 'package:news/core/providers/home/home_provider.dart';
import 'package:news/core/providers/locales/locales_provider.dart';
import 'package:news/core/widgets/articles_List_view/articles_list_view.dart';
import 'package:provider/provider.dart';

class ArticlesSection extends StatelessWidget {
  final String sourcedId;

  const ArticlesSection({super.key, required this.sourcedId});

  @override
  Widget build(BuildContext context) {
    HomeProvider homeProvider = Provider.of(context);
    return FutureBuilder(
      future: homeProvider.getTopHeadlinesBySourceId(sourcedId),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          String message = ApiErrors.checkApiError(snapshot.error!, context);
          return Center(child: Text(message));
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          NewsModel? newsModel = snapshot.data;
          if (newsModel?.code == "rateLimited") {
            return Center(
                child: Text(
                    textAlign: TextAlign.center,
                    LocalesProvider.getTrans(context).rateLimited));
          }
          return ArticlesListView(newsModel: newsModel);
        }
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:news/core/models/news_model.dart';
import 'package:news/core/models/sources_model.dart';
import 'package:news/core/services/apis/api_manager.dart';

class HomeProvider extends ChangeNotifier {
  String? currentCategoryId;
  String currentAppBarTitle = "";

  void initAppBarTitle({required String appBarTitle}) {
    currentAppBarTitle = appBarTitle;
  }

  void changeBarTitleAndCategoryId(
      {required String newAppBarTitle, required String? newCategoryId}) {
    currentAppBarTitle = newAppBarTitle;
    currentCategoryId = newCategoryId;
    notifyListeners();
    debugPrint(currentAppBarTitle);
  }

  Future<SourcesModel?> getSourcesByCurrentCategoryId() {
    return ApiManager.getSourcesByCategoryId(currentCategoryId!);
  }

  Future<NewsModel?> getTopHeadlinesBySourceId(String sourceId) {
    return ApiManager.getTopHeadlinesBySourceId(sourceId);
  }

  Future<NewsModel?> getNewsByQuery(String query) {
    return ApiManager.getNewsByQuery(query);
  }
}

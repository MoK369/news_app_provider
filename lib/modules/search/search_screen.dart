import 'package:flutter/material.dart';
import 'package:news/core/api_errors/api_errors.dart';
import 'package:news/core/models/news_model.dart';
import 'package:news/core/providers/home/home_provider.dart';
import 'package:news/core/providers/locales/locales_provider.dart';
import 'package:news/core/providers/themes/themes_provider.dart';
import 'package:news/core/themes/app_themes.dart';
import 'package:news/core/widgets/articles_List_view/articles_list_view.dart';
import 'package:news/core/widgets/background_pattern/background_pattern.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  static const String routeName = "SearchScreen";

  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController textEditingController = TextEditingController();
  bool isSearchClicked = false, articlesBuildOnce = false;
  NewsModel? newsModel;
  late ThemesProvider themesProvider;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final ThemeData theme = Theme.of(context);
    final HomeProvider homeProvider = Provider.of(context);
    themesProvider = Provider.of(context);
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            leading: const SizedBox(),
            leadingWidth: 0,
            toolbarHeight: size.height * 0.09,
            title: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: TextField(
                cursorColor: theme.inputDecorationTheme.hintStyle?.color,
                controller: textEditingController,
                style: theme.textTheme.labelMedium,
                onSubmitted: (value) {
                  onSearchButtonClick();
                },
                decoration: InputDecoration(
                  hintText: LocalesProvider.getTrans(context).searchArticle,
                  suffixIcon: IconButton(
                      onPressed: () {
                        onSearchButtonClick();
                      },
                      icon: Icon(
                        Icons.search,
                        size: 30,
                        color: getIconColor(),
                      )),
                  prefixIcon: IconButton(
                      onPressed: () {
                        onClearButtonClick();
                      },
                      icon: Icon(
                        Icons.clear,
                        size: 30,
                        color: getIconColor(),
                      )),
                ),
              ),
            ),
          ),
          body: !articlesBuildOnce
              ? BgPattern(
                  child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Visibility(
                      visible: !isSearchClicked,
                      child: Expanded(
                        child: Center(
                            child: ImageIcon(
                          const AssetImage(
                              "assets/icons/window_search_icon.png"),
                          size: 80,
                          color: getIconColor(),
                        )),
                      ),
                    ),
                    Visibility(
                      visible: isSearchClicked,
                      child: Expanded(
                        child: FutureBuilder(
                          future: homeProvider
                              .getNewsByQuery(textEditingController.text),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              String message =
                                  ApiErrors.checkApiError(snapshot.error!);
                              return Center(child: Text(message));
                            } else if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else {
                              if (snapshot.data?.code != null) {
                                return Center(
                                    child: Text(
                                        textAlign: TextAlign.center,
                                        "${snapshot.data!.code}\n${snapshot.data!.message}"));
                              }
                              newsModel = snapshot.data;
                              articlesBuildOnce = true;
                              return ArticlesListView(
                                  newsModel: newsModel,
                                  showClearAllResults: true,
                                  onClearResultsClick: onClearResultsClick);
                            }
                          },
                        ),
                      ),
                    )
                  ],
                ))
              : ArticlesListView(
                  newsModel: newsModel,
                  showClearAllResults: true,
                  onClearResultsClick: onClearResultsClick)),
    );
  }

  void onSearchButtonClick() {
    if (textEditingController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(LocalesProvider.getTrans(context).searchFieldEmpty)));
    } else {
      setState(() {
        isSearchClicked = true;
        articlesBuildOnce = false;
        FocusManager.instance.primaryFocus?.unfocus();
      });
    }
  }

  void onClearButtonClick() {
    if (textEditingController.text.isNotEmpty) {
      textEditingController.clear();
      //articlesBuildOnce = false;
    } else {
      FocusManager.instance.primaryFocus?.unfocus();
      Navigator.pop(context);
    }
  }

  void onClearResultsClick() {
    setState(() {
      newsModel = null;
      textEditingController.clear();
      articlesBuildOnce = false;
      isSearchClicked = false;
    });
  }

  Color getIconColor() {
    return themesProvider.isDark()
        ? AppThemes.darkOnPrimaryColor
        : AppThemes.lightOnPrimaryColor;
  }
}

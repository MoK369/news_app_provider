import 'package:flutter/material.dart';
import 'package:news/core/models/news_model.dart';
import 'package:news/core/services/apis/api_manager.dart';
import 'package:news/core/widgets/articles_List_view/articles_list_view.dart';
import 'package:news/core/widgets/background_pattern/background_pattern.dart';

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

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final ThemeData theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            leading: const SizedBox(),
            leadingWidth: 0,
            toolbarHeight: size.height * 0.08,
            title: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: TextField(
                controller: textEditingController,
                style: theme.textTheme.labelMedium,
                onSubmitted: (value) {
                  onSearchButtonClick();
                },
                decoration: InputDecoration(
                  hintText: "Search Article",
                  suffixIcon: IconButton(
                      onPressed: () {
                        onSearchButtonClick();
                      },
                      icon: const Icon(
                        Icons.search,
                        size: 30,
                      )),
                  prefixIcon: IconButton(
                      onPressed: () {
                        onClearButtonClick();
                      },
                      icon: const Icon(
                        Icons.clear,
                        color: Colors.green,
                        size: 30,
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
                      child: const Expanded(
                        child: Center(
                            child: ImageIcon(
                          AssetImage("assets/icons/window_search_icon.png"),
                          size: 80,
                          color: Colors.green,
                        )),
                      ),
                    ),
                    Visibility(
                      visible: isSearchClicked,
                      child: Expanded(
                        child: FutureBuilder(
                          future: ApiManager.getNewsByQuery(
                              textEditingController.text),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return const Center(
                                  child: Text("Something went wrong!"));
                            } else if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else {
                              newsModel = snapshot.data;
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
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Search Field is Empty")));
    } else {
      setState(() {
        isSearchClicked = true;
        articlesBuildOnce = false;
        FocusManager.instance.primaryFocus?.unfocus();
      });
      Future.delayed(
        const Duration(seconds: 1),
        () {
          articlesBuildOnce = true;
        },
      );
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
}

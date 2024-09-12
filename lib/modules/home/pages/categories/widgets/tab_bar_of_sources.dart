import 'package:flutter/material.dart';
import 'package:news/core/api_errors/api_errors.dart';
import 'package:news/core/models/news_model.dart';
import 'package:news/core/models/sources_model.dart';
import 'package:news/core/providers/home/home_provider.dart';
import 'package:news/core/widgets/articles_List_view/articles_list_view.dart';
import 'package:news/modules/home/pages/categories/widgets/tab_item.dart';
import 'package:provider/provider.dart';

class TabBarOfSources extends StatefulWidget {
  final List<Source> sources;

  const TabBarOfSources({super.key, required this.sources});

  @override
  State<TabBarOfSources> createState() => _TabBarOfSourcesState();
}

class _TabBarOfSourcesState extends State<TabBarOfSources>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  late String selectedSourceId;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: widget.sources.length, vsync: this);
    selectedSourceId =
        widget.sources.isNotEmpty ? widget.sources[0].id ?? "" : "";
  }

  @override
  Widget build(BuildContext context) {
    HomeProvider homeProvider = Provider.of(context);
    return Column(
      children: [
        TabBar(
            isScrollable: true,
            controller: tabController,
            indicatorColor: Colors.transparent,
            dividerColor: Colors.transparent,
            overlayColor: WidgetStateColor.transparent,
            tabAlignment: TabAlignment.start,
            labelPadding: const EdgeInsets.symmetric(horizontal: 15),
            onTap: (value) {
              setState(() {
                tabController.index = value;
                selectedSourceId = widget.sources[value].id!;
              });
            },
            tabs: widget.sources.map(
              (source) {
                return TabItem(
                    isSelected:
                        tabController.index == widget.sources.indexOf(source),
                    title: source.name ?? "");
              },
            ).toList()),
        Expanded(
          child: FutureBuilder(
            future: homeProvider.getTopHeadlinesBySourceId(selectedSourceId),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                String message =
                    ApiErrors.checkApiError(snapshot.error!, context);
                return Center(child: Text(message));
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                NewsModel? newsModel = snapshot.data;
                if (newsModel?.code != null) {
                  return Center(
                      child: Text(
                          textAlign: TextAlign.center,
                          "${snapshot.data!.code}\n${snapshot.data!.message}"));
                }
                return ArticlesListView(newsModel: newsModel);
              }
            },
          ),
        )
      ],
    );
  }
}

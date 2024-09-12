import 'package:flutter/material.dart';
import 'package:news/core/models/news_model.dart';
import 'package:news/core/providers/locales/locales_provider.dart';
import 'package:news/core/widgets/news_card/news_card.dart';

import '../../../modules/details/details_screen.dart';

class ArticlesListView extends StatelessWidget {
  final NewsModel? newsModel;
  final void Function()? onClearResultsClick;
  final bool showClearAllResults;

  const ArticlesListView(
      {super.key,
      required this.newsModel,
      this.onClearResultsClick,
      this.showClearAllResults = false});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                textAlign: TextAlign.start,
                "${LocalesProvider.getTrans(context).totalResults}${newsModel?.totalResults ?? 0}",
                style: theme.textTheme.labelSmall,
              ),
              Visibility(
                visible: showClearAllResults,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    onTap: onClearResultsClick == null
                        ? null
                        : () {
                            onClearResultsClick!();
                          },
                    title: Text(
                      textAlign: TextAlign.end,
                      LocalesProvider.getTrans(context).clearResults,
                      style: theme.textTheme.labelSmall,
                    ),
                    trailing: const Icon(
                      Icons.clear_all_outlined,
                      size: 20,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        Expanded(
          child: ListView.separated(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            itemCount: newsModel?.articles?.length ?? 0,
            itemBuilder: (context, index) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                child: NewsCard(
                  article: newsModel?.articles?[index],
                  onTap: (pressedArticle) {
                    Navigator.pushNamed(context, DetailsScreen.routeName,
                        arguments: pressedArticle);
                  },
                ),
              );
            },
            separatorBuilder: (context, index) {
              return Divider(
                color: theme.dividerColor,
                indent: 5,
                endIndent: 5,
              );
            },
          ),
        ),
      ],
    );
  }
}

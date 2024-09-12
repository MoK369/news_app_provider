import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:news/core/extension_motheds/string_extension_motheds.dart';
import 'package:news/core/models/news_model.dart';
import 'package:news/core/providers/locales/locales_provider.dart';
import 'package:news/core/providers/themes/themes_provider.dart';
import 'package:provider/provider.dart';

class NewsCard extends StatelessWidget {
  final Article? article;
  final double textHorizontalPadding;
  final void Function(Article pressedArticle)? onTap;

  const NewsCard(
      {super.key,
      required this.article,
      this.onTap,
      this.textHorizontalPadding = 0});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Size size = MediaQuery.of(context).size;
    final ThemesProvider themesProvider = Provider.of(context);
    final LocalesProvider localesProvider = Provider.of(context);
    return InkWell(
      splashColor: Colors.transparent,
      onTap: onTap == null
          ? null
          : () {
              onTap!(article!);
            },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Hero(
              tag: article?.urlToImage ?? "",
              child: CachedNetworkImage(
                width: size.width * 0.98,
                height: size.height * 0.25,
                fit: BoxFit.cover,
                imageUrl: article?.urlToImage ?? "",
                placeholder: (context, url) {
                  return Center(
                    child: ColorFiltered(
                      colorFilter: ColorFilter.mode(
                          theme.progressIndicatorTheme.color!,
                          BlendMode.srcATop),
                      child: Lottie.asset(
                          "assets/animations/image_progress_indicator.json"),
                    ),
                  );
                },
                errorWidget: (context, url, error) {
                  return Center(
                      child: Icon(
                    Icons.error,
                    size: 40,
                    color:
                        themesProvider.isDark() ? Colors.white : Colors.black,
                  ));
                },
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: textHorizontalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  article?.source?.name ?? "",
                  style: theme.textTheme.labelSmall,
                ),
                Text(
                  article?.author != null ? "Author: ${article?.author}" : "",
                  style: theme.textTheme.labelSmall,
                ),
                Text(
                  article?.title ?? "",
                  style: theme.textTheme.labelMedium,
                ),
                Text(
                  textAlign: TextAlign.end,
                  article?.publishAt?.getLocalDateTimeFormat(
                          localesProvider.currentLocale) ??
                      "",
                  style: theme.textTheme.labelSmall,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

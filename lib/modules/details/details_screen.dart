import 'package:flutter/material.dart';
import 'package:news/core/models/news_model.dart';
import 'package:news/core/widgets/background_pattern/background_pattern.dart';
import 'package:news/core/widgets/news_card/news_card.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsScreen extends StatelessWidget {
  static const String routeName = "DetailScreen";

  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final ThemeData theme = Theme.of(context);
    final Article article =
        ModalRoute.settingsOf(context)?.arguments as Article;
    return Scaffold(
      appBar: AppBar(
        title: const Text("News Title"),
        toolbarHeight: 60,
        centerTitle: true,
        leadingWidth: 80,
      ),
      body: BgPattern(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: size.height * 0.03),
            child: NewsCard(
              article: article,
              textHorizontalPadding: 10,
            ),
          ),
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(25)),
              width: size.width * 0.95,
              height: size.height * 0.4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Text(
                        article.description ?? "",
                        style: theme.textTheme.bodyMedium,
                      ),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      launchLink(context, Uri.parse(article.url!));
                    },
                    title: Text(
                      textAlign: TextAlign.end,
                      "View Full Article",
                      style: theme.textTheme.labelMedium,
                    ),
                    trailing: const Icon(Icons.play_arrow),
                  )
                ],
              )),
        ],
      )),
    );
  }

  Future<void> launchLink(BuildContext context, Uri url) async {
    if (!await launchUrl(url)) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Could not Launch URL")));
    }
  }
}

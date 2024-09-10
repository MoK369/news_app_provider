class NewsModel {
  String? status;
  String? code;
  String? message;
  int? totalResults;
  List<Article>? articles;

  NewsModel(
      {this.status, this.code, this.message, this.totalResults, this.articles});

  NewsModel.fromJson(Map<String, dynamic> newsJson) {
    status = newsJson["status"];
    code = newsJson["code"];
    message = newsJson["message"];
    totalResults = newsJson["totalResults"];
    articles = [];
    for (var article in newsJson["articles"] ?? []) {
      articles?.add(Article.fromJson(article));
    }
  }
}

class Article {
  SourceInfo? source;
  String? author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  String? publishAt;
  String? content;

  Article(
      {this.author,
      this.title,
      this.description,
      this.url,
      this.urlToImage,
      this.publishAt,
      this.content,
      this.source});

  Article.fromJson(Map<String, dynamic> articleJson)
      : this(
          author: articleJson["author"],
          title: articleJson["title"],
          description: articleJson["description"],
          publishAt: articleJson["publishedAt"],
          content: articleJson["content"],
          url: articleJson["url"],
          urlToImage: articleJson["urlToImage"],
          source: SourceInfo.fromJson(
            articleJson["source"],
          ),
        );
}

class SourceInfo {
  String? id;
  String? name;

  SourceInfo({this.id, this.name});

  SourceInfo.fromJson(Map<String, dynamic> sourceJson)
      : this(
          id: sourceJson["id"],
          name: sourceJson["name"],
        );
}

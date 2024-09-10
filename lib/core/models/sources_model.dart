class SourcesModel {
  String? status, code, message;
  List<Source>? sources;

  SourcesModel({this.status, this.code, this.message, this.sources});

  SourcesModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    code = json["code"];
    message = json["message"];
    sources = [];
    for (var source in json["sources"] ?? []) {
      sources?.add(Source.fromJson(source));
    }
  }
}

class Source {
  String? id, name, description, url, category, language, country;

  Source(
      {this.id,
      this.name,
      this.description,
      this.url,
      this.category,
      this.language,
      this.country});

  Source.fromJson(Map<String, dynamic> sourceJson) {
    id = sourceJson["id"];
    name = sourceJson["name"];
    description = sourceJson["description"];
    url = sourceJson["url"];
    category = sourceJson["category"];
    language = sourceJson["language"];
    country = sourceJson["country"];
  }
}

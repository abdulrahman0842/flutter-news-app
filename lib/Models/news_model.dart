import 'package:hive/hive.dart';

part 'news_model.g.dart';

@HiveType(typeId: 0)
class NewsModel extends HiveObject {
  @HiveField(0)
  String? status;

  @HiveField(1)
  int? totalResults;

  @HiveField(2)
  List<Articles>? articles;

  NewsModel(this.status, this.totalResults, this.articles);
  NewsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    totalResults = json['totalResults'];
    if (json['articles'] != null) {
      articles = <Articles>[];
      json['articles'].forEach((v) {
        articles!.add(Articles.fromJson(v));
      });
    }
  }
}

@HiveType(typeId: 1)
class Articles extends HiveObject {
  @HiveField(0)
  Source? source;

  @HiveField(1)
  String? author;

  @HiveField(2)
  String? title;

  @HiveField(3)
  String? description;

  @HiveField(4)
  String? url;

  @HiveField(5)
  String? urlToImage;

  @HiveField(6)
  String? publishedAt;

  @HiveField(7)
  String? content;

  Articles(
      {this.source,
      this.author,
      this.title,
      this.description,
      this.url,
      this.urlToImage,
      this.publishedAt,
      this.content});

  Articles.fromJson(Map<String, dynamic> json) {
    source = json['source'] != null ? Source.fromJson(json['source']) : null;
    author = json['author'];
    title = json['title'];
    description = json['description'];
    url = json['url'];
    urlToImage = json['urlToImage'];
    publishedAt = json['publishedAt'];
    content = json['content'];
  }
}

@HiveType(typeId: 2)
class Source extends HiveObject {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? name;

  Source(this.id, this.name);

  Source.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}

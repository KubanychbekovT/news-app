import 'dart:convert';

import 'package:news_app/domain/models/article/article_source.dart';

class Article {
  final ArticleSource? source;
  final String? author;
  final String? title;
  final String? description;
  final String? url;
  final String? urlToImage;
  final String? publishedAt;
  final String? content;
  Article({
    this.source,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content
});

  Article copyWith({
  ArticleSource? source,
    String? author,
    String? title,
    String? description,
    String? url,
    String? urlToImage,
    String? publishedAt,
    String? content,
}) {
    return Article(
      source: source ?? this.source,
      author: author ?? this.author,
      title: title ?? this.title,
      description: description ?? this.description,
      url: url ?? this.url,
      urlToImage: urlToImage ?? this.urlToImage,
      publishedAt: publishedAt ?? this.publishedAt,
      content: content ?? this.content,
    );
  }

  Article merge(Article model) {
    return Article(
      source: model.source ?? source,
      author: model.author ?? author,
      title: model.title ?? title,
      description: model.description ?? description,
      url: model.url ?? url,
      urlToImage: model.urlToImage ?? urlToImage,
      publishedAt: model.publishedAt ?? publishedAt,
      content: model.content ?? content,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'source': source?.toMap(),
      'author': author,
      'title': title,
      'description': description,
      'url': url,
      'urlToImage': urlToImage,
      'publishedAt': publishedAt,
      'content': content,
    };
  }

  factory Article.fromMap(Map<String, dynamic> map) {
    return Article(
      source: ArticleSource.fromMap(map['source']),
      author: map['author'],
      title: map['title'],
      description: map['description'],
      url: map['url'],
      urlToImage: map['urlToImage'],
      publishedAt: map['publishedImage'],
      content: map['content'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Article.fromJson(String source) => Article.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Article(source: $source, author: $author, title: $title, description: $description,'
        'url: $url, urlToImage: $urlToImage, publishedAt: $publishedAt, content: $content)';
  }

  @override
  bool operator == (Object other) {
    if (identical(this, other)) return true;

    return other is Article &&
      other.source == source &&
      other.author == author &&
      other.title == title &&
      other.description == description &&
      other.url == url &&
      other.urlToImage == urlToImage &&
      other.publishedAt == publishedAt &&
      other.content == content;
  }

  @override
  int get hashCode {
    return source.hashCode ^
      author.hashCode ^
      title.hashCode ^
      description.hashCode ^
      url.hashCode ^
      urlToImage.hashCode ^
      publishedAt.hashCode ^
      content.hashCode;
  }
}
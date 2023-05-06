part of 'article_cubit.dart';

class ArticlesRepository {
  Future<Article> fetch() => ArticlesDataProvider.fetch();
}
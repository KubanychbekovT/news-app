part of 'article_cubit.dart';

class ArticlesRepository {
  Future<List<Article>> fetch(String keyword) =>
      ArticlesDataProvider.fetch(keyword: keyword);
}
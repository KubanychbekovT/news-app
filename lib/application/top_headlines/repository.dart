part of 'top_headlines_cubit.dart';

class NewsRepository {
  Future<List<News>> fetchApi(String category) =>
      NewsDataProvider.fetchApi(category);

  Future<List<News>?> fetchHive(String category) =>
      NewsDataProvider.fetchHive(category);
}
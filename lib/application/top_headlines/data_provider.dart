part of 'top_headlines_cubit.dart';

class NewsDataProvider {
  static final dio = Dio();
  static final apiKey = dotenv.env['apiKey'];
  static final cache = Hive.box('newsBox');
  static final appCache = Hive.box('app');

  static Future<List<News>> fetchApi(String category) async {
    try {
      final response = await dio.get(
        'https://newsapi.org/v2/top-headlines/sources?category=$category',
        options: Options(
          headers: {
            'Authorization': apiKey,
          },
        ),
      );

      Map<String, dynamic> raw = response.data;
      List<dynamic> newsList = raw['sources'];
      List<News> news = List.generate(
        newsList.length,
            (index) => News.fromMap(
          newsList[index],
        ),
      );

      await cache.put(category, news);
      await appCache.put('categoryTime', DateTime.now());

      return news;
    } on DioError catch (e) {
       if (e.type == DioErrorType.connectionTimeout || e.type == DioErrorType.receiveTimeout) {
        if (e.message?.contains('SocketException') == true) {
          throw Exception('Poor internet connection. Please try again!');
        } else {
          throw Exception('Problem connecting to the server. Please try again');
        }
      }
      throw Exception(e.toString());
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<List<News>?> fetchHive(String category) async {
    try {
      List<dynamic>? cachedNews = cache.get(category);

      if (cachedNews == null) return null;

      List<News>? news = List.generate(
        cachedNews.length,
            (index) => cachedNews[index],
      );
      return news;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}

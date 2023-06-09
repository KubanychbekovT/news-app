part of 'article_cubit.dart';

class ArticlesDataProvider {
  static final dio = Dio();
  static final apiKey = dotenv.env['apiKey'];
  static final cache = Hive.box('articlesbox');
  static final appCache = Hive.box('app');

  static Future<List<Article>> fetch({String? keyword}) async {
    try {
      final response = await dio.get(
        'https://newsapi.org/v2/everything?q=$keyword',
        options: Options(
          headers: {
            'Authorization': apiKey,
          },
        ),
      );
      
      Map raw = response.data;
      List articleList = raw['articles'];

      List<Article> articles = List.generate(
        articleList.length,
            (index) =>
            Article.fromMap(
              articleList[index],
            ),
      );

      await cache.put(keyword, articles);
      await appCache.put('articlesTime', DateTime.now());

      return articles;
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectionTimeout || e.type == DioErrorType.receiveTimeout) {
        if (e.message?.contains('SocketException') == true) {
          throw Exception('Poor internet connection. Please try again!');
        } else {
          throw Exception(e.message);
        }
      } else {
        throw Exception('Problem connecting to the server. Please try again.');
      }
    } catch (e) {
      throw Exception("Internal Server Error");
    }
  }

  static Future<List<Article>?> fetchHive(String keyword) async {
    try {
      List? cachedArticle = cache.get(keyword);

      if (cachedArticle == null) return null;

      List<Article>? article = List.generate(
        cachedArticle.length,
            (index) => cachedArticle[index],
      );
      return article;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
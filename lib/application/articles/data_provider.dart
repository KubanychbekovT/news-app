part of 'article_cubit.dart';

class ArticlesDataProvider {
  static final dio = Dio();
  static const apiKey = Constants.apiKey;

  static Future<ListArticle>> fetch(String keyword) async {
    try {
      final response = await dio.get(
        'https://newsapi.org/v2/everything/q=$keyword',
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

      return articles;
    } on DioError catch (e) {
      if (DioErrorType.other == e.type) {
        if (e.message.contains('SocketException')) {
          throw Exception('Poor internet connection. Please try again!');
        } else {
          throw Exception(e.message);
        }
      }else{
        throw Exception('Problem connecting to the server. Please try again.');
      }
    } catch (e) {
      throw Exception("Internal Server Error");
    }
  }
}
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:news_app/application/articles/article_cubit.dart';
import 'package:news_app/application/top_headlines/top_headlines_cubit.dart';
import 'package:news_app/application/providers/category_provider.dart';
import 'package:news_app/domain/models/article/article.dart';
import 'package:news_app/domain/models/article/article_source.dart';
import 'package:news_app/domain/models/news.dart';
import 'package:news_app/presentation/dashboard/dashboard.dart';
import 'package:news_app/presentation/splash/splash.dart';
import 'package:news_app/presentation/top_stories/top_stories.dart';
import 'package:provider/provider.dart';

import 'application/providers/theme_provider.dart';

void main() async {
  await Hive.initFlutter();

  Hive.registerAdapter<News>(NewsAdapter());
  Hive.registerAdapter<Article>(ArticleAdapter());
  Hive.registerAdapter<ArticleSource>(ArticleSourceAdapter());

  await Hive.openBox('app');
  await Hive.openBox('newsBox');
  await Hive.openBox('articlesbox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MultiProvider(
        providers: [
          BlocProvider(create: (_) => ArticlesCubit()),
          BlocProvider(create: (_) => TopHeadlinesCubit()),
          ChangeNotifierProvider(create: (_) => ThemeProvider()),
          ChangeNotifierProvider(create: (_) => CategoryProvider()),
        ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialChild(
          provider: themeProvider,
          );
        },
        ),
    );
  }
}

class MaterialChild extends StatelessWidget {
  final ThemeProvider provider;
  const MaterialChild({super.key, required this.provider});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'News App',
      themeMode: provider.isDark ? ThemeMode.dark : ThemeMode.light,
      theme: theme.themeLight,
      darkTheme: theme.themeDark,
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/dashboard': (context) => const DashboardScreen(),
        '/top-stories': (context) => const TopStoriesScreen(),
      },
    );
  }
}

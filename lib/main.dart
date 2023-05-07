import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:news_app/application/top_headlines/top_headlines_cubit.dart';
import 'package:news_app/application/providers/category_provider.dart';
import 'package:news_app/domain/models/news.dart';
import 'package:news_app/presentation/dashboard/dashboard.dart';
import 'package:news_app/presentation/splash/splash.dart';
import 'package:provider/provider.dart';

void main() async {
  await Hive.initFlutter();

  Hive.registerAdapter<News>(NewsAdapter());

  await Hive.openBox('app');
  await Hive.openBox('newsBox');

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
          ChangeNotifierProvider(create: (_) => CategoryProvider()),
          BlocProvider(create: (context) => TopHeadlinesCubit(),
          )
        ],
      child: MaterialApp(
        title: 'News App',
        debugShowCheckedModeBanner: false,
        theme: theme.themeLight,
        initialRoute: '/splash',
        routes: {
      '/splash': (context) => SplashScreen(),
      '/dashboard': (context) => DashboardScreen(),
      '/top-stories': (context) => TopStoriesScreen(),
      },
      ),
    );
  }
}

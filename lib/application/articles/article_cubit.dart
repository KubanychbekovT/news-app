import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../domain/models/article/article.dart';
import '../../presentation/constants/constants.dart';


part 'data_provider.dart';
part 'article_state.dart';
part 'repository.dart';

class ArticlesCubit extends Cubit<ArticlesState> {
  static ArticlesCubit cubit(BuildContext context, [bool listen = false]) =>
      BlocProvider.of<ArticlesCubit>(context, listen: listen);

  ArticlesCubit() : super(ArticlesDefault());

  final repo = ArticlesRepository();

  Future<void> fetch({String? keyword}) async {
    emit(const ArticlesFetchLoading());
    try {
      keyword ??= 'lateset';

      Duration? difference;
      final currentTime = DateTime.now();
      List<Article>? data = [];

      data = await repo.fetchHive(keyword);
      DateTime? articlesTime = Hive.box('app').get('articlesTime');
      if (articlesTime != null) {
        difference = currentTime.difference(articlesTime);
      }
      if (data == null || (difference != null && difference.inHours > 1)) {
        data = await repo.fetchApi(keyword);
      }
      emit(ArticlesFetchSuccess(data: data));
    } catch (e) {
      emit(ArticlesFetchFailed(message: e.toString()));
    }
  }
}

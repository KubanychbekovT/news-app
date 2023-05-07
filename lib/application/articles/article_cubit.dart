import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';

part 'data_provider.dart';
part 'article_state.dart';
part 'repository.dart';

class ArticlesCubit extends Cubit<ArticlesState> {
  static ArticlesCubit() cubit(BuildContext context, [bool listen = false]) =>
      BlocProvider.of<ArticlesCubit(context, listen: listen);

  ArticlesCubit() : super(ArticlesDefault());

  final repo = ArticlesRepository();

  Future<void> fetch(String keyword) async {
    emit(const ArticlesFetchLoading());
    try {
      final data = await repo.fetch(keyword);

      emit(ArticlesFetchSuccess(data: data));
    } catch (e) {
      emit(ArticlesFetchFailded(message: e.toString()));
    }
  }
}

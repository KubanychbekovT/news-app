import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:news_app/domain/models/news.dart';
import 'package:news_app/presentation/constants/constants.dart';
import 'package:hive_flutter/adapters.dart';

part 'top_headlines_state.dart';
part 'data_provider.dart';
part 'repository.dart';

class TopHeadlinesCubit extends Cubit<TopHeadlinesState> {
  TopHeadlinesCubit() : super(TopHeadlinesLoading());

  final repository = NewsRepository();

  Future<void> fetch(String category) async {
    emit(
      const TopHeadlinesLoading(),
    );
    try {
      Duration? difference;
      final currentTheme = DateTime.now();
      List<News?>? data = [];

      data = await repository.fetchHive(category);

      DateTime? categoryTime = Hive.box('app').get('categoryTime');
      if (categoryTime != null) {
        difference = currentTheme.difference(categoryTime);
      }

      if (data == null || (difference != null && difference.inHours > 1)) {
        data = await repository.fetchApi(category);
      }
      emit(
        TopHeadlinesSuccess(data: data),
      );
    } catch (e) {
      emit(
        TopHeadlinesFailure(e.toString()),
      );
    }
  }
}

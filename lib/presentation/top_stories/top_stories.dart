import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:news_app/application/top_headlines/top_headlines_cubit.dart';
import 'package:news_app/domain/animations/bottom_animation.dart';
import 'package:news_app/infrastructure/configs/space.dart';
import '../widgets/headlines_card.dart';

class TopStoriesScreen extends StatelessWidget {
  const TopStoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;

    final newsCubit = BlocProvider.of<TopHeadlinesCubit>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          toBeginningOfSentenceCase(
            args['title'].toString(),
          )!,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: Space.all(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: newsCubit.state.data!
                .map((e) => BottomAnimator(
                child: HeadlinesCard(
                  news: e!,
                ),
            ),
            )
                  .toList(),
          ),
        ),
      ),
    );
  }
}

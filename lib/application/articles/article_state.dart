part of 'article_cubit.dart';

@immutable
class ArticlesState extends Equatable {
  final Article? data;
  final String? message;

  const ArticlesState({
    this.data,
    this.message,
});

  @override
  List<Object?> get props => [data, message];
 }

 @immutable
class ArticlesDefault extends ArticlesState {}

 @immutable
class ArticlesFetchLoading extends ArticlesState {
  const ArticlesFetchLoading() : super();
 }

 @immutable
class ArticlesFetchSuccess extends ArticlesState {
  const ArticlesFetchSuccess({Article? data}) : super(data: data);
 }

 @immutable
class ArticlesFetchFailded extends ArticlesState {
  const ArticlesFetchFailded({String? message}): super(message: message);
 }

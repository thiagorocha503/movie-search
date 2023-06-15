import 'package:equatable/equatable.dart';

import 'package:movie_search_app/language/model/language.dart';
import 'package:movie_search_app/movie_overview/model/movie_list.dart';

abstract class MovieOverviewEvent extends Equatable {}

class MovieOverviewFetched extends MovieOverviewEvent {
  final MovieList list;
  final Language lang;
  final int page;
  MovieOverviewFetched({
    required this.list,
    required this.lang,
    required this.page,
  });

  @override
  List<Object?> get props => [list, lang, page];
}

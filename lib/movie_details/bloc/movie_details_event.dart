import 'package:equatable/equatable.dart';

import 'package:movie_search_app/language/model/language.dart';

abstract class MovieDetailsEvent extends Equatable {}

class MovieDetailsFetched extends MovieDetailsEvent {
  final int id;
  final Language language;
  MovieDetailsFetched({required this.id, required this.language});

  @override
  List<Object?> get props => [id, language];
}

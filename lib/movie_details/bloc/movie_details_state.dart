import 'package:equatable/equatable.dart';

import 'package:movie_search_app/movie_details/model/movie.dart';

abstract class MovieDetailsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class MovieDetailsInitialState extends MovieDetailsState {}

class MovieDetailsLoading extends MovieDetailsState {}

class MovieDetailsLoaded extends MovieDetailsState {
  final Movie movie;

  MovieDetailsLoaded({required this.movie});
  @override
  List<Object?> get props => [movie];
}

class MovieDetailsError extends MovieDetailsState {
  final String error;

  MovieDetailsError({required this.error});
  @override
  List<Object?> get props => [error];
}

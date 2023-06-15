import 'package:equatable/equatable.dart';

import 'package:movie_search_app/movie_overview/model/movie_preview.dart';

abstract class MovieOverviewState extends Equatable {
  @override
  List<Object?> get props => [];
}

class MovieOverviewInitial extends MovieOverviewState {}

class MovieOverviewLoading extends MovieOverviewState {}

class MovieOverviewLoaded extends MovieOverviewState {
  final int page;
  final int totalPages;
  final List<MoviePreview> movies;

  MovieOverviewLoaded({
    required this.movies,
    required this.page,
    required this.totalPages,
  });
  @override
  List<Object?> get props => [movies, totalPages, page];
}

class MovieOverviewError extends MovieOverviewState {
  final String error;

  MovieOverviewError({required this.error});
  @override
  List<Object?> get props => [error];
}

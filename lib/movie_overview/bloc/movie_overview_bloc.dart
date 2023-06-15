import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:movie_search_app/movie_overview/bloc/movie_overview_event.dart';
import 'package:movie_search_app/movie_overview/bloc/movie_overview_state.dart';
import 'package:movie_search_app/movie_overview/model/result_search.dart';
import 'package:movie_search_app/repository/movie_repository.dart';

class MovieOverviewBloc extends Bloc<MovieOverviewEvent, MovieOverviewState> {
  final IMovieRepository repository;
  MovieOverviewBloc(
      {required MovieOverviewState initialState, required this.repository})
      : super(initialState) {
    on<MovieOverviewFetched>(_onMovieOverviewFetched);
  }

  Future<void> _onMovieOverviewFetched(
    MovieOverviewFetched event,
    Emitter<MovieOverviewState> emit,
  ) async {
    MovieOverviewState currentState = state;

    try {
      if (currentState is MovieOverviewInitial ||
          currentState is MovieOverviewError) {
        emit(MovieOverviewLoading());
        ResultSearch result = await repository.getMovies(
          page: 1,
          lang: event.lang,
          list: event.list,
        );
        emit(
          MovieOverviewLoaded(
            movies: result.results,
            page: result.page,
            totalPages: result.totalPages,
          ),
        );
      }
      if (currentState is MovieOverviewLoaded) {
        if (event.page > currentState.totalPages) {
          return;
        }
        ResultSearch result = await repository.getMovies(
          page: event.page,
          lang: event.lang,
          list: event.list,
        );
        MovieOverviewLoaded newState = MovieOverviewLoaded(
          movies: List.of(currentState.movies)..addAll(result.results),
          page: result.page,
          totalPages: result.totalPages,
        );
        emit(newState);
      }
    } on Exception catch (e) {
      emit(
        MovieOverviewError(error: e.toString().replaceFirst("Exception: ", "")),
      );
    }
  }
}

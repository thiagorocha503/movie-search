import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:movie_search_app/movie_details/bloc/movie_details_event.dart';
import 'package:movie_search_app/movie_details/bloc/movie_details_state.dart';
import 'package:movie_search_app/movie_details/model/movie.dart';
import 'package:movie_search_app/repository/movie_repository.dart';

class MovieDetailsBloc extends Bloc<MovieDetailsEvent, MovieDetailsState> {
  final IMovieRepository repository;
  MovieDetailsBloc(
      {required MovieDetailsState initialState, required this.repository})
      : super(initialState) {
    on<MovieDetailsFetched>(_onMovieDetailsFetched);
  }

  Future<void> _onMovieDetailsFetched(
    MovieDetailsFetched event,
    Emitter<MovieDetailsState> emit,
  ) async {
    MovieDetailsState currentState = state;
    try {
      emit(MovieDetailsLoading());
      if (currentState is MovieDetailsLoaded ||
          currentState is MovieDetailsInitialState) {
        Movie movie =
            await repository.getMovieByID(id: event.id, lang: event.language);
        emit(MovieDetailsLoaded(
          movie: movie,
        ));
      }
    } catch (e) {
      emit(
        MovieDetailsError(error: e.toString()),
      );
    }
  }

  void dispose() {
    super.close();
  }
}

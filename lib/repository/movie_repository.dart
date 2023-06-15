import 'package:movie_search_app/data/movie_api.dart';
import 'package:movie_search_app/language/model/language.dart';
import 'package:movie_search_app/movie_details/model/movie.dart';
import 'package:movie_search_app/movie_overview/model/movie_list.dart';
import 'package:movie_search_app/movie_overview/model/result_search.dart';

abstract class IMovieRepository {
  Future<ResultSearch> getMovies({
    required int page,
    required Language lang,
    MovieList list,
  });
  Future<Movie> getMovieByID({
    required int id,
    required Language lang,
  });
}

class MovieRepository implements IMovieRepository {
  final IMovieApi api;
  const MovieRepository({required this.api});

  @override
  Future<ResultSearch> getMovies({
    MovieList list = MovieList.popular,
    required int page,
    required Language lang,
  }) async {
    return await api.getMovies(page: page, type: list, lang: lang);
  }

  @override
  Future<Movie> getMovieByID({required int id, required Language lang}) async {
    return await api.getMovieById(id: id, lang: lang);
  }
}

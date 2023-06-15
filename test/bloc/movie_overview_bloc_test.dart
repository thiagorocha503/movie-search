import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:movie_search_app/language/model/code.dart';
import 'package:movie_search_app/language/model/language.dart';
import 'package:movie_search_app/movie_overview/bloc/bloc.dart';
import 'package:movie_search_app/movie_overview/model/movie_list.dart';
import 'package:movie_search_app/movie_overview/model/movie_preview.dart';
import 'package:movie_search_app/movie_overview/model/result_search.dart';
import 'package:movie_search_app/repository/movie_repository.dart';

import 'movie_overview_bloc_test.mocks.dart';

MoviePreview emptyMovie(int id) {
  return MoviePreview(
    adult: false,
    backdropPath: null,
    genreIds: const [],
    id: id,
    originalLanguage: "",
    originalTitle: "",
    overview: "",
    popularity: 0.0,
    posterPath: "",
    releaseDate: DateTime(2023, 10, 1),
    title: "",
    video: false,
    voteAverage: 0.0,
    voteCount: 0,
  );
}

@GenerateMocks([MovieRepository])
void main() {
  late MovieOverviewBloc bloc;
  late MovieRepository repository;
  List<MoviePreview> data = List.generate(10, (index) => emptyMovie(index + 1));

  setUp(() {
    repository = MockMovieRepository();
    bloc = MovieOverviewBloc(
      initialState: MovieOverviewInitial(),
      repository: repository,
    );
  });

  blocTest<MovieOverviewBloc, MovieOverviewState>(
    'Movie overview initial fetch error',
    build: () => bloc,
    setUp: () {
      when(repository.getMovies(
        page: 1,
        lang: const Language(
          code: LangISOCode.en_US,
          name: "English",
        ),
        list: MovieList.popular,
      )).thenThrow(Exception("Fetched error"));
    },
    act: (bloc) {
      bloc.add(
        MovieOverviewFetched(
          list: MovieList.popular,
          lang: const Language(code: LangISOCode.en_US, name: "English"),
          page: 1,
        ),
      );
    },
    verify: (bloc) => verify(repository.getMovies(
      page: 1,
      lang: const Language(
        code: LangISOCode.en_US,
        name: "English",
      ),
      list: MovieList.popular,
    )).called(1),
    expect: () => <MovieOverviewState>[
      MovieOverviewLoading(),
      MovieOverviewError(error: "Fetched error")
    ],
  );

  blocTest<MovieOverviewBloc, MovieOverviewState>(
    'Movie overview initial fetch success',
    build: () => bloc,
    setUp: () {
      when(repository.getMovies(
        page: 1,
        lang: const Language(
          code: LangISOCode.en_US,
          name: "English",
        ),
        list: MovieList.popular,
      )).thenAnswer((_) {
        ResultSearch result = ResultSearch(
          page: 1,
          results: data,
          totalPages: 100,
          totalResults: 1000,
        );
        return Future.value(result);
      });
    },
    act: (bloc) {
      bloc.add(
        MovieOverviewFetched(
          list: MovieList.popular,
          lang: const Language(code: LangISOCode.en_US, name: "English"),
          page: 1,
        ),
      );
    },
    verify: (bloc) => verify(repository.getMovies(
      page: 1,
      lang: const Language(
        code: LangISOCode.en_US,
        name: "English",
      ),
      list: MovieList.popular,
    )).called(1),
    expect: () => <MovieOverviewState>[
      MovieOverviewLoading(),
      MovieOverviewLoaded(
        movies: data,
        page: 1,
        totalPages: 100,
      )
    ],
  );

  blocTest<MovieOverviewBloc, MovieOverviewState>(
    'Movie overview new fecth success',
    build: () => bloc
      ..add(
        MovieOverviewFetched(
          list: MovieList.popular,
          lang: const Language(code: LangISOCode.en_US, name: "English"),
          page: 1,
        ),
      ),
    setUp: () {
      when(repository.getMovies(
        page: 1,
        lang: const Language(
          code: LangISOCode.en_US,
          name: "English",
        ),
        list: MovieList.popular,
      )).thenAnswer((_) {
        ResultSearch result = ResultSearch(
          page: 1,
          results: data,
          totalPages: 100,
          totalResults: 1000,
        );
        return Future.value(result);
      });
      when(repository.getMovies(
        page: 2,
        lang: const Language(
          code: LangISOCode.en_US,
          name: "English",
        ),
        list: MovieList.popular,
      )).thenAnswer((_) {
        ResultSearch result = ResultSearch(
          page: 2,
          results: List.generate(10, (index) => emptyMovie(index + 11)),
          totalPages: 100,
          totalResults: 1000,
        );
        return Future.value(result);
      });
    },
    act: (bloc) {
      bloc.add(
        MovieOverviewFetched(
          list: MovieList.popular,
          lang: const Language(code: LangISOCode.en_US, name: "English"),
          page: 2,
        ),
      );
    },
    verify: (bloc) => verify(repository.getMovies(
      page: 1,
      lang: const Language(
        code: LangISOCode.en_US,
        name: "English",
      ),
      list: MovieList.popular,
    )).called(1),
    expect: () => <MovieOverviewState>[
      MovieOverviewLoading(),
      MovieOverviewLoaded(
        movies: data,
        page: 1,
        totalPages: 100,
      ),
      MovieOverviewLoaded(
        movies: List.generate(20, (index) => emptyMovie(index + 1)),
        page: 2,
        totalPages: 100,
      )
    ],
  );

  blocTest<MovieOverviewBloc, MovieOverviewState>(
    'Movie overview new fecth error',
    build: () => bloc
      ..add(
        MovieOverviewFetched(
          list: MovieList.popular,
          lang: const Language(code: LangISOCode.en_US, name: "English"),
          page: 1,
        ),
      ),
    setUp: () {
      when(repository.getMovies(
        page: 2,
        lang: const Language(
          code: LangISOCode.en_US,
          name: "English",
        ),
        list: MovieList.popular,
      )).thenThrow(Exception("Fetched error"));
      when(repository.getMovies(
        page: 1,
        lang: const Language(
          code: LangISOCode.en_US,
          name: "English",
        ),
        list: MovieList.popular,
      )).thenAnswer((_) {
        ResultSearch result = ResultSearch(
          page: 1,
          results: data,
          totalPages: 100,
          totalResults: 1000,
        );
        return Future.value(result);
      });
    },
    act: (bloc) {
      bloc.add(
        MovieOverviewFetched(
          list: MovieList.popular,
          lang: const Language(code: LangISOCode.en_US, name: "English"),
          page: 2,
        ),
      );
    },
    verify: (bloc) => verify(repository.getMovies(
      page: 1,
      lang: const Language(
        code: LangISOCode.en_US,
        name: "English",
      ),
      list: MovieList.popular,
    )).called(1),
    expect: () => <MovieOverviewState>[
      MovieOverviewLoading(),
      MovieOverviewLoaded(
        movies: List.generate(10, (index) => emptyMovie(index + 1)),
        page: 1,
        totalPages: 100,
      ),
      MovieOverviewError(error: "Fetched error")
    ],
  );
}

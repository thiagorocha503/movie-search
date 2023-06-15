import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:movie_search_app/language/bloc/language_cubit.dart';
import 'package:movie_search_app/language/shared_preferences/language_preferences.dart';
import 'package:movie_search_app/movie_overview/bloc/bloc.dart';
import 'package:movie_search_app/movie_overview/model/movie_list.dart';
import 'package:movie_search_app/movie_overview/ui/movie_overview_page.dart';
import 'package:movie_search_app/repository/movie_repository.dart';

class App extends StatelessWidget {
  const App({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    LanguagePreferences languagePreferences = LanguagePreferences(
      prefs: context.watch<SharedPreferences>(),
    );
    LanguageCubit languageCubit = LanguageCubit(
      prefs: languagePreferences,
      language: languagePreferences.getLanguage(),
    );
    MovieOverviewBloc movieOverviewBloc = MovieOverviewBloc(
      initialState: MovieOverviewInitial(),
      repository: context.read<IMovieRepository>(),
    )..add(MovieOverviewFetched(
        list: MovieList.popular,
        page: 1,
        lang: languageCubit.state,
      ));
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => movieOverviewBloc,
        ),
        BlocProvider<LanguageCubit>(create: (context) => languageCubit)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Movie search app',
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),
        home: const MovieOverviewPage(title: 'Movie search app'),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:movie_search_app/app.dart';
import 'package:movie_search_app/data/movie_api.dart';
import 'package:movie_search_app/repository/movie_repository.dart';

void main() async {
  // load env
  await dotenv.load(fileName: ".env");
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(
    MultiProvider(
      providers: [
        Provider<SharedPreferences>(
          create: (context) => prefs,
        ),
        Provider<IMovieRepository>(
          create: (context) => MovieRepository(api: MovieApi()),
        )
      ],
      child: const App(),
    ),
  );
}

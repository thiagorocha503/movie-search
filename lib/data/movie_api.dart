// ignore_for_file: non_constant_identifier_names
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import 'package:movie_search_app/language/model/language.dart';
import 'package:movie_search_app/movie_details/model/movie.dart';
import 'package:movie_search_app/movie_overview/model/movie_list.dart';
import 'package:movie_search_app/movie_overview/model/result_search.dart';
import 'package:movie_search_app/util/convertion.dart';

abstract class IMovieApi {
  Future<ResultSearch> getMovies(
      {int page = 1, required MovieList type, required Language lang});
  Future<Movie> getMovieById({required int id, required Language lang});
}

class MovieApi implements IMovieApi {
  final String BASE_URL = "https://api.themoviedb.org/3";
  final String API_KEY = dotenv.get("API_KEY");

  @override
  Future<ResultSearch> getMovies({
    int page = 1,
    MovieList type = MovieList.popular,
    required Language lang,
  }) async {
    String typeStr;
    switch (type) {
      case MovieList.popular:
        typeStr = "popular";
        break;
      case MovieList.topRated:
        typeStr = "top_rated";
        break;
      case MovieList.upcoming:
        typeStr = "upcoming";
        break;
      case MovieList.nowPlaying:
        typeStr = "now_playing";
        break;
    }
    String url =
        "$BASE_URL/movie/$typeStr?api_key=$API_KEY&language=${languageToString(lang)}&page=$page";
    debugPrint(url);
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return ResultSearch.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Fetch popular movies error");
    }
  }

  @override
  Future<Movie> getMovieById({required int id, required Language lang}) async {
    String url =
        "$BASE_URL/movie/$id?api_key=$API_KEY&language=${languageToString(lang)}";
    debugPrint(url);
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return Movie.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Fetch movies details error");
    }
  }
}


import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:movie_search_app/model/movie_detail.dart';
import 'package:movie_search_app/model/movie_search.dart';

class IMovieAPIProvider {
  Future<List<MovieSearch>> findByName(String name) async => null;
  Future<MovieDetail> findById(int id) async => null;
  CachedNetworkImageProvider getPoster(String path,{String size="w45"})=> null;
}

class MovieAPIProviderImpl implements IMovieAPIProvider {
  static const String API_REST_KEY = "ff0666867ee3ac64ab7ba89aad1dcc24";
  static const String URL_MOVIE_SEARCH =
      "https://api.themoviedb.org/3/search/movie?api_key=$API_REST_KEY&query=";
  static const String URL_MOVIE_ID =
      "https://api.themoviedb.org/3/movie/";
  static const BASE_URL_IMAGE = "http://image.tmdb.org/t/p";

  @override
  Future<List<MovieSearch>> findByName(String name,{String lang="pt-BR"}) async {
    String url = "$URL_MOVIE_SEARCH$name+&language=$lang";
    final response = await http.get(url);
    List<MovieSearch> movies = List<MovieSearch>();
    debugPrint("api> ${response.body}");
    switch (response.statusCode) {
      case 200:
        Map result = jsonDecode(response.body);
        print(">>> $result");
        for (var movie in result["results"]) {
          movies.add(MovieSearch.fromJson(movie));
        }
        return movies;
      case 401:
        throw Exception("Invalid API key <$API_REST_KEY:>");
      case 404:
        throw Exception("The resource you requested could not be found.");
      default:
        throw Exception("API REST Erro insperado");
    }
  }

  @override
  Future<MovieDetail> findById(int id,{String lang="pt-BR"}) async {
    String url = "$URL_MOVIE_ID$id?api_key=$API_REST_KEY&language=$lang";
    final response = await http.get(url);
    switch (response.statusCode) {
      case 200:
        Map result = jsonDecode(response.body);
        return MovieDetail.fromJson(result);
      case 401:
        throw Exception("Invalid API key <$API_REST_KEY>");
      case 404:
        throw Exception("The resource you requested could not be found.");
      default:
        throw Exception("API REST Erro insperado");
    }
  }

  @override
  CachedNetworkImageProvider getPoster(String path,{String size="w45"}){
    String url = "$BASE_URL_IMAGE/$size/$path";
    return CachedNetworkImageProvider(url);
    

  }
}

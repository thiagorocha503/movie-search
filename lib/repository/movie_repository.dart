

import 'package:movie_search_app/data/movie_api_provider.dart';
import 'package:movie_search_app/model/movie_detail.dart';
import 'package:movie_search_app/model/movie_search.dart';

class IMovieRepository{

  Future<List<MovieSearch>> findByName(String name) async =>null;
  Future<MovieDetail> findById(int id) async =>null;
}

class MovieRepositoryImpl implements IMovieRepository{
  IMovieAPIProvider _api;

  MovieRepositoryImpl(this._api);

  @override
  Future<MovieDetail> findById(int id) async {
    return await this._api.findById(id);
  }

  @override
  Future<List<MovieSearch>> findByName(String name) async {
    return await  this._api.findByName(name);
  }

  
}
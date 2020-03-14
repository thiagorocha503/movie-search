
import 'package:movie_search_app/data/movie_api_provider.dart';
import 'package:movie_search_app/model/movie_detail.dart';
import 'package:movie_search_app/model/movie_search.dart';
import 'package:movie_search_app/repository/movie_repository.dart';
import 'package:movie_search_app/view/view.dart';

class IMainPresenter{
  Future<List<Map>> findMovieByName(String name, {String lang="pt-BR"}) async => null;
  void setView(IMainPage view){}
}
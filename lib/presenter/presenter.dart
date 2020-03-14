
import 'package:movie_search_app/data/movie_api_provider.dart';
import 'package:movie_search_app/model/movie_detail.dart';
import 'package:movie_search_app/model/movie_search.dart';
import 'package:movie_search_app/repository/movie_repository.dart';
import 'package:movie_search_app/view/view.dart';

class IMainPresenter{
  Future<List<Map>> findMovieByName(String name, {String lang="pt-BR"}) async => null;
  void setView(IMainPage view){}
}

class MainPresenterImpl implements IMainPresenter{
  
  IMainPage _view;
  IMovieRepository _repository;

  MainPresenterImpl(this._repository);

  @override
  Future<List<Map>> findMovieByName(String name, {String lang = "pt-BR"}) async {
    List<MovieSearch> result = await this._repository.findByName(name);
    List<Map<dynamic, dynamic>> movies = List();
    for(MovieSearch e in result){
      movies.add(e.toJson());
    }
    return movies;
  }

  @override
  void setView(IMainPage view) {
    this._view = view;
  }

}
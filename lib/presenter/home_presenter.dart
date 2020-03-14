import 'package:cached_network_image/cached_network_image.dart';
import 'package:movie_search_app/model/movie_search.dart';
import 'package:movie_search_app/presenter/presenter.dart';
import 'package:movie_search_app/repository/movie_repository.dart';
import 'package:movie_search_app/view/view.dart';

class HomePresenterImpl implements IMainPresenter{
  
  IMainPage _view;
  IMovieRepository _repository;

  HomePresenterImpl(this._repository);

  @override
  Future<List<Map>> findMovieByName(String name, {String lang = "pt-BR"}) async {
    //await Future.delayed(Duration(seconds: 5));
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

  @override
  CachedNetworkImageProvider getPoster(String path, {String size = "w45"}) {
    return this._repository.getPoster(path);
  }

}
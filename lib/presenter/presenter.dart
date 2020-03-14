
import 'package:cached_network_image/cached_network_image.dart';
import 'package:movie_search_app/view/view.dart';

class IMainPresenter{
  Future<List<Map>> findMovieByName(String name, {String lang="pt-BR"}) async => null;
  CachedNetworkImageProvider getPoster(String path,{String size="w45"})=> null;
  void setView(IMainPage view){}
}
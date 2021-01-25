import 'package:movie_app/model/Cast.dart';
import 'package:movie_app/resource/api_provider.dart';
import 'package:movie_app/resource/db_provider.dart';

class Repository{
  static final Repository _repository = new Repository();
  ApiProvider _apiProvider  = ApiProvider.get();
  DbProvider _dbProvider = DbProvider.get();

  static Repository get(){
    return _repository;
  }

  Future<List<Cast>> fetchCastMovies(int mediaId) async{
    List<Cast> list = await _dbProvider.fetchCasts(mediaId);
    if(list != null){
      return list;
    }
    list = await _apiProvider.fetchCreditMovies(mediaId: mediaId);

    list.forEach((element) => _dbProvider.addCast(element));
    return list;
  }

  Future<List<Cast>> fetchCastShows(int mediaId) async{
    List<Cast> list = await _dbProvider.fetchCasts(mediaId);
    if(list != null){
      return list;
    }
    list = await _apiProvider.fetchCreditShow(mediaId: mediaId);

    list.forEach((element) => _dbProvider.addCast(element));
    return list;
  }


}
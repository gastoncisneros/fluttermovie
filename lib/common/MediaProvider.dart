import 'package:movie_app/resource/api_provider.dart';
import 'package:movie_app/model/Cast.dart';
import 'package:movie_app/model/Media.dart';
import 'dart:async';

import 'package:movie_app/resource/repository.dart';

abstract class MediaProvider{
  Repository _repository = Repository.get();
  Future<List<Media>> fetchMedia(String category);
  Future<List<Cast>> fetchCast(int mediaId);
}

class MovieProvider extends MediaProvider{
  ApiProvider _client = ApiProvider.get();

  @override
  Future<List<Media>> fetchMedia(String category) {
    // TODO: implement fetchMedia
    return _client.fetchMovies(category: category);
  }

  @override
  Future<List<Cast>> fetchCast(int mediaId) {
    // TODO: implement fetchCreditMedia
    return _repository.fetchCastMovies(mediaId);
  }
}

class ShowProvider extends MediaProvider{
  ApiProvider _client = ApiProvider.get();
  
  @override
  Future<List<Media>> fetchMedia(String category) {
    // TODO: implement fetchMedia
    return _client.fetchShow(category: category);
  }

  @override
  Future<List<Cast>> fetchCast(int mediaId) {
    // TODO: implement fetchCreditMedia
    return _repository.fetchCastShows(mediaId);
  }
}

enum MediaType {movie, show}
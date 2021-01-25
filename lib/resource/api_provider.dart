import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:movie_app/common/Constants.dart';
import 'package:movie_app/common/MediaProvider.dart';
import 'package:movie_app/model/Cast.dart';
import 'package:movie_app/model/Media.dart';

class ApiProvider{

  static final _apiProvider = new ApiProvider();

  static ApiProvider get(){
    return _apiProvider;
  }

  final String _baseUrl = "api.themoviedb.org";
  final String _lenguaje = "es-ES";


  Future<dynamic> getJson(Uri uri) async{
    http.Response response = await http.get(uri);
    return json.decode(response.body);
  }

//--------------------MEDIA-----------------------------------//
  //La Uri se arma con la url, los datos del query string,
  //y los parametros opcionales, salvo el api_key que es obligatorio
  Future<List<Media>> fetchMovies({String category:"popular"}) async{
    var uri = new Uri.https(_baseUrl, "3/movie/$category",{
      'api_key' : API_KEY,
      'page': "1",
      'language':_lenguaje
    });
    return getJson(uri).then((data) => 
      //Dentro de results esta el json response
      data['results'].map<Media>((item) => new Media(item, MediaType.movie)).toList()
    );
  }

  Future<List<Media>> fetchShow({String category:"popular"}) async{
    var uri = new Uri.https(_baseUrl, "3/tv/$category",{
      'api_key' : API_KEY,
      'page': "1",
      'language':_lenguaje
    });
    return getJson(uri).then((data) => 
      //Dentro de results esta el json response
      data['results'].map<Media>((item) => new Media(item, MediaType.show)).toList()
    );
  }
//--------------------MEDIA-----------------------------------//


//--------------------ACTORES-----------------------------------//

    Future<List<Cast>> fetchCreditMovies({int mediaId}) async{
    print('${mediaId.toString()} Lectura de TMBD pasa movies');
    var uri = new Uri.https(_baseUrl, "3/movie/$mediaId/credits",{
      'api_key' : API_KEY,
      'page': "1",
      'language':_lenguaje
    });
    return getJson(uri).then((data) => 
      //Dentro de cast esta el json response de cast
      data['cast'].map<Cast>((item) => new Cast(item, MediaType.movie, mediaId)).toList()
    );
  }

    Future<List<Cast>> fetchCreditShow({int mediaId}) async{
    print('${mediaId.toString()} Lectura de TMBD para shows');
    var uri = new Uri.https(_baseUrl, "3/tv/$mediaId/credits",{
      'api_key' : API_KEY,
      'page': "1",
      'language':_lenguaje
    });
    return getJson(uri).then((data) => 
      //Dentro de cast esta el json response de cast
      data['cast'].map<Cast>((item) => new Cast(item, MediaType.show, mediaId)).toList()
    );
  }
  
//--------------------ACTORES-----------------------------------//

}
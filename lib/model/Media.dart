import 'package:movie_app/common/MediaProvider.dart';
import 'package:movie_app/common/Util.dart';

class Media{
  int id;
  double voteAverage;
  String title;
  String posterPath;
  String backdropPath;
  String overview;
  String releaseDate;
  List<dynamic> genreIds;

  //Imagen Larga
  String getPosterUrl() => getMediumPictureUrl(posterPath); 
  
  //Imagen Corta
  String getBackDropUrl() => getLargePictureUrl(backdropPath); 

  String getGenres() => getGenreValues(genreIds);

  int getReleaseYear(){
    if(releaseDate != null && releaseDate != "")
      return  DateTime.parse(releaseDate).year;
    
    return 0;
  }

  //Es un constructor basado en el patron de diseño Factory
  factory Media(Map jsonMap, MediaType mediaType){
    try{
      return new Media.deserialize(jsonMap, mediaType);
    }catch(ex){
      throw ex;
    }
  }
  
  Media.deserialize(Map json, MediaType mediaType) :
    id = json["id"].toInt(),
    voteAverage = json["vote_average"].toDouble(),
    title = json[mediaType == MediaType.movie ? "title" : "name"],
    posterPath = json["poster_path"] ?? "",
    backdropPath = json["backdrop_path"] ?? "",
    overview = json["overview"],
    releaseDate = json[mediaType == MediaType.movie ? "release_date" : "first_air_date"],
    genreIds = json["genre_ids"].toList();

}

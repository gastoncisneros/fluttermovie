import 'package:movie_app/common/MediaProvider.dart';
import 'package:movie_app/common/Util.dart';

class Cast{
  int id;
  String name;
  String profilePath;
  int mediaId;


  String getCastUrl() => getMediumPictureUrl(profilePath); 

    //Es un constructor basado en el patron de diseño Factory
  factory Cast(Map jsonMap, MediaType mediaType, int mediaId){
    try{
      return new Cast.deserialize(jsonMap, mediaType, mediaId);
    }catch(ex){
      throw ex;
    }
  }
  
  Cast.deserialize(Map json, MediaType mediaType, int mediaId) :
    id = json["id"].toInt(),
    name = json["name"],
    profilePath = json["profile_path"] ?? "assets/placeholder.png",
    mediaId = mediaId;

  Cast.fromDb(Map<String, dynamic> parsedJson) :
    id = parsedJson["id"].toInt(),
    name = parsedJson["name"],
    profilePath = parsedJson["profile_path"] ?? "assets/placeholder.png",
    mediaId = parsedJson["media_Id"].toInt();

  Map<String, dynamic> toMap(){
    return <String, dynamic>{
      "id": id,
      "name": name,
      "profile_Path":profilePath,
      "media_Id":mediaId
    };
  }
} 
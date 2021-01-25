import 'package:movie_app/model/Cast.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:io';

class DbProvider{
  Database db;

  DbProvider(){
    init();
  }

  static final _dbProvider = new DbProvider();

  static DbProvider get(){
    return _dbProvider;
  }

  void init() async{
    //Es el directorio donde podemos almacenar la base de datos
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentDirectory.path, "Casts4.db");

    //Abrimos la base de datos. La primera vez que lo hacemos, la creamos
    //en el path, dentro de db.
    db = await openDatabase(
      path,
      version: 1,
      //Solo la primera vez que accedemos y creamos la base
      onCreate: (Database newDb, int version){
        newDb.execute("""
            CREATE TABLE Casts
            (
              id INTEGER PRIMARY KEY,
              name TEXT,
              profile_path TEXT,
              media_Id INTEGER
            )        
          """);
      }
    );
  }
  //Para acceder a la base es siemrpe de manera asincrona
  Future<List<Cast>> fetchCasts(int mediaId) async{
    print('${mediaId.toString()} Lectura de Base de datos Local');
    var maps = await db.query(
      "Casts",
      //Null porque queremos todas las columnas
      columns: null,
      //Estamos enviando como argunmendo el valor dentro de la propiedad
      //whereArgs
      where: "media_Id = ?",
      whereArgs: [mediaId]
    );
    if(maps.length > 0){
      return maps.map<Cast>((item) => new Cast.fromDb(item)).toList();
    }
    return null;
  }

  //Para ingresar los Casts a la BD, los hacemos con toMap() de Cast
  void addCast(Cast cast){
    print('${cast.mediaId.toString()} Insertar Cast en DB local');
    db.insert("Casts",
     cast.toMap(),
     conflictAlgorithm: ConflictAlgorithm.ignore
     );
  }
}
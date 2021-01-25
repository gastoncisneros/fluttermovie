import 'package:flutter/material.dart';
import 'package:movie_app/common/MediaProvider.dart';
import 'package:movie_app/media_detail.dart';
import 'package:movie_app/media_list_item.dart';
import 'package:movie_app/model/Media.dart';

class MediaList extends StatefulWidget {

  final MediaProvider provider;

  final String category;

  MediaList(this.provider, this.category);
  
  @override
  _MediaListState createState() => _MediaListState();
}

class _MediaListState extends State<MediaList> {
  List<Media> _media = new List();

  @override
  void initState() {
    super.initState();
    loadMovies();
  }


  void loadMovies() async{
    //con la variable widget ingreso a la variable del constructor
    var media = await widget.provider.fetchMedia(widget.category);
    setState(() {
     _media.addAll(media);
    });
  }
  
  //Este metodo lo que hace es reiniciar el widget cada vez que cambiamos la opcion a mostrar en el 
  //menu, el de arriba solo se llama una sola vez, este siempre que se cambia el widget
  //Cada vez que se haga un cambio, se recarga la informacion
  @override
  void didUpdateWidget(MediaList oldWidget){
    //Solo queremos que este widet cambie cuando el provider que nos llega es distinto al 
    //que tenemos
    if(oldWidget.provider.runtimeType != widget.provider.runtimeType){
      _media = new List();
      loadMovies();
    }
    super.didUpdateWidget(oldWidget);
  }



  @override
  Widget build(BuildContext context) {
    return Container(
      child: new ListView.builder(
        itemCount: _media.length,
        itemBuilder: (BuildContext context, int index){
          //Al hacer click en cada item, retornamos Media Detail
          return new FlatButton(
            child: new MediaListItem(_media[index]),
            padding: const EdgeInsets.all(1),
            onPressed: (){
              Navigator.push(context, new MaterialPageRoute(builder: (context){
                return new MediaDetail(widget.provider, _media[index]);
              }));
            },           
          );
        },
      ),
    );
  }
}

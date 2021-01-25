import 'package:flutter/material.dart';
import 'package:movie_app/model/Media.dart';
//Es un stateless porque no va a tener funcionaliad por el momento
class MediaListItem extends StatelessWidget {
  final Media media;

  //Constructor
  MediaListItem(this.media);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: new Column(
        children: <Widget>[
          new Container(
            child: new Stack(
              children: <Widget>[
                //Es una imagen que si no se descarga desde la api,
                //muestra una por defecto
                new FadeInImage.assetNetwork(
                  placeholder: "assets/placeholder.png",
                  image: media.getBackDropUrl(),
                  //Que cubra su espacio
                  fit: BoxFit.cover,
                  //Que la animacion de placeholder dure:
                  fadeInDuration: new Duration(milliseconds: 40),
                  height: 200.0,
                  width: double.infinity,
                ),
                //nos sirve para posicionar un elemento dentro de la pantalla.
                //Es el reactangulo oscuro que contendra la descricpion de los items
                new Positioned(
                  left: 0.0,
                  bottom: 0.0,
                  right: 0.0,
                  child: new Container(
                    //opacidad
                    decoration: new BoxDecoration(
                      color: Colors.grey[900].withOpacity(0.5)
                    ),
                    //este widget solo puede tener un espacio del 55%
                    constraints: new BoxConstraints.expand(
                      height: 55.0
                    ),
                  ),
                ),
                new Positioned(
                  left: 10.0,
                  bottom: 10.0,
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Container(
                        width: 250.0,
                        child: new Text(
                          media.title,
                          style: new TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      new Container(
                        width: 250.0,
                        padding: const EdgeInsets.only(top:4.0),
                        child: new Text(
                          media.getGenres(),
                          style: new TextStyle(color: Colors.white),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          
                        ),
                      ),
                    ],
                  ),
                ),
                new Positioned(
                  right: 5.0,
                  bottom: 10.0,
                  child: new Column(
                    children: <Widget>[
                      new Row(
                        children: <Widget>[                          
                          new Text(media.voteAverage.toString()),
                          new Container(width: 4.0,),
                          new Icon(Icons.star, color: Colors.white, size: 16.0,)
                        ],
                      ),
                      new Container(height: 4.0,),                      
                      new Row(
                        children: <Widget>[                          
                          new Text(media.getReleaseYear().toString()),
                          new Container(width: 4.0,),
                          new Icon(Icons.date_range, color: Colors.white, size: 16.0,)
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
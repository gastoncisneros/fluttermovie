import 'package:flutter/material.dart';
import 'package:movie_app/cast_scroller.dart';
import 'package:movie_app/common/MediaProvider.dart';
import 'package:movie_app/model/Media.dart';
import 'dart:ui' as ui;

class MediaDetail extends StatelessWidget {

  final MediaProvider provider;

  final Media media;

  MediaDetail(this.provider, this.media);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Stack nos permite que los widgets se superpongan
      body: new Stack(
        //Como se situa en nuesta pantalla
        fit: StackFit.expand,
        //Widgets que se van a ir adjuntando:
        children: <Widget>[
          new Image.network(
            //Fondo
            media.getBackDropUrl(),
            fit: BoxFit.cover
          ),
          //Desenfoque de Fondo
          new BackdropFilter(
            filter: new ui.ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: new Container(
              color: Colors.black.withOpacity(0.5),
            ),
          ),

          //Nos permite realizar un scroll en el widget. Definimos la imagen a mostrar en Detail
          new SingleChildScrollView(
            child: new Container(
              margin: const EdgeInsets.all(20.0),
              child: new Column(
                children: <Widget>[
                  new Container(
                    alignment: Alignment.center,
                    child: new Container(
                      width: 390.0,
                      height: 300.0,
                    ),
                    decoration: new BoxDecoration(
                      borderRadius: new BorderRadius.circular(10.0),
                      image: new DecorationImage(
                        image: new NetworkImage(
                          media.getPosterUrl()
                        )
                      ),
                      boxShadow: [
                        new BoxShadow(
                          color: Colors.black,
                          blurRadius: 20.0,
                          offset: new Offset(0.0, 10.0)
                        )
                      ]
                    ),
                  ),
                  //Nos permite definir un tamaño especifico para el proximo widget
                  SizedBox(height: 20.0),
                  new Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 5.0  
                    ),
                    child: new Row(
                      children: <Widget>[
                        new Expanded(
                          child: new Text(
                          media.title,
                          overflow: TextOverflow.fade,
                          maxLines: 1,
                          style: new TextStyle(
                            color: Colors.white,
                            fontSize: 15.0,
                            fontFamily: 'Arvo'
                          ),
                          ),
                        ),
                         new Text(
                           '${media.voteAverage.toString()}/10',
                           style: new TextStyle(
                             color: Colors.white,
                             fontSize: 15.0,
                             fontFamily: 'Arvo'
                           ),
                         ),
                      ],
                    )
                  ),
                  new Column(
                    children: <Widget>[
                      new Text(
                        media.overview,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        style: new TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                          fontFamily: 'Arvo'
                        ),
                      )
                    ],
                  ),
                  //Actores                  
                  new CastScroller(provider, media.id)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
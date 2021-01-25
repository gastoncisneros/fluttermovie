import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:movie_app/common/MediaProvider.dart';
import 'package:movie_app/model/Cast.dart';

class CastScroller extends StatefulWidget {
  
  final MediaProvider provider;
  final int mediaId;

  CastScroller(this.provider, this.mediaId);

  @override
  _CastScrollerState createState() => _CastScrollerState();
}

class _CastScrollerState extends State<CastScroller> {
  
  final List<Cast> _casts = new List<Cast>();

  @override
  void initState() {
    super.initState();
    loadCasts();
  }

  void loadCasts() async{
    var results = await widget.provider.fetchCast(widget.mediaId);  
    
    setState(() {
     _casts.addAll(results); 
    });
  }

  Widget _builderCast(BuildContext context, int index){

    var cast = _casts[index];

    return new Padding(
      padding: const EdgeInsets.only(right: 15.0),
      child: new Column(
        children: <Widget>[
          CircleAvatar(
            backgroundImage: new NetworkImage(
              cast.getCastUrl()
            ),
            radius: 40.0,
          ),
          Padding(
            padding: const EdgeInsets.only(top:8.0),
            child: new Text(cast.name),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        //Widget que nos da un tamaño dependiendo de la cantidad de datos
        SizedBox.fromSize(
          size: const Size.fromHeight(180.0),
          child: ListView.builder(
            itemCount: _casts.length,
             scrollDirection: Axis.horizontal,
             padding: const EdgeInsets.only(top:12.0, left:20.0),
             itemBuilder: _builderCast,
          ),
        )
      ],
    );
  }
}
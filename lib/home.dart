import 'package:flutter/material.dart';
import 'package:movie_app/common/MediaProvider.dart';
import 'package:movie_app/media_list.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => new _HomeState();
 }
 
class _HomeState extends State<Home> {

  final MediaProvider movieProvider = new MovieProvider();

  final MediaProvider showProvider = new ShowProvider();

  PageController _pageController;

  int _page = 0;

  MediaType mediaType = MediaType.movie;

  @override
  void initState() {
    super.initState();
    _pageController = new PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
   return new Scaffold(
     appBar: new AppBar(
       title: new Text("Flutter Movies"),
       actions: <Widget>[
         //boton de busqueda
         new IconButton(
           icon: new Icon(Icons.search, color: Colors.white,),
           onPressed: (){},
         )
       ],
     ),
     //Menu hamburguesa
     drawer: _getDrawer(context),
     body: new PageView(
       children: _getMediaList(),
       //Definimos el controller para saber que pagina se esta mostrando (0, 1 o 2)
       controller: _pageController,
       onPageChanged: (int index){ //Este pageController y el index van a ser modificados por los botones del footer, que lo que hacen es cambiar de pagina.
         setState(() {
          _page = index; 
         });
       },
     ),     
     //Footer Botones
     bottomNavigationBar: new BottomNavigationBar(
       items: _getFooterItems(),
       onTap: _navigationTapped,
       currentIndex: _page,
     ),
   );
  }

  //Por defecto se muestra la primer pagina(popular). El controller que cambia de page con
  //los botones del footer, elige que pagina se va a mostrar y se recarga la info por el metodo
  //didUpdateWidget de media_list.dart
  List<Widget> _getMediaList(){
    return (mediaType == MediaType.movie) ?
    <Widget>[
      new MediaList(movieProvider, "popular"), //PAGE 0
      new MediaList(movieProvider, "upcoming"), //PAGE 1
      new MediaList(movieProvider, "top_rated"), //PAGE 2
      ] :
    <Widget>[
      new MediaList(showProvider, "popular"), //PAGE 0
      new MediaList(showProvider, "on_the_air"), //PAGE 1
      new MediaList(showProvider, "top_rated"), //PAGE 2
      ];
  }

//------------------NAVEGACION-ELECCION DE CONTENIDO----------------------//

  //Construccion de menu hamburguesa
  Drawer _getDrawer(BuildContext context){
    var header = new DrawerHeader(
      child: new Material(),
    );

    ListView listView = new ListView(
      children: <Widget>[
        // header,

        new ListTile(
          trailing: new Icon(Icons.local_movies),
          title: new Text("Peliculas"),
          selected: mediaType == MediaType.movie,
          onTap: () {
            _changeMediaType(MediaType.movie);
            Navigator.of(context).pop();
          },
        ),
        new Divider(height: 5.0,),

        new ListTile(
          trailing: new Icon(Icons.live_tv),
          title: new Text("Television"),
          selected: mediaType == MediaType.show,
          onTap: () {
            _changeMediaType(MediaType.show);
            Navigator.of(context).pop();
          },
        ),
        new Divider(height: 5.0,),

        //Nos permite cerrar las rutas (cerrar el menu) que estoy usando
        new ListTile(
          trailing: new Icon(Icons.close),
          title: new Text("Cerrar"),
          onTap: () => Navigator.of(context).pop(),
        ),
        new Divider(height: 5.0,),
      ],
    );

    //Retorno el Drawer creado
    return new Drawer(
      child: listView,
    );

  }

  void _changeMediaType(MediaType type){
    if(mediaType != type)
      setState(() {
        mediaType = type;
      });
  }

//-------------------FIN DE NAVEGACION-ELECCION DE CONTENIDO ------------------------//



//----------------BOTONES FOOTER - FILTRO DE CONTENIDO---------------------------------//
  //Botones del footer
  List<BottomNavigationBarItem> _getFooterItems(){
    return  mediaType == MediaType.movie ? [
      new BottomNavigationBarItem(
        icon: new Icon(Icons.thumb_up),
        title: new Text("Populares")
      ),
      new BottomNavigationBarItem(
        icon: new Icon(Icons.update),
        title: new Text("Proximamente")
      ),
      new BottomNavigationBarItem(
        icon: new Icon(Icons.star),
        title: new Text("Mejor Valoradas")
      ),
    ] : 
    [
      new BottomNavigationBarItem(
        icon: new Icon(Icons.thumb_up),
        title: new Text("Populares")
      ),
      new BottomNavigationBarItem(
        icon: new Icon(Icons.update),
        title: new Text("En el aire")
      ),
      new BottomNavigationBarItem(
        icon: new Icon(Icons.star),
        title: new Text("Mejor Valoradas")
      ),
    ];
  }

  //Toma el parametro automaticamente de la propiedad currentIndex
  //Lo que hace es actualizar el page correspondiente a cada PageView, si es 0 son populares
  //Si es 1 son Proximamente o En el aire, si es 2 son Mejor valoradas
  void _navigationTapped(int page){
    _pageController.animateToPage(page, duration: const Duration(microseconds: 300), curve: Curves.ease);
  }
//----------------FIN DE BOTONES FOOTER - FILTRO DE CONTENIDO---------------------------------//
}
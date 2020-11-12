import 'package:flutter/material.dart';
import 'package:peliculas/pages/models/pelicula_modelo.dart';

class MovieHorizontal extends StatelessWidget {
  final List<Pelicula> peliculas;

  final Function siguientePagina;

  MovieHorizontal({@required this.peliculas, @required this.siguientePagina});

  final _pageControler = PageController(initialPage: 1, viewportFraction: 0.3);

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

_pageControler.addListener(() {
  if(_pageControler.position.pixels >= _pageControler.position.maxScrollExtent - 200) {
    //print('Cargar');
    siguientePagina();
  }
});

    return Container(
      height: _screenSize.height * 0.2,
      child: PageView.builder(   //Poniendole el .builder al PageView hacemos que cargue  conforme son necesarios y no todos de golpe
        pageSnapping: false,   //Esto le quita el magneto, a la hora de hacer scroll es peor, por eso lo quito
        controller: _pageControler,
       itemCount: peliculas.length,
       itemBuilder: (context, i) {
          return _tarjeta(context, peliculas[i]);
       },
       // children: _tarjetas(context),
      ),
    );
  }

  Widget _tarjeta(BuildContext context, Pelicula pelicula) {
    pelicula.uniqueId = '${pelicula.id}-popopulares';
    final peliculaTarjeta = Container(
      margin: EdgeInsets.only(right: 15.0),
      child: Column(
        children: [
          Hero(
            tag: pelicula.id,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                placeholder: AssetImage('assets/img/no-image.jpg'),
                image: NetworkImage(pelicula.getPosterImg()),
                fit: BoxFit.cover,
                height: 120.0,
              ),
            ),
          ),
          SizedBox(height: 5),
          Text(pelicula.title, overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.caption,)
        ],
      ),
    );
    return GestureDetector(
      child: peliculaTarjeta,
      onTap: () {
       // print(pelicula.title);

        Navigator.pushNamed(context, "detalle", arguments: pelicula);
    }
    );
  }

  List<Widget> _tarjetas(BuildContext context) {
    return peliculas.map((pelicula) {
      return Container(
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                 image: NetworkImage(pelicula.getPosterImg()),
                  fit: BoxFit.cover,
                  height: 120.0,
              ),
            ),
            Text(pelicula.title, overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.caption,)
          ],
        ),
      );
    }).toList();
  }
}

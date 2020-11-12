import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peliculas/pages/models/pelicula_modelo.dart';
import 'package:peliculas/providers/peliculas_providers.dart';

import 'models/actores_model.dart';

class PeliculaDetalle extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final Pelicula pelicula = ModalRoute.of(context).settings.arguments;

    return Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            _crearAppbar( pelicula ),
            SliverList(
              delegate: SliverChildListDelegate(
                  [
                    SizedBox( height: 10.0 ),
                    _posterTitulo( context, pelicula ),
                    _descripcion(pelicula),
                    _descripcion(pelicula),
                    _descripcion(pelicula),
                    _descripcion(pelicula),
                    _descripcion(pelicula),
                    _descripcion(pelicula),
                    _descripcion(pelicula),
                    crearCasting(pelicula)

                  ]
              ),
            )
          ],
        )
    );

  }

  Widget _crearAppbar(Pelicula pelicula) {
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.indigoAccent,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          pelicula.title,
          style: TextStyle(color: Colors.white, fontSize: 16.0),
        ),
        background: FadeInImage(
          image: NetworkImage(pelicula.getBackgroundImg()),
          placeholder: AssetImage("assets/img/loading.gif"),
          fit: BoxFit.cover,

        ),
      ),
    );
  }

  Widget _posterTitulo(BuildContext context, Pelicula pelicula) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          Hero(
            tag: pelicula.uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image(
                image: NetworkImage(pelicula.getPosterImg()),
                height: 150.0,
              ),
            ),
          ),
          SizedBox(width: 20.0,),
          Flexible(
              child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(pelicula.title, style: Theme.of(context).textTheme.subtitle1, overflow: TextOverflow.ellipsis),
            Text(pelicula.originalTitle, style: Theme.of(context).textTheme.subtitle2, overflow: TextOverflow.ellipsis),
            Row(
                children: <Widget> [
                  Icon(Icons.star_border),
                  Text(pelicula.voteAverage.toString(), style: Theme.of(context).textTheme.subtitle2)
                ]


          )
          ],
          ),
          )
        ],
      ),
    );
  }

  Widget _descripcion(Pelicula pelicula) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      child: Text(
        pelicula.overview,
        textAlign: TextAlign.justify,
      )
    );
  }

  Widget crearCasting(Pelicula pelicula) {
    final peliProvider = PeliculasProvider();

    return FutureBuilder(
        future: peliProvider.getCast(pelicula.id.toString()),
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          if(snapshot.hasData) {
            return _crearActoresPageView(snapshot.data);
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
    );
  }

  Widget _crearActoresPageView(List<Actor> actores) {
    return SizedBox(
      height: 200.0,
      child: PageView.builder(
        pageSnapping: false,
          itemBuilder: (context, i) {
            return _actorTarjeta(actores[i]);
          },
          itemCount: actores.length,
          controller: PageController(
            viewportFraction: 0.3,
            initialPage: 1
          ),
      ),
    );
  }

  Widget _actorTarjeta(Actor actor) {
      return Container(
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                  placeholder: AssetImage("assets/img/no-image.jpg"),
                  image: NetworkImage(actor.getFoto()),
                  height: 150.0,
                fit: BoxFit.cover,
              ),

            ),
            Text(
                actor.name,
                overflow: TextOverflow.ellipsis
            )
          ],
        ),
      );
  }
}

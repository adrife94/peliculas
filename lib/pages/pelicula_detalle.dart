import 'package:flutter/material.dart';
import 'package:peliculas/pages/models/pelicula_modelo.dart';

class PeliculaDetalle extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final Pelicula pelicula = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: Center(
        child: Text(pelicula.title),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:peliculas/pages/home_page.dart';
import 'package:peliculas/pages/pelicula_detalle.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder> {
        "/" : (context) => HomePage(),
        "detalle" : (context) => PeliculaDetalle()
      },
    );
  }
}

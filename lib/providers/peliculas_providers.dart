import 'dart:async';

import 'package:peliculas/pages/models/pelicula_modelo.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

class PeliculasProvider{
  String _apikey = '46514b47bc995b14fd13c566f27ac058';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';

  int _popularesPages = 1;
  bool _cargando = false;

  List<Pelicula> _populares = new List();

  final _popularesStreamController = StreamController<List<Pelicula>>.broadcast();  // El broadcast hace que este abierto para todos los widget

  Function(List<Pelicula>)get popularesSink =>_popularesStreamController.sink.add;

  Stream<List<Pelicula>> get popularesStream => _popularesStreamController.stream;

void disposeStreams() {
  _popularesStreamController?.close();
}



  Future<List<Pelicula>> procesarDatos(Uri url) async {

    final resp = await http.get(url);

    final decodedData = json.decode(resp.body);

    final peliculas = Peliculas.fromJsonList(decodedData['results']);
    print(peliculas.items[9].title);

    return peliculas.items;
  }


  Future<List<Pelicula>> getEnCines() async {
    final url = Uri.https(_url, '3/movie/now_playing', {'api_key' : _apikey, 'language' : _language});

    return await procesarDatos(url);
  }

  Future<List<Pelicula>> getPopulares() async {

  if (_cargando) return [];

  _cargando = true;

    _popularesPages++;

    print("'Cargando siguientes...");

    final url = Uri.https(_url, '3/movie/popular', {'api_key' : _apikey, 'language' : _language, 'page' : _popularesPages.toString()});

    final respuesta = await procesarDatos(url);
    
    _populares.addAll(respuesta);
    popularesSink(_populares);

    _cargando = false;

    return respuesta;
    
  }
}
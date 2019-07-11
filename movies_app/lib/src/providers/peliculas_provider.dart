import 'dart:convert';

import 'package:movies_app/src/models/pelicula_model.dart';
import 'package:http/http.dart' as http;


class PeliculasProvider {
  String _apikey    = '02478853ca55fd010703e91e88c04745';
  String _url       = 'api.themoviedb.org';
  String _language  = 'es-Es';
  String _region    = 'ES';

Future<List<Pelicula>> _callMethod( Uri url) async {
      final resp = await http.get(url);

    final decodedData = json.decode(resp.body);
    final peliculas = new Peliculas.fromJsonList(decodedData['results']);

    return peliculas.items;
}

  Future<List<Pelicula>>getEnCines() async {

    final url = Uri.https(_url, '3/movie/now_playing',{
      'api_key' : _apikey,
      'language': _language,
      'page'    : '1',
      'region'  :_region
    });

    return await _callMethod( url );

  }

  Future<List<Pelicula>>getPopulares() async {

    final url = Uri.https(_url, '3/movie/popular',{
      'api_key' : _apikey,
      'language': _language,
      'page'    : '1',
      'region'  :_region
    });

    return await _callMethod( url );

  }


}
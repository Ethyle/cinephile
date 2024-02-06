import 'package:http/http.dart' as http;
import '../models/comics_model.dart';
import '../models/character_model.dart';
import '../models/movies_model.dart';
import '../models/news_model.dart';
import '../models/series_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';

class ApiService {

  var apiKey = dotenv.env['API_KEY'];
  var apiKey1 = dotenv.env['API_KEY1'];


  // Endpoint pour les comics
  Future<List<Comic>> getComics() async {
    var url = Uri.parse('https://comicvine.gamespot.com/api/issues?api_key=$apiKey&format=json');
    return _getApiData<Comic>(url, (json) => Comic.fromJson(json));
  }

  // Endpoint pour les films
  Future<List<Movie>> getMovies() async {
    var url = Uri.parse('https://comicvine.gamespot.com/api/movies?api_key=$apiKey&format=json');
    return _getApiData<Movie>(url, (json) => Movie.fromJson(json));
  }

  // Endpoint pour les séries
  Future<List<Series>> getSeries() async {
    var url = Uri.parse('https://comicvine.gamespot.com/api/series_list?api_key=$apiKey&format=json');
    return _getApiData<Series>(url, (json) => Series.fromJson(json));
  }

  // Endpoint pour les personnages
Future<List<Character>> getCharacters() async {
  var url = Uri.parse('https://comicvine.gamespot.com/api/characters?api_key=$apiKey&format=json');
  try {
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      List results = data['results'] as List;
      return results.map((json) => Character.fromJson(json)).cast<Character>().toList();
    } else {
      print("Erreur lors de l'appel API: Statut HTTP ${response.statusCode}");
      return [];
    }
  } catch (e) {
    print("Exception lors de l'appel API: $e");
    return [];
  }
}

  // Endpoint pour les news

Future<List<News>> getNews() async {
  var url = Uri.parse('http://www.gamespot.com/api/articles/?api_key=$apiKey1&format=json&filter=categories:48'); 

try {

      var response = await http.get(url);

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}'); // Cette ligne affichera le JSON brut

     if (response.statusCode == 200) {
      var data = json.decode(response.body);

      List results = data['results'] as List;
      return results.map((json) => News.fromJson(json)).cast<News>().toList();
    } else {
      print("Erreur lors de l'appel API: Statut HTTP ${response.statusCode}");
      return [];
    }
  } catch (e) {
    print("Exception lors de l'appel API: $e");
    return [];
  }
}


  // Fonction générique pour obtenir des données de l'API
  Future<List<T>> _getApiData<T>(Uri url, Function fromJson) async {
    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var data = json.decode(response.body);

        List results = data['results'] as List;
        return results.map((json) => fromJson(json)).cast<T>().toList();
      } else {
        print("Erreur lors de l'appel API: Statut HTTP ${response.statusCode}");
        return [];
      }
    } catch (e) {
      print("Exception lors de l'appel API: $e");
      return [];
    }
  }




}
import 'package:http/http.dart' as http;
import '../models/comics_model.dart';
import '../models/character_model.dart';
import '../models/movies_model.dart';
import '../models/news_model.dart';
import '../models/series_model.dart';
import '../models/episode_model.dart';
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

  
  // Endpoint pour les episodes
  Future<List<Episode>> getEpisodesBySeriesId(int seriesId) async {
    // Constructing the URL to query the API with the series ID as a filter
    var url = Uri.parse('https://comicvine.gamespot.com/api/episodes?api_key=$apiKey&format=json&filter=series:$seriesId');

    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var data = json.decode(response.body);

        if (data['results'] is List) {
          List<dynamic> episodesJson = data['results'];
          List<Episode> episodes = episodesJson.map((episodeJson) => Episode.fromJson(episodeJson)).toList();
          return episodes;
        } else {
          throw Exception('Expected a list of results but did not find one.');
        }
      } else {
        throw Exception('Error fetching episodes: HTTP ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Exception during API call: $e');
    }
  }

 Future<List<Character>> getCharactersByMoviesId(int moviesId) async {
  // Construction de l'URL pour interroger l'API avec l'ID du film en tant que filtre
  var url = Uri.parse('https://comicvine.gamespot.com/api/movie/4025-$moviesId/?api_key=$apiKey&format=json');

  try {
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      
      // Assurez-vous d'accéder correctement à la liste des personnages dans la structure JSON
      var charactersData = data['results']['characters'] as List<dynamic>;

      List<Character> characters = charactersData.map((characterJson) => Character.fromJson(characterJson)).toList();
      return characters;
    } else {
      // Gère les réponses autres que le statut 200 OK
      throw Exception('Error fetching characters: HTTP ${response.statusCode}');
    }
  } catch (e) {
    // Gère les exceptions lors de l'appel API
    throw Exception('Exception during API call: $e');
  }
}

 Future<List<Character>> getCharactersByComicId(int comicId) async {
  // Construction de l'URL pour interroger l'API avec l'ID du film en tant que filtre
  var url = Uri.parse('https://comicvine.gamespot.com/api/issue/4000-$comicId/?api_key=$apiKey&format=json');

  try {
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      
      var charactersData = data['results']['characters'] as List<dynamic>;

      List<Character> characters = charactersData.map((characterJson) => Character.fromJson(characterJson)).toList();

      return characters;
    } else {
      // Gère les réponses autres que le statut 200 OK
      throw Exception('Error fetching characters: HTTP ${response.statusCode}');
    }
  } catch (e) {
    // Gère les exceptions lors de l'appel API
    throw Exception('Exception during API call: $e');
  }
}

 Future<List<Character>> getCharactersBySerieId(int serieId) async {
  // Construction de l'URL pour interroger l'API avec l'ID du film en tant que filtre
  var url = Uri.parse('https://comicvine.gamespot.com/api/series/$serieId/?api_key=$apiKey&format=json');

  try {
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      
      var charactersData = data['results']['characters'] as List<dynamic>;

      List<Character> characters = charactersData.map((characterJson) => Character.fromJson(characterJson)).toList();
      return characters;
    } else {
      // Gère les réponses autres que le statut 200 OK
      throw Exception('Error fetching characters: HTTP ${response.statusCode}');
    }
  } catch (e) {
    // Gère les exceptions lors de l'appel API
    throw Exception('Exception during API call: $e');
  }
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

 // Fonction pour récupérer les auteurs d'un comic par son ID
   Future<List<String>> getAuthorsByComicId(int comicId) async {
    var url = Uri.parse('https://comicvine.gamespot.com/api/issue/4000-$comicId/?api_key=$apiKey&format=json&field_list=person_credits');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      if (data['results'] != null && data['results']['person_credits'] != null) {
        var personCredits = List.from(data['results']['person_credits']);
        return personCredits.map((person) => person['name'].toString()).toList();
      } else {
        throw Exception('No person_credits found for comic with id $comicId');
      }
    } else {
      throw Exception('Failed to load authors for comic with id $comicId: ${response.statusCode}');
    }
  }
  
  // Fonction générique pour obtenir des données de l'API
  Future<List<T>> _getApiData<T>(Uri url, Function fromJson) async {
    try {
      var response = await http.get(url);
    
      if (response.statusCode == 200 ) {
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


// Recherche des Comic
Future<List<Comic>> searchComics(String query) async {
  var encodedQuery = Uri.encodeComponent(query);
  var url = Uri.parse('https://comicvine.gamespot.com/api/search/?api_key=$apiKey&format=json&field_list=name,image&limit=10&resources=issue&query=$encodedQuery');
  return _getApiData<Comic>(url, (json) => Comic.fromJson(json));
}

  // Recherche des films
  Future<List<Movie>> searchMovies(String query) async {
    var encodedQuery = Uri.encodeComponent(query);
    var url = Uri.parse('https://comicvine.gamespot.com/api/search/?api_key=$apiKey&format=json&field_list=name,image&limit=10&resources=movie&query=$encodedQuery');
    return _getApiData<Movie>(url, (json) => Movie.fromJson(json));
  }

  // Recherche des séries
  Future<List<Series>> searchSeries(String query) async {
    var encodedQuery = Uri.encodeComponent(query);
    var url = Uri.parse('https://comicvine.gamespot.com/api/search/?api_key=$apiKey&format=json&field_list=name,image&limit=10&resources=series&query=$encodedQuery');
    return _getApiData<Series>(url, (json) => Series.fromJson(json));
  }

  // Recherche des personnages
  Future<List<Character>> searchCharacters(String query) async {
    var encodedQuery = Uri.encodeComponent(query);
    var url = Uri.parse('https://comicvine.gamespot.com/api/search/?api_key=$apiKey&format=json&field_list=name,image&limit=10&resources=character&query=$encodedQuery');
    return _getApiData<Character>(url, (json) => Character.fromJson(json));
  }


}

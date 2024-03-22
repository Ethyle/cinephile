import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../models/character_model.dart';
import '../models/comics_model.dart';
import '../models/movies_model.dart';
import '../models/series_model.dart';
import '../services/api_service.dart';

// Événements
abstract class SearchEvent extends Equatable {
  const SearchEvent();
}

class PerformSearchEvent extends SearchEvent {
  final String query;

  const PerformSearchEvent(this.query);

  @override
  List<Object> get props => [query];
}

// États
abstract class SearchState extends Equatable {
  const SearchState();
}

class SearchInitialState extends SearchState {
  @override
  List<Object> get props => [];
}

class SearchLoadingState extends SearchState {
  @override
  List<Object> get props => [];
}

class SearchResultsState extends SearchState {
  final Map<String, List<Map<String, String>>> results; // Chaque élément contient un 'name' et une 'imageUrl'

  const SearchResultsState(this.results);

  @override
  List<Object> get props => [results];
}


class SearchErrorState extends SearchState {
  final String error;

  const SearchErrorState(this.error);

  @override
  List<Object> get props => [error];
}

// Bloc
class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final ApiService apiService;

  SearchBloc(this.apiService) : super(SearchInitialState()) {
    on<PerformSearchEvent>(_onPerformSearchEvent);
  }

  Future<void> _onPerformSearchEvent(PerformSearchEvent event, Emitter<SearchState> emit) async {
  emit(SearchLoadingState());
  try {
    // Log avant les appels API
    print('Début de la recherche pour : ${event.query}');

    final comicsFuture = apiService.searchComics(event.query);
     final moviesFuture = apiService.searchMovies(event.query);
     final seriesFuture = apiService.searchSeries(event.query);
     final charactersFuture = apiService.searchCharacters(event.query);

    // Attendre les résultats de tous les appels API
    final List<Comic> comics = await comicsFuture;
    final List<Movie> movies = await moviesFuture;
    final List<Series> series = await seriesFuture;
    final List<Character> characters = await charactersFuture;

    // Log après avoir obtenu les résultats
    print('Comics trouvés: ${comics.length}');
    print('Films trouvés: ${movies.length}');
    print('Séries trouvées: ${series.length}');
    print('Personnages trouvés: ${characters.length}');

    // Construire les résultats de recherche
    Map<String, List<Map<String, String>>> searchResults = {
  'Comics': comics.map((comic) => {'name': comic.name, 'imageUrl': comic.imageUrl}).toList(),
   'Movies': movies.map((movie) => {'name': movie.name, 'imageUrl': movie.imageUrl}).toList(),
   'Series': series.map((serie) => {'name': serie.title, 'imageUrl': serie.imageUrl}).toList(),
   'Characters': characters.map((character) => {'name': character.name}).toList(),
};


    emit(SearchResultsState(searchResults));
  } catch (e) {
    emit(SearchErrorState('Erreur lors de la recherche : $e'));
    // Log de l'erreur
    print('Erreur lors de la recherche : $e');
  }
}

}

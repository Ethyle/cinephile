import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

// Événements
abstract class SearchEvent extends Equatable {
  const SearchEvent();
}

class PerformSearchEvent extends SearchEvent {
  final String query;

  PerformSearchEvent(this.query);

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
  final List<String> results;

  SearchResultsState(this.results);

  @override
  List<Object> get props => [results];
}

class SearchErrorState extends SearchState {
  final String error;

  SearchErrorState(this.error);

  @override
  List<Object> get props => [error];
}

// Bloc
class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitialState()) {
    on<PerformSearchEvent>(_onPerformSearchEvent);
  }

  Future<void> _onPerformSearchEvent(PerformSearchEvent event, Emitter<SearchState> emit) async {
    emit(SearchLoadingState());
    try {
      // Simulez une recherche réussie avec des résultats fictifs
      // Vous devrez remplacer ceci par votre logique de recherche réelle.
      List<String> results = ['Result 1', 'Result 2', 'Result 3'];
      emit(SearchResultsState(results));
    } catch (e) {
      // Gérez les erreurs de recherche
      emit(SearchErrorState('Erreur lors de la recherche : $e'));
    }
  }
}

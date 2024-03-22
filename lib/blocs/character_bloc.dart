import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../models/character_model.dart'; 
import '../../services/api_service.dart'; 

// Événements
abstract class CharacterEvent extends Equatable {
  const CharacterEvent();

  @override
  List<Object> get props => [];
}

class FetchCharactersEvent extends CharacterEvent {
  @override
  List<Object> get props => [];
}

class FetchCharactersByMovieIdEvent extends CharacterEvent {
  final int movieId;

  const FetchCharactersByMovieIdEvent(this.movieId);

  @override
  List<Object> get props => [movieId];
}

class FetchCharactersByComicIdEvent extends CharacterEvent {
  final int comicId;

  const FetchCharactersByComicIdEvent(this.comicId);

  @override
  List<Object> get props => [comicId];
}

class FetchCharactersBySerieIdEvent extends CharacterEvent {
  final int serieId;

  const FetchCharactersBySerieIdEvent(this.serieId);

  @override
  List<Object> get props => [serieId];
}

// États
abstract class CharacterState extends Equatable {
  const CharacterState();

  @override
  List<Object> get props => [];
}

class CharacterInitialState extends CharacterState {}

class CharacterLoadingState extends CharacterState {}

class CharacterLoadedState extends CharacterState {
  final List<Character> characters;

  const CharacterLoadedState(this.characters);

  @override
  List<Object> get props => [characters];
}

class CharacterErrorState extends CharacterState {
  final String error;

  const CharacterErrorState(this.error);

  @override
  List<Object> get props => [error];
}

// Bloc
class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {
  final ApiService apiService;

  CharacterBloc(this.apiService) : super(CharacterInitialState()) {
    on<FetchCharactersEvent>((event, emit) async {
      emit(CharacterLoadingState());
      try {
        final characters = await apiService.getCharacters();
        emit(CharacterLoadedState(characters));
      } catch (e) {
        emit(CharacterErrorState('Failed to fetch characters: $e'));
      }
    });

    on<FetchCharactersByMovieIdEvent>((event, emit) async {
      emit(CharacterLoadingState());
      try {
        final characters = await apiService.getCharactersByMoviesId(event.movieId);
        emit(CharacterLoadedState(characters));
      } catch (e) {
        emit(CharacterErrorState('Failed to fetch characters for movie ${event.movieId}: $e'));
      }
    });

        on<FetchCharactersByComicIdEvent>((event, emit) async {
      emit(CharacterLoadingState());
      try {
        final characters = await apiService.getCharactersByMoviesId(event.comicId);
        emit(CharacterLoadedState(characters));
      } catch (e) {
        emit(CharacterErrorState('Failed to fetch characters for movie ${event.comicId}: $e'));
      }
    });
        on<FetchCharactersBySerieIdEvent>((event, emit) async {
      emit(CharacterLoadingState());
      try {
        final characters = await apiService.getCharactersBySerieId(event.serieId);
        emit(CharacterLoadedState(characters));
      } catch (e) {
        emit(CharacterErrorState('Failed to fetch characters for movie ${event.serieId}: $e'));
      }
    });
  }
}



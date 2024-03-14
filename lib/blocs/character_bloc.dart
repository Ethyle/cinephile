import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../models/character_model.dart'; 
import '../../services/api_service.dart'; 

// Événements
abstract class CharacterEvent extends Equatable {
  const CharacterEvent();
}

class FetchCharactersEvent extends CharacterEvent {
  @override
  List<Object> get props => [];
}

// États
abstract class CharacterState extends Equatable {
  const CharacterState();
}

class CharacterInitialState extends CharacterState {
  @override
  List<Object> get props => [];
}

class CharacterLoadingState extends CharacterState {
  @override
  List<Object> get props => [];
}

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
  }
}

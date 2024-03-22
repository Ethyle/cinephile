import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../models/comics_model.dart'; 
import '../../services/api_service.dart'; 

// Événements
abstract class ComicsEvent extends Equatable {
  const ComicsEvent();
}

class FetchComicsEvent extends ComicsEvent {
  @override
  List<Object> get props => [];
}

class FetchComicAuthorsEvent extends ComicsEvent {
  final int comicId;

  FetchComicAuthorsEvent(this.comicId);

  @override
  List<Object> get props => [comicId];
}

// États
abstract class ComicsState extends Equatable {
  const ComicsState();
}

class ComicsInitialState extends ComicsState {
  @override
  List<Object> get props => [];
}

class ComicsLoadingState extends ComicsState {
  @override
  List<Object> get props => [];
}

class ComicsLoadedState extends ComicsState {
  final List<Comic> comics;
  
  const ComicsLoadedState(this.comics);

  @override
  List<Object> get props => [comics];
}

class ComicsErrorState extends ComicsState {
  final String error;

  const ComicsErrorState(this.error);

  @override
  List<Object> get props => [error];
}

class AuthorsLoadingState extends ComicsState {
  @override
  List<Object> get props => [];
}

class AuthorsLoadedState extends ComicsState {
  final List<String> authors;

  AuthorsLoadedState(this.authors);

  @override
  List<Object> get props => [authors];
}

class AuthorsErrorState extends ComicsState {
  final String error;

  AuthorsErrorState(this.error);

  @override
  List<Object> get props => [error];
}


// Bloc
class ComicsBloc extends Bloc<ComicsEvent, ComicsState> {
  final ApiService apiService;

  ComicsBloc(this.apiService) : super(ComicsInitialState()) {
    on<FetchComicsEvent>(handleFetchComicsEvent);
    on<FetchComicAuthorsEvent>(handleFetchComicAuthorsEvent);
  }

  Future<void> handleFetchComicsEvent(FetchComicsEvent event, Emitter<ComicsState> emit) async {
    emit(ComicsLoadingState());
    try {
      final comics = await apiService.getComics(); 
      emit(ComicsLoadedState(comics));
    } catch (e) {
      emit(ComicsErrorState('Failed to fetch comics: $e'));
    }
  }

  Future<void> handleFetchComicAuthorsEvent(FetchComicAuthorsEvent event, Emitter<ComicsState> emit) async {
    emit(AuthorsLoadingState());
    try {
      final authors = await apiService.getAuthorsByComicId(event.comicId);
      emit(AuthorsLoadedState(authors));
    } catch (e) {
      emit(AuthorsErrorState('Failed to fetch authors: $e'));
    }
  }
}


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

// Bloc
class ComicsBloc extends Bloc<ComicsEvent, ComicsState> {
  final ApiService apiService;

  ComicsBloc(this.apiService) : super(ComicsInitialState()) {
    on<FetchComicsEvent>((event, emit) async {
      emit(ComicsLoadingState());
      try {
        final comics = await apiService.getComics(); 
        emit(ComicsLoadedState(comics));
      } catch (e) {
        emit(ComicsErrorState('Failed to fetch comics: $e'));
      }
    });
  }
}

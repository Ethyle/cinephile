import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../models/movies_model.dart'; 
import '../../services/api_service.dart'; 

// Événements
abstract class MoviesEvent extends Equatable {
  const MoviesEvent();
}

class FetchMoviesEvent extends MoviesEvent {
  @override
  List<Object> get props => [];
}

// États
abstract class MoviesState extends Equatable {
  const MoviesState();
}

class MoviesInitialState extends MoviesState {
  @override
  List<Object> get props => [];
}

class MoviesLoadingState extends MoviesState {
  @override
  List<Object> get props => [];
}

class MoviesLoadedState extends MoviesState {
  final List<Movie> movies;
  
  const MoviesLoadedState(this.movies);

  @override
  List<Object> get props => [movies];
}

class MoviesErrorState extends MoviesState {
  final String error;

  const MoviesErrorState(this.error);

  @override
  List<Object> get props => [error];
}

// Bloc
class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  final ApiService apiService;

  MoviesBloc(this.apiService) : super(MoviesInitialState()) {
    on<FetchMoviesEvent>((event, emit) async {
      emit(MoviesLoadingState());
      try {
        final movies = await apiService.getMovies();
        emit(MoviesLoadedState(movies));
      } catch (e) {
        emit(MoviesErrorState('Failed to fetch movies: $e'));
      }
    });
  }
}


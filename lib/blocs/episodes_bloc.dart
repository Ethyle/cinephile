import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../models/episode_model.dart'; 
import '../../services/api_service.dart'; 

// Événements pour les épisodes
abstract class EpisodeEvent extends Equatable {
  const EpisodeEvent();

  @override
  List<Object?> get props => [];
}
 
// Événement pour récupérer les épisodes d'une série spécifique
class FetchEpisodesBySeriesIdEvent extends EpisodeEvent {
  final int seriesId;

  const FetchEpisodesBySeriesIdEvent(this.seriesId);

  @override
  List<Object?> get props => [seriesId];
}

// États pour les épisodes
abstract class EpisodeState extends Equatable {
  const EpisodeState();

  @override
  List<Object?> get props => [];
}

class EpisodeInitialState extends EpisodeState {}

class EpisodeLoadingState extends EpisodeState {}

class EpisodeLoadedState extends EpisodeState {
  final List<Episode> episodes;

  const EpisodeLoadedState(this.episodes);

  @override
  List<Object?> get props => [episodes];
}

class EpisodeErrorState extends EpisodeState {
  final String error;

  const EpisodeErrorState(this.error);

  @override
  List<Object?> get props => [error];
}

// Bloc pour les épisodes
class EpisodeBloc extends Bloc<EpisodeEvent, EpisodeState> {
  final ApiService apiService;

  EpisodeBloc({required this.apiService}) : super(EpisodeInitialState()) {
    on<FetchEpisodesBySeriesIdEvent>((event, emit) async {
      emit(EpisodeLoadingState());
      try {
        final episodes = await apiService.getEpisodesBySeriesId(event.seriesId);
        emit(EpisodeLoadedState(episodes));
      } catch (error) {
        emit(EpisodeErrorState('Failed to fetch episodes for series ${event.seriesId}: $error'));
      }
    });
  }
}

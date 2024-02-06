import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../models/series_model.dart'; 
import '../../services/api_service.dart'; 

// Événements
abstract class SeriesEvent extends Equatable {
  const SeriesEvent();
}

class FetchSeriesEvent extends SeriesEvent {
  @override
  List<Object> get props => [];
}

// États
abstract class SeriesState extends Equatable {
  const SeriesState();
}

class SeriesInitialState extends SeriesState {
  @override
  List<Object> get props => [];
}

class SeriesLoadingState extends SeriesState {
  @override
  List<Object> get props => [];
}

class SeriesLoadedState extends SeriesState {
  final List<Series> series;
  
  SeriesLoadedState(this.series);

  @override
  List<Object> get props => [series];
}

class SeriesErrorState extends SeriesState {
  final String error;

  SeriesErrorState(this.error);

  @override
  List<Object> get props => [error];
}

// Bloc
class SeriesBloc extends Bloc<SeriesEvent, SeriesState> {
  final ApiService apiService;

  SeriesBloc(this.apiService) : super(SeriesInitialState()) {
    on<FetchSeriesEvent>((event, emit) async {
      emit(SeriesLoadingState());
      try {
        final series = await apiService.getSeries();
        emit(SeriesLoadedState(series));
      } catch (e) {
        emit(SeriesErrorState('Failed to fetch series: $e'));
      }
    });
  }
}

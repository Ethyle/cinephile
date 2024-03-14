import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../models/news_model.dart'; 
import '../../services/api_service.dart'; 

// Événements
abstract class NewsEvent extends Equatable {
  const NewsEvent();
}

class FetchNewsEvent extends NewsEvent {
  @override
  List<Object> get props => [];
}

// États
abstract class NewsState extends Equatable {
  const NewsState();
}

class NewsInitialState extends NewsState {
  @override
  List<Object> get props => [];
}

class NewsLoadingState extends NewsState {
  @override
  List<Object> get props => [];
}

class NewsLoadedState extends NewsState {
  final List<News> newss;
  
  const NewsLoadedState(this.newss);

  @override
  List<Object> get props => [newss];
}

class NewsErrorState extends NewsState {
  final String error;

  const NewsErrorState(this.error);

  @override
  List<Object> get props => [error];
}

// Bloc
class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final ApiService apiService;

  NewsBloc(this.apiService) : super(NewsInitialState()) {
    on<FetchNewsEvent>((event, emit) async {
      emit(NewsLoadingState());
      try {
        final newss = await apiService.getNews();
        emit(NewsLoadedState(newss));
      } catch (e) {
        emit(NewsErrorState('Failed to fetch News: $e'));
      }
    });
  }
}

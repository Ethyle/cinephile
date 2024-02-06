import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cinephile/blocs/comics_bloc.dart';
import 'package:cinephile/blocs/movies_bloc.dart';
import 'package:cinephile/blocs/series_bloc.dart';
import 'package:cinephile/blocs/character_bloc.dart';

import 'package:cinephile/services/api_service.dart';
import 'package:cinephile/screens/home_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';




Future main() async {
  await dotenv.load(fileName: ".env");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context ) {
    // Créez une instance de votre service API.
    final ApiService apiService = ApiService();

    // Utilisez MultiBlocProvider pour injecter les blocs.
    return MultiBlocProvider(
      providers: [
        BlocProvider<ComicsBloc>(
          create: (context) => ComicsBloc(apiService),
        ),
        BlocProvider<SeriesBloc>(
          create: (context) => SeriesBloc(apiService),
        ),
        BlocProvider<MoviesBloc>(
          create: (context) => MoviesBloc(apiService),
        ),
        BlocProvider<CharacterBloc>(
          create: (context) => CharacterBloc(apiService),
        ),
      ],
      child: MaterialApp(
        title: 'Cinephile',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomeScreen(),
      ),
    );
  }
}
//test 

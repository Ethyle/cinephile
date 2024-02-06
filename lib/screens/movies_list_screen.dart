import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/movies_bloc.dart'; 
import '../widgets/movies_widget.dart'; 

class MoviesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Lorsque l'écran est construit, nous déclenchons le chargement des films
    BlocProvider.of<MoviesBloc>(context).add(FetchMoviesEvent());

    return Scaffold(
      appBar: AppBar(
        title: Text('Films les plus populaires'),
        backgroundColor: Colors.black87, // Changez la couleur en fonction de votre thème
      ),
      body: BlocBuilder<MoviesBloc, MoviesState>(
        builder: (context, state) {
          if (state is MoviesInitialState) {
            return Center(child: Text('Aucune donnée. Swipez vers le bas pour rafraîchir.'));
          } else if (state is MoviesLoadingState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is MoviesLoadedState) {
            return ListView.builder(
              itemCount: state.movies.length,
              itemBuilder: (context, index) {
                final movie = state.movies[index];
                return MoviesWidget(
                    movie : movie
                );
              },
            );
          } else if (state is MoviesErrorState) {
            return Center(
              child: Text('Erreur: ${state.error}'),
            );
          } else {
            // Cet état est inattendu, donc juste un conteneur vide
            return Container();
          }
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/movies_bloc.dart'; 
import '../widgets/movies_widget.dart'; 
import '../ui/theme.dart';

class MoviesListScreen extends StatelessWidget {
  const MoviesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<MoviesBloc>(context).add(FetchMoviesEvent());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Films les plus populaires',
          style: TextStyle(color: Colors.white)),
        backgroundColor: AppColors.seeMoreBackground, // Utiliser la couleur définie dans theme.dart
      ),
      body: BlocBuilder<MoviesBloc, MoviesState>(
        builder: (context, state) {
          if (state is MoviesLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is MoviesLoadedState) {
            return ListView.separated(
              itemCount: state.movies.length,
              separatorBuilder: (context, index) => Divider(color: AppColors.seeMoreBackground), // Diviseur personnalisé
              itemBuilder: (context, index) {
                final movie = state.movies[index];
                return MoviesWidget(
                  movie: movie,
                  rank: index + 1, // Passer le rang pour afficher le numéro
                );
              },
            );
          } else if (state is MoviesErrorState) {
            return Center(
              child: Text('Erreur: ${state.error}'),
            );
          } else {
            return const Center(child: Text('Aucune donnée. Swipez vers le bas pour rafraîchir.'));
          }
        },
      ),
      backgroundColor: AppColors.seeMoreBackground, // Mettez la couleur de fond ici
    );
  }
}

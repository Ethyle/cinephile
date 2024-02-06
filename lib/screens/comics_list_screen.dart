import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/comics_bloc.dart'; 
import '../widgets/comics_widget.dart'; 

class ComicsListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Lorsque l'écran est construit, nous déclenchons le chargement des comics
    BlocProvider.of<ComicsBloc>(context).add(FetchComicsEvent());

    return Scaffold(
      appBar: AppBar(
        title: Text('Comics les plus populaires'),
        backgroundColor: Colors.black87, // Changez la couleur en fonction de votre thème
      ),
      body: BlocBuilder<ComicsBloc, ComicsState>(
        builder: (context, state) {
          if (state is ComicsInitialState) {
            return Center(child: Text('Aucune donnée. Swipez vers le bas pour rafraîchir.'));
          } else if (state is ComicsLoadingState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ComicsLoadedState) {
            return ListView.builder(
              itemCount: state.comics.length,
              itemBuilder: (context, index) {
                final comic = state.comics[index];
                return ComicsWidget(
                    comic: comic
                );
              },
            );
          } else if (state is ComicsErrorState) {
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/series_bloc.dart'; 
import '../widgets/series_widget.dart'; 

class SeriesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Lorsque l'écran est construit, nous déclenchons le chargement des séries
    BlocProvider.of<SeriesBloc>(context).add(FetchSeriesEvent());

    return Scaffold(
      appBar: AppBar(
        title: Text('Séries les plus populaires'),
        backgroundColor: Colors.black87, // Changer la couleur en fonction de votre thème
      ),
      body: BlocBuilder<SeriesBloc, SeriesState>(
        builder: (context, state) {
          if (state is SeriesInitialState) {
            return Center(child: Text('Aucune donnée. Swipez vers le bas pour rafraîchir.'));
          } else if (state is SeriesLoadingState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is SeriesLoadedState) {
            return ListView.builder(
              itemCount: state.series.length,
              itemBuilder: (context, index) {
                final serie = state.series[index];
                return SeriesWidget(
                  series: serie
                );
              },
            );
          } else if (state is SeriesErrorState) {
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

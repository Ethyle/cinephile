import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/comics_bloc.dart'; 
import '../widgets/comics_widget.dart'; 
import '../ui/theme.dart';

class ComicsListScreen extends StatelessWidget {
  const ComicsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ComicsBloc>(context).add(FetchComicsEvent());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Comics les plus populaires',
          style: TextStyle(color: Colors.white)),
        backgroundColor: AppColors.seeMoreBackground, // Utilisez la couleur définie dans theme.dart
      ),
      body: BlocBuilder<ComicsBloc, ComicsState>(
        builder: (context, state) {
          if (state is ComicsLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ComicsLoadedState) {
            return ListView.separated(
              itemCount: state.comics.length,
              separatorBuilder: (context, index) => Divider(color: AppColors.seeMoreBackground), // Diviseur personnalisé
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
            return const Center(child: Text('Aucune donnée. Swipez vers le bas pour rafraîchir.'));
          }
        },
      ),
      backgroundColor: AppColors.seeMoreBackground, // Mettez la couleur de fond ici
    );
  }
}

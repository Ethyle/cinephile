import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/series_bloc.dart'; 
import '../widgets/series_widget.dart'; 
import '../ui/theme.dart';

class SeriesListScreen extends StatelessWidget {
  const SeriesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<SeriesBloc>(context).add(FetchSeriesEvent());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Séries les plus populaires',
          style: TextStyle(color: Colors.white)),
        backgroundColor: AppColors.seeMoreBackground, 
      ),
      body: BlocBuilder<SeriesBloc, SeriesState>(
        builder: (context, state) {
          if (state is SeriesLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is SeriesLoadedState) {
            return ListView.separated(
              itemCount: state.series.length,
              separatorBuilder: (context, index) => Divider(color: AppColors.seeMoreBackground),
              itemBuilder: (context, index) {
                final serie = state.series[index];
                return SeriesWidget(
                  series: serie,
                  rank: index + 1,
                );
              },
            );
          } else if (state is SeriesErrorState) {
            return Center(
              child: Text('Erreur: ${state.error}'),
            );
          } else {
            return const Center(child: Text('Aucune donnée. Swipez vers le bas pour rafraîchir.'));
          }
        },
      ),
      backgroundColor: AppColors.seeMoreBackground, 
    );
  }
}

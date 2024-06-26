import 'package:cinephile/blocs/character_bloc.dart';
import 'package:cinephile/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart'; 
import '../models/series_model.dart';
import '../models/episode_model.dart'; 
import '../ui/theme.dart'; 
import '../blocs/episodes_bloc.dart'; 


class SeriesDetailsScreen extends StatefulWidget {
  final Series series;

  const SeriesDetailsScreen({Key? key, required this.series}) : super(key: key);

  @override
  State<SeriesDetailsScreen> createState() => _SeriesDetailsScreenState();
}

class _SeriesDetailsScreenState extends State<SeriesDetailsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  Widget _buildSeriesImage() {
    return Row(
      children: [
        Image.network(
          widget.series.imageUrl,
          width: 100,
          fit: BoxFit.cover,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${widget.series.numberOfEpisodes} Épisodes',
                style: TextStyle(color: Colors.white),
              ),
              Text(
                'Sortie: ${widget.series.releaseDate}',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Opacity(
            opacity: 0.5,
            child: Image.network(
              widget.series.imageUrl,
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
              alignment: Alignment.center,
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
              title: Text(widget.series.title, style: TextStyle(color: Colors.white)),
              backgroundColor: AppColors.seeMoreBackground,
              elevation: 0,
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ),
          Positioned(
            top: kToolbarHeight + MediaQuery.of(context).padding.top,
            left: 0,
            right: 0,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _buildSeriesImage(),
                  ),
                  _buildTabBar(),
                  Container(
                    height: MediaQuery.of(context).size.height - kToolbarHeight - MediaQuery.of(context).padding.top,
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        HistoryTab(series: widget.series),
                        CharactersTab(serie: widget.series),
                        EpisodesTab(series: widget.series),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  TabBar _buildTabBar() {
    return TabBar(
      controller: _tabController,
      indicatorColor: AppColors.orange,
      labelColor: Colors.white,
      unselectedLabelColor: Colors.white60,
      tabs: [
        Tab(text: 'Histoire'),
        Tab(text: 'Personnages'),
        Tab(text: 'Épisodes'),
      ],
    );
  }
}

class HistoryTab extends StatelessWidget {
  final Series series;

  const HistoryTab({Key? key, required this.series}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.seeMoreBackground, 
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: HtmlWidget(
          series.synopsis,
          textStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}

class CharactersTab extends StatelessWidget {
  final Series serie;

  const CharactersTab({Key? key, required this.serie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ApiService apiService = ApiService(); 

    return BlocProvider<CharacterBloc>(
      create: (context) => CharacterBloc(apiService)..add(FetchCharactersBySerieIdEvent(serie.id)),
      child: BlocBuilder<CharacterBloc, CharacterState>(
        builder: (context, state) {
          if (state is CharacterLoadingState) {
            return Center(child: CircularProgressIndicator(color: Colors.white));
          } else if (state is CharacterLoadedState) {
            return Container(
              color: AppColors.seeMoreBackground, 
              child: ListView.builder(
                itemCount: state.characters.length,
                itemBuilder: (context, index) {
                  final character = state.characters[index];
                  return Card(
                    color: AppColors.cardBackground, 
                    child: ListTile(
                      title: Text(character.name, style: TextStyle(color: Colors.white)),
                    ),
                  );
                },
              ),
            );
          } else if (state is CharacterErrorState) {
            return Center(child: Text('Error: ${state.error}', style: TextStyle(color: Colors.white)));
          } else {
            return Center(child: Text('Start searching for characters', style: TextStyle(color: Colors.white)));
          }
        },
      ),
    );
  }
}

class EpisodesTab extends StatelessWidget {
  final Series series;

  const EpisodesTab({Key? key, required this.series}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Demander à EpisodeBloc de charger les épisodes pour la série actuelle
    context.read<EpisodeBloc>().add(FetchEpisodesBySeriesIdEvent(series.id));

    return Container(
      color: AppColors.seeMoreBackground, 
      child: BlocBuilder<EpisodeBloc, EpisodeState>(
        builder: (context, state) {
          if (state is EpisodeLoadingState) {
            return const CircularProgressIndicator();
          } else if (state is EpisodeLoadedState) {
            // Construction de la liste des épisodes
           return ListView.builder(
              itemCount: state.episodes.length,
              itemBuilder: (context, index) {
                return _buildEpisodeCard(state.episodes[index], index);
              },
            );
          } else if (state is EpisodeErrorState) {
            return Center(child: Text(state.error));
          }
          return const SizedBox(); // Pour EpisodeInitialState ou un état inattendu
        },
      ),
    );
  }

Widget _buildEpisodeCard(Episode episode, int index) {
  String episodeNumber = (index + 1).toString().padLeft(2, '0');

  return Card(
    color: AppColors.cardBackground,
    child: ListTile(
      leading: Image.network(episode.imageUrl, fit: BoxFit.cover, width: 50),
      title: Text(episode.name, style: TextStyle(color: Colors.white)),
      subtitle: Text('Episode #$episodeNumber - ${episode.airDate}', style: TextStyle(color: Colors.white70)),
    ),
  );
}

}

Widget _buildCardItem({
  required String imageUrl,
  required String title,
  String? subtitle,
  required BuildContext context,
}) {
  return Card(
    color: AppColors.cardBackground,
    child: ListTile(
      leading: Image.network(imageUrl, fit: BoxFit.cover),
      title: Text(title, style: TextStyle(color: Colors.white)),
      subtitle: subtitle != null ? Text(subtitle, style: TextStyle(color: Colors.white70)) : null,
    ),
  );
}



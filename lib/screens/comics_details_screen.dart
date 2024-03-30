import 'package:cinephile/blocs/character_bloc.dart';
import 'package:cinephile/blocs/comics_bloc.dart';
import 'package:cinephile/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart'; 
import '../models/comics_model.dart';
import '../ui/theme.dart'; 

class ComicsDetailsScreen extends StatefulWidget {
  final Comic comics;

  const ComicsDetailsScreen({Key? key, required this.comics}) : super(key: key);

  @override
  State<ComicsDetailsScreen> createState() => _ComicsDetailsScreenState();
}

class _ComicsDetailsScreenState extends State<ComicsDetailsScreen> with SingleTickerProviderStateMixin {
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
          widget.comics.imageUrl,
          width: 100,
          fit: BoxFit.cover,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${widget.comics.numberOfVolume} tomes',
                style: TextStyle(color: Colors.white),
              ),
              Text(
                'Sortie: ${widget.comics.releaseDate}',
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
              widget.comics.imageUrl,
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
              title: Text(widget.comics.name, style: TextStyle(color: Colors.white)),
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
                        HistoryTab(comics: widget.comics),
                        CharactersTab(comic: widget.comics),
                        AuthorsTab(comic: widget.comics),
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
        Tab(text: 'Auteurs'),
      ],
    );
  }
}

class HistoryTab extends StatelessWidget {
  final Comic comics;

  const HistoryTab({Key? key, required this.comics}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.seeMoreBackground, 
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: HtmlWidget(
          comics.description,
          textStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}

class CharactersTab extends StatelessWidget {
  final Comic comic;

  const CharactersTab({Key? key, required this.comic}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ApiService apiService = ApiService(); 

    return BlocProvider<CharacterBloc>(
      create: (context) => CharacterBloc(apiService)..add(FetchCharactersByComicIdEvent(comic.id)),
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

class AuthorsTab extends StatelessWidget {
  final Comic comic;

  const AuthorsTab({Key? key, required this.comic}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Demander au Bloc de charger les auteurs lorsque l'onglet est construit
    BlocProvider.of<ComicsBloc>(context).add(FetchComicAuthorsEvent(comic.id));

    return BlocBuilder<ComicsBloc, ComicsState>(
      builder: (context, state) {
        if (state is AuthorsLoadingState) {
          return Center(child: CircularProgressIndicator(color: Colors.white));
        } else if (state is AuthorsLoadedState) {
          // Affiche la liste des auteurs
          return Container(
            color: AppColors.seeMoreBackground, 
            child: ListView.builder(
              itemCount: state.authors.length,
              itemBuilder: (context, index) {
                final author = state.authors[index];
                return Card(
                  color: AppColors.cardBackground, 
                  child: ListTile(
                    title: Text(author, style: TextStyle(color: Colors.white)),
                  ),
                );
              },
            ),
          );
        } else if (state is AuthorsErrorState) {
          // Affiche une erreur si le chargement a échoué
          return Center(child: Text('Error: ${state.error}', style: TextStyle(color: Colors.white)));
        } else {
          // État par défaut, par exemple si les auteurs n'ont pas encore été chargés ou s'il n'y a pas d'auteurs.
          return Center(child: Text('Aucun auteur trouvé', style: TextStyle(color: Colors.white)));
        }
      },
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


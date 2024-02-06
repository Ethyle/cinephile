import 'package:flutter/material.dart';
import '../ui/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/comics_bloc.dart';
import '../blocs/movies_bloc.dart';
import '../blocs/series_bloc.dart';
import '../blocs/character_bloc.dart';
import '../blocs/news_bloc.dart';

import '../models/comics_model.dart';
import '../models/movies_model.dart';
import '../models/series_model.dart';
import '../models/character_model.dart';
import '../models/news_model.dart';


import '../widgets/comicshomewidget.dart';
import '../widgets/serieshomewidget.dart';
import '../widgets/movieshomewidget.dart';
import '../widgets/characters_widget.dart';
import '../widgets/news_widget.dart';

import '../screens/comics_list_screen.dart';
import '../screens/series_list_screen.dart';
import '../screens/movies_list_screen.dart';
import '../screens/search_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

    int _selectedIndex = 0; // L'index de l'onglet sélectionné
  final PageController _pageController = PageController();

  void _onItemTapped(int index) {
    // Mettez à jour l'index de l'onglet et la page affichée
    setState(() {
      _selectedIndex = index;
    });
    _pageController.jumpToPage(index);
  }

    @override
  void initState() {
    super.initState();
    
    // Ajout d'un délai pour permettre l'initialisation du contexte
    Future.delayed(Duration.zero, () {
      BlocProvider.of<ComicsBloc>(context).add(FetchComicsEvent());
      BlocProvider.of<MoviesBloc>(context).add(FetchMoviesEvent());
      BlocProvider.of<SeriesBloc>(context).add(FetchSeriesEvent());
      BlocProvider.of<CharacterBloc>(context).add(FetchCharactersEvent());
      BlocProvider.of<NewsBloc>(context).add(FetchNewsEvent());

    });
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Bienvenue !'),
      backgroundColor: AppColors.backgroundColor,
    ),
    body: PageView(
      controller: _pageController,
      children: <Widget>[
        // Écran d'accueil avec des sliders
        Scaffold(
          body: ListView(
            children: <Widget>[
              _buildSectionTitle('Actualité'),
             // _buildNewsSection(),   SECTION ACTUAITE DesactivE CAR BUG JSP POURQUOI 
              _buildSectionTitle('Comics populaires'),
              _buildComicsSection(),
              _buildSectionTitle('Séries populaires'),
              _buildSeriesSection(),
              _buildSectionTitle('Films populaires'),
              _buildMoviesSection(),
              _buildSectionTitle('Personnages populaires'),
              _buildCharactersSection(),  
            ],
          ),
        ),
        // Les autres écrans
        ComicsListScreen(),
        SeriesListScreen(),
        MoviesListScreen(),
        SearchScreen(),
      ],
      onPageChanged: (index) {
        setState(() {
          _selectedIndex = index;
        });
      },
    ),
    bottomNavigationBar: _buildBottomNavigationBar(),
  );
}

Widget _buildNewsSection() {
  return BlocBuilder<NewsBloc, NewsState>(
    builder: (context, state) {
      if (state is NewsLoadingState) {
        return CircularProgressIndicator();
      } else if (state is NewsLoadedState) {
        return _buildNewsList(state.newss);
      } else if (state is NewsErrorState) {
        return Text(state.error);
      }
      return Container(); // State initial ou autre
    },
  );
}

Widget _buildComicsSection() {
  return BlocBuilder<ComicsBloc, ComicsState>(
    builder: (context, state) {
      if (state is ComicsLoadingState) {
        return CircularProgressIndicator();
      } else if (state is ComicsLoadedState) {
        return _buildComicsList(state.comics);
      } else if (state is ComicsErrorState) {
        return Text(state.error);
      }
      return Container(); // State initial ou autre
    },
  );
}

Widget _buildSeriesSection() {
  return BlocBuilder<SeriesBloc, SeriesState>(
    builder: (context, state) {
if (state is SeriesLoadingState) {
        return CircularProgressIndicator();
      } else if (state is SeriesLoadedState) {
        return _buildSeriesList(state.series);
      } else if (state is SeriesErrorState) {
        return Text(state.error);
      }
      return Container(); },
  );
}

Widget _buildMoviesSection() {
  return BlocBuilder<MoviesBloc, MoviesState>(
    builder: (context, state) {
if (state is MoviesLoadingState) {
        return CircularProgressIndicator();
      } else if (state is MoviesLoadedState) {
        return _buildMoviesList(state.movies);
      } else if (state is MoviesErrorState) {
        return Text(state.error);
      }
      return Container(); // State initial ou autre
          },
  );
}

Widget _buildCharactersSection() {
  print('saluuuuuuuuuut');
  return BlocBuilder<CharacterBloc, CharacterState>(
    builder: (context, state) {
        print('olalalalala');
if (state is CharacterLoadingState) {
          print('3469636');
        return CircularProgressIndicator();
      } else if (state is CharacterLoadedState) {
        print('ca dit quoi');
        return _buildCharactersList(state.characters);
      } else if (state is CharacterErrorState) {
        return Text(state.error);
      }
      return Container(); // State initial ou autre  
        },
  );
}

  Widget _buildNewsList(List<News> news) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: news.length,
        itemBuilder: (context, index) {
          final newss = news[index];
          return NewsWidget(
            imageUrl: newss.imageUrl,
            title: newss.title,
          );
        },
      ),
    );
  }

Widget _buildComicsList(List<Comic> comics) {
  return Container(
    height: 200,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: comics.length,
      itemBuilder: (context, index) {
        final comic = comics[index];
        return ComicsHomeWidget(
          comic: comic, // Passez l'objet comic ici
        );
      },
    ),
  );
}


  Widget _buildMoviesList(List<Movie> movies) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return MovieHomeWidget(
                  movie : movie
                );
        },
      ),
    );
  }

Widget _buildSeriesList(List<Series> series) {
  return Container(
    height: 200,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: series.length,
      itemBuilder: (context, index) {
        final serie = series[index];
        return SeriesHomeWidget(
          series : serie,
        );
      },
    ),
  );
}

Widget _buildCharactersList(List<Character> characters) {
  return Container(
    height: 200,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: characters.length,
      itemBuilder: (context, index) {
        final character = characters[index];
        return CharacterWidget(
          character: character,
        );
      },
    ),
  );
}

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(title, style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: const Color.fromARGB(255, 0, 0, 0))),
    );
  }


  Widget _buildHorizontalCardList() {
    // Ceci est juste un exemple de données fictives, remplacez par vos propres widgets de cartes.
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 10, // Nombre de cartes fictives à afficher
        itemBuilder: (context, index) {
          return _buildCard();
        },
      ),
    );
  }

  Widget _buildCard() {
    // Ceci est juste une carte fictive, remplacez par votre CustomCard widget.
    return Card(
      color: AppColors.cardBackground,
      child: Container(
        width: 160,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.movie, size: 50), // Remplacez par une image si vous le souhaitez
            Text('Contenu Fictif', style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }

    BottomNavigationBar _buildBottomNavigationBar() {
      return BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.bottomBarBackground,
        selectedItemColor: AppColors.orange,
        unselectedItemColor: AppColors.bottomBarUnselectedText,
        currentIndex: _selectedIndex, // Mettre à jour l'index courant
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Comics',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.tv),
            label: 'Séries',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.movie),
            label: 'Films',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Recherche',
          ),
        ],
      );
    }
  }


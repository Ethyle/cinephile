import 'package:flutter/material.dart';
import '../models/movies_model.dart'; 


class MoviesDetailsScreen extends StatelessWidget {
  final Movie movie;

  MoviesDetailsScreen({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movie.name), // Titre avec le titre du film
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Image.network(movie.imageUrl, fit: BoxFit.cover), // Affiche l'image du film
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text('Description', style: Theme.of(context).textTheme.headline6),
                  SingleChildScrollView(
                    child: Text(
                      movie.synopsis, // Utilisez movie.description ou un champ similaire
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                  SizedBox(height: 10),
                  // Ici, vous pouvez ajouter d'autres informations pertinentes sur le film
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

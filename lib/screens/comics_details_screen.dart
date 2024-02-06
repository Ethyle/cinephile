import 'package:flutter/material.dart';
import '../models/comics_model.dart';

class ComicsDetailsScreen extends StatelessWidget {
  final Comic comic;

  ComicsDetailsScreen({required this.comic});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(comic.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Image.network(comic.imageUrl, fit: BoxFit.cover), // Affiche l'image du haut
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text('Histoire', style: Theme.of(context).textTheme.headline6),
                  SingleChildScrollView(
                    child: Text(
                      comic.description,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                  SizedBox(height: 10),
                  // Ici, ajoutez les auteurs et les personnages de la même manière
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

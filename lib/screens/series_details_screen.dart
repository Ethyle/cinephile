import 'package:flutter/material.dart';
import '../models/series_model.dart'; 

class SeriesDetailsScreen extends StatelessWidget {
  final Series series;

  SeriesDetailsScreen({required this.series});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(series.title), // Titre avec le titre de la série
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Image.network(series.imageUrl, fit: BoxFit.cover), // Affiche l'image de la série
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text('Description', style: Theme.of(context).textTheme.headline6),
                  SingleChildScrollView(
                    child: Text(
                      series.synopsis, // Utilisez series.description ou un champ similaire
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                  SizedBox(height: 10),
                  // Ici, vous pouvez ajouter d'autres informations pertinentes sur la série
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

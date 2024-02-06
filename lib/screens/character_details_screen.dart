import 'package:flutter/material.dart';
import '../models/character_model.dart';

class CharacterDetailsScreen extends StatelessWidget {
  final Character character;

  CharacterDetailsScreen({required this.character});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(character.name), // Titre avec le nom du personnage
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Image.network(character.imageUrl, fit: BoxFit.cover), // Affiche l'image du personnage
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text('Description', style: Theme.of(context).textTheme.headline6),
                  SingleChildScrollView(
                    child: Text(
                      character.description, // Utilisez character.description ou un champ similaire
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                  SizedBox(height: 10),
                  // Ici, vous pouvez ajouter d'autres informations pertinentes sur le personnage
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

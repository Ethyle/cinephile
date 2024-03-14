import 'package:flutter/material.dart';
import '../models/movies_model.dart';
import '../screens/movies_details_screen.dart';
import '../ui/theme.dart'; // Assurez-vous d'importer le fichier theme.dart correctement

class MovieHomeWidget extends StatelessWidget {
  final Movie movie;

  const MovieHomeWidget({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final imageHeight = screenWidth * 0.3; // hauteur de l'image
    final cardHeight = screenWidth * 0.5; // hauteur totale de la carte, ajustez au besoin

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MoviesDetailsScreen(movies: movie),
          ),
        );
      },
      child: Container(
        width: screenWidth * 0.4, // largeur du widget
        height: cardHeight,
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: AppColors.elementBackground, // Utilisez votre couleur de fond
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 0,
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
              child: Image.network(
                movie.imageUrl,
                width: double.infinity, // force l'image à remplir la largeur du conteneur
                height: imageHeight,
                fit: BoxFit.cover,
              ),
            ),
            Expanded( // Flex pour s'adapter au texte de différentes longueurs
              child: Container(
                padding: EdgeInsets.all(8),
                child: Center(
                  child: Text(
                    movie.name,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14, // ajuster la taille de la police au besoin
                    ),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis, // Ajouter ceci pour gérer les textes plus longs
                    maxLines: 2, // Permettre au texte de s'étendre sur deux lignes
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

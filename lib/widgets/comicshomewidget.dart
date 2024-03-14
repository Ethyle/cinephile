import 'package:flutter/material.dart';
import '../models/comics_model.dart';
import '../screens/comics_details_screen.dart'; 
import '../ui/theme.dart'; // Assurez-vous d'importer le fichier theme.dart correctement

class ComicsHomeWidget extends StatelessWidget {
  final Comic comic;

  const ComicsHomeWidget({super.key, required this.comic});

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
            builder: (context) => ComicsDetailsScreen(comics: comic),
          ),
        );
      },
      child: Container(
        width: screenWidth * 0.4, // largeur du widget
        height: cardHeight,
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: AppColors.elementBackground, // Couleur de fond pour le widget
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
                comic.imageUrl,
                width: double.infinity, // force l'image à remplir la largeur du conteneur
                height: imageHeight,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(8),
                child: Center(
                  child: Text(
                    comic.name,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14, // ajuster la taille de la police au besoin
                    ),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis, // gère les textes plus longs
                    maxLines: 2, // permet au texte de s'étendre sur deux lignes
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

import 'package:flutter/material.dart';
import '../models/series_model.dart';
import '../screens/series_details_screen.dart'; // Assurez-vous que le chemin d'accès est correct

class SeriesWidget extends StatelessWidget {
  final Series series; // Modifier pour passer l'objet Series

  SeriesWidget({required this.series});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final imageWidth = screenWidth * 0.3;
    final imageHeight = imageWidth * 1.5;
    final paddingSize = screenWidth * 0.02;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SeriesDetailsScreen(series: series),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(paddingSize),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image de couverture
            Container(
              width: imageWidth,
              height: imageHeight,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(series.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: paddingSize),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Titre
                  Text(
                    series.title,
                    style: TextStyle(
                      fontSize: screenWidth * 0.04,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: paddingSize),

                  // Date de sortie
                  Row(
                    children: [
                      Icon(Icons.calendar_today, size: screenWidth * 0.02),
                      SizedBox(width: paddingSize),
                      Text(series.releaseDate),
                    ],
                  ),
                  SizedBox(height: paddingSize),

                  // Nombre d'épisodes
                  Row(
                    children: [
                      Icon(Icons.format_list_numbered, size: screenWidth * 0.02),
                      SizedBox(width: paddingSize),
                      Text(series.numberOfEpisodes.toString()), // Assurez-vous que ce champ existe dans votre modèle
                    ],
                  ),
                  SizedBox(height: paddingSize),

                  // Autres informations sur la série
                  // Ajoutez ici si nécessaire
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

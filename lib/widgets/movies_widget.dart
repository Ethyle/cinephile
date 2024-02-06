import 'package:flutter/material.dart';
import '../models/movies_model.dart';
import '../screens/movies_details_screen.dart'; // Assurez-vous que le chemin d'accès est correct

class MoviesWidget extends StatelessWidget {
  final Movie movie; // Modifier pour passer l'objet Movie

  MoviesWidget({required this.movie});

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
            builder: (context) => MoviesDetailsScreen(movie: movie),
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
                  image: NetworkImage(movie.imageUrl),
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
                    movie.name,
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
                      Text(movie.releaseDate), // Assurez-vous que ces champs existent dans votre modèle
                    ],
                  ),
                  SizedBox(height: paddingSize),

                  // Durée du film
                  Row(
                    children: [
                      Icon(Icons.access_time, size: screenWidth * 0.02),
                      SizedBox(width: paddingSize),
                      Text(movie.duration),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

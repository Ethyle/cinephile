import 'package:flutter/material.dart';
import '../models/movies_model.dart';
import '../screens/movies_details_screen.dart';

class MovieHomeWidget extends StatelessWidget {
  final Movie movie; // Modifier pour passer l'objet Movie

  MovieHomeWidget({required this.movie});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final imageWidth = screenWidth * 0.3;
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
        child: Column(
          children: [
            // Image du film
            Container(
              width: imageWidth,
              height: imageWidth,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(movie.imageUrl), // Utiliser movie.imageUrl
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: paddingSize),

            // Titre du film
            Text(
              movie.name, // Utiliser movie.name
              style: TextStyle(
                fontSize: screenWidth * 0.04,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

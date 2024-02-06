import 'package:flutter/material.dart';
import '../models/comics_model.dart';
import '../screens/comics_details_screen.dart';  // Assurez-vous que le chemin d'accès est correct

class ComicsWidget extends StatelessWidget {
  final Comic comic;

  ComicsWidget({required this.comic});

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
            builder: (context) => ComicsDetailsScreen(comic: comic),
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
                  image: NetworkImage(comic.imageUrl),
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
                    comic.name,
                    style: TextStyle(
                      fontSize: screenWidth * 0.04,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: paddingSize),

                  // Date de parution
                  Row(
                    children: [
                      Icon(Icons.calendar_today, size: screenWidth * 0.02),
                      SizedBox(width: paddingSize),
                      Text(comic.releaseDate), // Assurez-vous que ces champs existent dans votre modèle
                    ],
                  ),
                  SizedBox(height: paddingSize),

                  // Numéro de tome
                  Row(
                    children: [
                      Icon(Icons.book, size: screenWidth * 0.02),
                      SizedBox(width: paddingSize),
                      Text('Tome ${comic.numberOfVolume}'),
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

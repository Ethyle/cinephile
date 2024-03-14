import 'package:flutter/material.dart';
import '../models/comics_model.dart';
import '../screens/comics_details_screen.dart';
import '../ui/theme.dart'; // Assurez-vous d'importer le fichier theme.dart correctement

class ComicsWidget extends StatelessWidget {
  final Comic comic;
  
  const ComicsWidget({super.key, required this.comic});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final paddingSize = screenWidth * 0.02;
    final imageWidth = screenWidth * 0.25; // Ajustez en fonction de la largeur de l'écran
    final imageHeight = imageWidth * 1.5; // Pour un meilleur aspect ratio
    final cardHeight = screenWidth * 0.6 / 2; // Ajustez pour que 4 éléments tiennent avant de scroller

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
        height: cardHeight,
        margin: EdgeInsets.symmetric(horizontal: paddingSize, vertical: paddingSize / 2),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 3,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                comic.imageUrl,
                width: imageWidth,
                height: imageHeight,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: paddingSize),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      comic.name,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Parution: ${comic.releaseDate}',
                      style: TextStyle(color: Colors.grey[400], fontSize: 14),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Volume: ${comic.numberOfVolume}',
                      style: TextStyle(color: Colors.grey[400], fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

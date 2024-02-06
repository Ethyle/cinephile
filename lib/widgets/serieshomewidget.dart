import 'package:flutter/material.dart';
import '../models/series_model.dart';
import '../screens/series_details_screen.dart'; 


class SeriesHomeWidget extends StatelessWidget {
  final Series series;  // Modifier pour passer l'objet Series

  SeriesHomeWidget({required this.series});

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
            builder: (context) => SeriesDetailsScreen(series: series),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(paddingSize),
        child: Column(
          children: [
            // Image de la série
            Container(
              width: imageWidth,
              height: imageWidth,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(series.imageUrl),  // Utiliser series.imageUrl
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: paddingSize),

            // Titre de la série
            Text(
              series.title,  // Utiliser series.title
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

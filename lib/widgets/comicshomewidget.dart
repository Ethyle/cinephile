import 'package:flutter/material.dart';
import '../screens/comics_details_screen.dart'; 
import '../models/comics_model.dart';

class ComicsHomeWidget extends StatelessWidget {
  final Comic comic;

  ComicsHomeWidget({required this.comic});

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
            builder: (context) => ComicsDetailsScreen(comic: comic),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(paddingSize),
        child: Column(
          children: [
            // Image du comics
            Container(
              width: imageWidth,
              height: imageWidth,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(comic.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: paddingSize),
            // Titre du comics
            Text(
              comic.name,
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

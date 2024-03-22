import 'package:flutter/material.dart';
import '../models/character_model.dart';  
import '../screens/character_details_screen.dart';  

class CharacterWidget extends StatelessWidget {
  final Character character;  // Modifier pour passer l'objet Character

  const CharacterWidget({super.key, required this.character});

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
            builder: (context) => CharacterDetailsScreen(character: character),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(paddingSize),
        child: Column(
          children: [
            // Image du personnage
            Container(
              width: imageWidth,
              height: imageWidth,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(character.imageUrl ?? 'information nulle'),  // Utiliser character.imageUrl
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: paddingSize),

            // Nom du personnage
            Text(
              character.name,  // Utiliser character.name
              style: TextStyle(color: Colors.white,
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

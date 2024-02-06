import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../ui/theme.dart'; 

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor, // Remplacez par la couleur de fond de votre choix
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Comic, film, série...',
                hintStyle: TextStyle(color: AppColors.bottomBarUnselectedText), 
                prefixIcon: Icon(Icons.search, color: AppColors.bottomBarUnselectedText), 
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: AppColors.backgroundColor, 
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    '../res/svg/astronaut.svg',
                    width: 120, 
                  ),
                  SizedBox(height: 16), // Un espace entre l'image SVG et le texte
                  Text(
                    'Saisissez une recherche pour trouver un comic, film, série ou personnage.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.bottomBarUnselectedText,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

}

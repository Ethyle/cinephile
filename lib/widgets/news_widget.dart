import 'package:flutter/material.dart';

class NewsWidget extends StatelessWidget {
  final String imageUrl;
  final String title;

  const NewsWidget({super.key, 
    required this.imageUrl,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final imageWidth = screenWidth * 0.3;
    final paddingSize = screenWidth * 0.02;

    return Container(
      padding: EdgeInsets.all(paddingSize),
      child: Column(
        children: [
          // Image article
          Container(
            width: imageWidth,
            height: imageWidth,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: paddingSize),

          // titre article
          Text(
            title,
            style: TextStyle(
              fontSize: screenWidth * 0.04,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class MovieCard extends StatelessWidget {
  final String rating;
  final String imagePath;

  MovieCard({super.key, required this.rating, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(14);

    return Stack(
      children: [
        ClipRRect(
          borderRadius: radius,
          child: Container(
            decoration: BoxDecoration(color: Colors.black),
            child: Image.network(
              imagePath,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Icon(Icons.broken_image),
              loadingBuilder: (_, child, progress) => progress == null
                  ? child
                  : Center(child: CircularProgressIndicator()),
            ),
          ),
        ),

        Positioned(
          top: 8,
          left: 8,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.redAccent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              rating,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

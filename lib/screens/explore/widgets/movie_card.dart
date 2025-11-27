import 'package:flutter/material.dart';
import 'package:mova_app/utils/app_color.dart';

class MovieCard extends StatelessWidget {
  final String rating;
  final String imagePath;
  final VoidCallback? onTap;

  MovieCard({super.key, required this.rating, required this.imagePath, this.onTap});

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(14);

       return GestureDetector(          // <--- WRAP DENGAN GESTURE DETECTOR
      onTap: onTap,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: radius,
            child: Container(
              decoration: BoxDecoration(color: AppColors.kPrimary),
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
                color: AppColors.kSecondary,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                rating,
                style: TextStyle(
                  color: AppColors.kTextColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
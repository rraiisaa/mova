import 'package:flutter/material.dart';
import 'package:mova_app/models/mova_model.dart';
import 'package:mova_app/utils/app_color.dart';

class MoviePosterItem extends StatelessWidget {
  final Movie movie;
  final VoidCallback? onTap;

  const MoviePosterItem({super.key, required this.movie, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () {
        // placeholder action
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(movie.title)));
      },
      child: SizedBox(
        width: 130,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            children: [
              Image.network(
                "https://image.tmdb.org/t/p/w500${movie.posterPath}",
                fit: BoxFit.cover,
                width: 130,
                height: 200,
                errorBuilder: (_, __, ___) => Container(color: Colors.grey),
              ),

              // rating badge top-left
              if (movie.voteAverage != null)
                Positioned(
                  top: 6,
                  left: 6,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                    decoration: BoxDecoration(
                      color: AppColors.kSecondary,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      movie.voteAverage.toStringAsFixed(1),
                      style: const TextStyle(color: AppColors.kTextColor, fontSize: 11, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

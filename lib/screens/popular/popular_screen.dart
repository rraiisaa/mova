import 'package:flutter/material.dart';
import 'package:mova_app/models/mova_model.dart';
import 'package:mova_app/utils/app_color.dart';

class PopularScreen extends StatelessWidget {
  final List<Movie> movies;
  final String title;

  const PopularScreen({super.key, required this.movies, this.title = 'Popular'});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kPrimary,
      appBar: AppBar(
        backgroundColor: AppColors.kPrimary,
        elevation: 0,
        title: Text(title, style: const TextStyle(color: AppColors.kTextColor)),
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: GridView.builder(
          itemCount: movies.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 0.62, // poster tall
          ),
          itemBuilder: (context, index) {
            final movie = movies[index];
            return ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Stack(
                children: [
                  Image.network(
                    "https://image.tmdb.org/t/p/w500${movie.posterPath}",
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(color: Colors.grey),
                  ),

                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                      decoration: BoxDecoration(
                        color: AppColors.kSecondary,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        movie.voteAverage.toStringAsFixed(1),
                        style: const TextStyle(color: AppColors.kTextColor, fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

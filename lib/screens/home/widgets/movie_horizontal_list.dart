import 'package:flutter/material.dart';
import 'package:mova_app/models/mova_model.dart';
import 'package:mova_app/screens/home/widgets/movie_poster_item.dart';
import 'package:mova_app/utils/app_color.dart';

class MovieHorizontalList extends StatelessWidget {
  final String title;
  final List<Movie> movies;
  final VoidCallback? onSeeAll;

  const MovieHorizontalList({
    super.key,
    required this.title,
    required this.movies,
    this.onSeeAll,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Title + See All
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: AppColors.kTextColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              if (onSeeAll != null)
                GestureDetector(
                  onTap: onSeeAll,
                  child: const Text(
                    "See all",
                    style: TextStyle(
                      color: AppColors.kSecondary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
            ],
          ),
        ),

        SizedBox(height: 12),

        /// Horizontal Scroll Posters
        SizedBox(
          height: 220,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, i) {
              final movie = movies[i];
              return MoviePosterItem(movie: movie);
            },
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemCount: movies.length,
          ),
        ),
      ],
    );
  }
}

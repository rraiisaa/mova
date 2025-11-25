import 'package:flutter/material.dart';
import 'package:mova_app/models/mova_model.dart';
import 'package:mova_app/utils/app_color.dart';

class HomeHeader extends StatelessWidget {
  final Movie movie;

  const HomeHeader({super.key, required this.movie});

  void _onPlay(BuildContext context) {
    // contoh interaksi: tampilkan snackbar / buka player screen
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Play ${movie.title}')));
  }

  void _onMyList(BuildContext context) {
    // contoh interaksi: simpan ke local favourites (placeholder)
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Added to My List'),
        content: Text('${movie.title} added to your list.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 260, // sesuai permintaan: pendek (tidak setengah layar)
      child: Stack(
        children: [
          // backdrop
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                "https://image.tmdb.org/t/p/original/${movie.backDropPath}",
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(color: Colors.grey),
              ),
            ),
          ),

          // gradient overlay
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, AppColors.kPrimary.withValues(alpha: 0.7)],
                ),
              ),
            ),
          ),

          // content
          Positioned(
            left: 16,
            right: 16,
            bottom: 18,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: AppColors.kTextColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 6),

                Text(
                  // placeholder genres — kamu bisa map genre IDs -> names jika mau
                  "Action • Adventure • Sci-fi",
                  style: TextStyle(
                    color: AppColors.kTextColor.withValues(alpha: 0.75),
                    fontSize: 12,
                  ),
                ),

                const SizedBox(height: 12),

                Row(
                  children: [
                    ElevatedButton.icon(
                      onPressed: () => _onPlay(context),
                      icon: Icon(Icons.play_arrow, color: AppColors.kTextColor),
                      label: Text(
                        "Play",
                        style: TextStyle(color: AppColors.kTextColor),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.kSecondary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                      ),
                    ),

                    const SizedBox(width: 12),

                    OutlinedButton.icon(
                      onPressed: () => _onMyList(context),
                      icon: Icon(Icons.add, color: AppColors.kTextColor),
                      label: Text(
                        "My List",
                        style: TextStyle(color: AppColors.kTextColor),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.white24),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 10,
                        ),
                        foregroundColor: AppColors.kTextColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

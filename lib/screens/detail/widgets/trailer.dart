import 'package:flutter/material.dart';
import 'package:mova_app/utils/app_color.dart';
import 'package:url_launcher/url_launcher.dart';

class TrailerCard extends StatelessWidget {
  final String title;
  final String duration;
  final String trailerKey;

  const TrailerCard({
    Key? key,
    required this.title,
    required this.duration,
    required this.trailerKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final url = "https://www.youtube.com/watch?v=$trailerKey";
        if (await canLaunchUrl(Uri.parse(url))) {
          await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Trailer not available")),
          );
        }
      },
      child: Row(
        children: [
          Container(
            width: 110,
            height: 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: const DecorationImage(
                image: NetworkImage('https://picsum.photos/seed/trailer/300/200'),
                fit: BoxFit.cover,
              ),
            ),
            child: const Center(
              child: Icon(Icons.play_circle_fill, size: 40, color: Colors.white),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.kTextColor,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  duration,
                  style: const TextStyle(color: Colors.white54, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PremiumCard extends StatelessWidget {
  final VoidCallback onTap;
  const PremiumCard({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    const netflixRed = Color(0xFFE21220);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: netflixRed, width: 2),
          borderRadius: BorderRadius.circular(24),
          color: Colors.transparent,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
        child: Row(
          children: [
            const FaIcon(FontAwesomeIcons.crown,
                color: netflixRed, size: 30),
            const SizedBox(width: 15),

            // Text
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Join Premium!",
                    style: TextStyle(
                      color: Color.fromARGB(255, 225, 27, 40),
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Enjoy watching Full-HD movies, without restrictions and without ads",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 13,
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),

            const Icon(Icons.arrow_forward_ios, color: Color.fromARGB(255, 225, 27, 40), size: 18),
          ],
        ),
      ),
    );
  }
}
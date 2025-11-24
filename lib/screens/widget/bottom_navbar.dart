import 'package:flutter/material.dart';

class MovaBottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const MovaBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: const Color(0xFF2B2B2B),
      currentIndex: currentIndex,
      onTap: onTap,
      selectedItemColor: const Color(0xFFE21220),
      unselectedItemColor: Colors.white70,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.movie_outlined),
          label: "Movies",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bookmark_outline),
          label: "Saved",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: "Profile",
        ),
      ],
    );
  }
}

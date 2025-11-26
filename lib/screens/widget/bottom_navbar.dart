import 'package:flutter/material.dart';
import 'package:mova_app/utils/app_color.dart';

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
      backgroundColor: AppColors.kPrimary,
      currentIndex: currentIndex,
      onTap: onTap,
      selectedItemColor: AppColors.kSecondary,
      unselectedItemColor: Colors.white70,
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.explore_outlined),
          label: "Explore",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bookmark_outline),
          label: "My List",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: "Profile",
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:mova_app/utils/app_color.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const SectionHeader({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: const TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.kTextColor)),
          GestureDetector(
            onTap: onTap,
            child: const Text(
              "See all",
              style: TextStyle(color: AppColors.kSecondary),
            ),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:mova_app/utils/app_color.dart';

class FilterButton extends StatelessWidget {
  const FilterButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.kPrimary,
        borderRadius: BorderRadius.circular(10),
      ),
      child: IconButton(
        icon: Icon(Icons.filter_list_rounded, color: AppColors.kSecondary),
        onPressed: () {},
      ),
    );
  }
}
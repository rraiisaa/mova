import 'package:flutter/material.dart';
import 'package:mova_app/utils/app_color.dart';

class FilterChipItem extends StatelessWidget {
  final String text;
  final bool selected;
  final VoidCallback onTap;

  const FilterChipItem({
    Key? key,
    required this.text,
    required this.selected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
  duration: Duration(milliseconds: 160),
  padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
  margin: EdgeInsets.only(right: 10, bottom: 10),
  decoration: BoxDecoration(
    color: selected ? AppColors.kSecondary : Colors.transparent,
    borderRadius: BorderRadius.circular(20),
    border: Border.all(
      color: selected ? Colors.transparent : AppColors.kSecondary,
      width: 1,
    ),
  ),
  child: Text(
    text,
    style: TextStyle(
      color: selected ? AppColors.kTextColor : AppColors.kSecondary,
      fontWeight: FontWeight.w600,
      fontSize: 14,
    ),
  ),
)

    );
  }
}

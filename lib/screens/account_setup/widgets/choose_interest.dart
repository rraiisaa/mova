import 'package:flutter/material.dart';
import 'package:mova_app/routes/app_pages.dart';
import 'package:mova_app/utils/app_color.dart';

class InterestChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  static String routeName = Routes.CHOOSE_INTEREST;

  const InterestChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.kSecondary : Colors.transparent, 
          border: Border.all(
            color: isSelected ? Colors.transparent : AppColors.kSecondary,
          ),
          borderRadius: BorderRadius.circular(60),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? AppColors.kTextColor : AppColors.kSecondary, 
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class ActionButtons extends StatelessWidget {
  final VoidCallback onSkip;
  final VoidCallback onContinue;

  const ActionButtons({super.key, required this.onSkip, required this.onContinue});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // skip button
        Expanded(
          child: TextButton(
            onPressed: onSkip,
            style: TextButton.styleFrom(
              backgroundColor: AppColors.kAdded,
              padding: EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(45)
              ),
            ),
            child: Text(
              'Skip',
              style: TextStyle(fontSize: 14, color: AppColors.kTextColor, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        SizedBox(width: 15),
        
        // continue button
        Expanded(
          child: ElevatedButton(
            onPressed: onContinue,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.kSecondary,
              padding: EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(45),
              ),
            ),
            child: Text(
              'Continue',
              style: TextStyle(fontSize: 14, color: AppColors.kTextColor, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ],
    );
  }
}
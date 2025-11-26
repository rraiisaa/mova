import 'package:flutter/material.dart';
import 'package:mova_app/utils/app_color.dart';

class IconCircle extends StatelessWidget {
  final IconData icon;
  const IconCircle({Key? key, required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.black45, shape: BoxShape.circle),
      padding: const EdgeInsets.all(8),
      child: Icon(icon, color: AppColors.kTextColor),
    );
  }
}
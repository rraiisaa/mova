import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SocialButton extends StatelessWidget {
  final String iconPath;

  const SocialButton({super.key, required this.iconPath});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 65,
      height: 65,
      decoration: BoxDecoration(
        color:   Color.fromARGB(255, 55, 55, 55),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: SvgPicture.asset(
          iconPath,
          width: 35,
          height: 35,
        ),
      ),
    );
  }
}
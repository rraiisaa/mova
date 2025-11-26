import 'package:flutter/material.dart';
import 'dart:math';

import 'package:mova_app/utils/app_color.dart';

class CustomLoader extends StatefulWidget {
  const CustomLoader({super.key});

  @override
  _CustomLoaderState createState() => _CustomLoaderState();
}

class _CustomLoaderState extends State<CustomLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _rotationController;

  @override
  void initState() {
    super.initState();

    _rotationController = AnimationController(
      duration: Duration(milliseconds: 1200),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(         
      width: 30,
      height: 20,
      child: AnimatedBuilder(
        animation: _rotationController,
        builder: (_, child) {
          return Transform.rotate(
            angle: _rotationController.value * 2 * pi,
            child: child,
          );
        },
        child: Stack(
          alignment: Alignment.center,   
          children: List.generate(8, (i) {
            final angle = (2 * pi / 8) * i;

            return Transform.translate(
              offset: Offset(
                20 * cos(angle),
                20 * sin(angle),
              ),
              child: Container(
                width: 15,
                height: 10,
                decoration: BoxDecoration(
                  color: AppColors.kSecondary,
                  shape: BoxShape.circle,
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
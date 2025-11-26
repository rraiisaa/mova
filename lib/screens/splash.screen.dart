import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:mova_app/routes/app_pages.dart';
import 'package:mova_app/screens/widget/custom_loader.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Animasi Logo
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _scaleAnimation = Tween<double>(begin: 0.7, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _controller.forward();

    // ➜ Auto Pindah ke Onboarding
    Future.delayed(Duration(seconds: 5), () {
        Get.offAllNamed(Routes.ONBOARDING); 
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121216),
      body: SafeArea(
        child: Column(
          children: [
            // LOGO ANIMASI
            Expanded(
              child: Center(
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: ScaleTransition(
                    scale: _scaleAnimation,
                    child: Image.asset(
                      'assets/images/logo.png',
                      width: 200,
                      height: 200,
                    ),
                  ),
                ),
              ),
            ),

            // LOADER — Sudah center & posisi bawah aman
            Padding(
              padding: const EdgeInsets.only(bottom: 60),
              child: Center(
                child: SizedBox(
                  width: 40,
                  height: 40,
                  child: const CustomLoader(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
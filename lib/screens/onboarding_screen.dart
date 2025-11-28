import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:mova_app/routes/app_pages.dart';
import 'package:mova_app/utils/app_color.dart';
import '../animations/floating_background.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _textController = PageController();
  int _currentIndex = 0;

  final List<Map<String, String>> contents = [
    {
      "title": "Welcome to Mova",
      "subtitle":
          "The best movie streaming app of the century\nto make your days great!",
    },
    {
      "title": "Unlimited Movies",
      "subtitle": "Watch anytime, anywhere.\nEnjoy your favorite films!",
    },
    {
      "title": "Cinema Experience",
      "subtitle": "Feel the cinematic vibe on your device.\nLet’s begin!",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// BACKGROUND FIX — pakai IgnorePointer supaya gesture tidak tertahan
          Container(
            color: AppColors.kPrimary,
            child: SafeArea(
              child: IgnorePointer(
                child: FloatingVertical(
                  images: [
                    [
                      "assets/images/img1.png",
                      "assets/images/img2.png",
                      "assets/images/img3.png",
                      "assets/images/img4.png",
                      "assets/images/img13.png",
                      "assets/images/img18.png",
                    ],
                    [
                      "assets/images/img5.png",
                      "assets/images/img6.png",
                      "assets/images/img7.png",
                      "assets/images/img8.png",
                      "assets/images/img14.png",
                      "assets/images/img16.png",
                    ],
                    [
                      "assets/images/img9.png",
                      "assets/images/img10.png",
                      "assets/images/img11.png",
                      "assets/images/img12.png",
                      "assets/images/img15.png",
                      "assets/images/img17.png",
                    ],
                  ],
                ),
              ),
            ),
          ),

          /// GRADIENT BAWAH
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 380,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    AppColors.kPrimary,
                    AppColors.kPrimary,
                  ],
                ),
              ),
            ),
          ),

          /// TEXT PAGE SLIDER (SEKARANG BISA DIGESER)
          PageView.builder(
            controller: _textController,
            itemCount: contents.length,
            onPageChanged: (i) => setState(() => _currentIndex = i),
            itemBuilder: (_, index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const SizedBox(height: 120),
                  Text(
                    contents[index]["title"]!,
                    style: const TextStyle(
                      fontSize: 28,
                      color: AppColors.kTextColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    contents[index]["subtitle"]!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white70, fontSize: 15),
                  ),
                  const SizedBox(height: 160),
                ],
              );
            },
          ),

          /// DOT INDICATOR
          Positioned(
            bottom: 130,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(contents.length, (index) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  height: 10,
                  width: _currentIndex == index ? 25 : 10,
                  decoration: BoxDecoration(
                    color: _currentIndex == index
                        ? AppColors.kSecondary
                        : Colors.white38,
                    borderRadius: BorderRadius.circular(20),
                  ),
                );
              }),
            ),
          ),

          /// BUTTON GET STARTED
          /// BUTTON GET STARTED
          Positioned(
            bottom: 30,
            left: 25,
            right: 25,
            child: InkWell(
              onTap: () {
                Get.offAllNamed(Routes.YOUIN); // GANTI route sesuai kebutuhan
              },
              child: Container(
                height: 45,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.kSecondary,
                  borderRadius: BorderRadius.circular(35),
                ),
                child: const Center(
                  child: Text(
                    "Get Started",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

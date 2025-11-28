import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mova_app/routes/app_pages.dart';
import 'package:mova_app/utils/app_color.dart';

class ChoiceScreen extends StatelessWidget {
  const ChoiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kPrimary,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                SizedBox(height: 20),

                /// BACK BUTTON
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                  ),
                ),

                SizedBox(height: 20),

                /// IMAGE
                Image.asset(
                  "assets/images/logo.png", // Ganti sesuai dengan path asset kamu
                  width: 200,
                ),

                SizedBox(height: 25),

                Text(
                  "Let’s you in",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 35),

                /// CONTINUE FACEBOOK
                socialButton(
                  iconPath: "assets/icons/facebook.svg",
                  text: "Continue with Facebook",
                ),

                SizedBox(height: 15),

                /// CONTINUE GOOGLE
                socialButton(
                  iconPath: "assets/icons/google.svg",
                  text: "Continue with Google",
                ),

                SizedBox(height: 15),

                /// CONTINUE APPLE
                socialButton(
                  iconPath: "assets/icons/apple.svg",
                  text: "Continue with Apple",
                ),

                SizedBox(height: 25),

                /// DIVIDER
                Row(
                  children: [
                    Expanded(child: Divider(color: Colors.white24)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        "or",
                        style: TextStyle(color: Colors.white70),
                      ),
                    ),
                    Expanded(child: Divider(color: Colors.white24)),
                  ],
                ),

                SizedBox(height: 25),

                /// SIGN IN WITH PASSWORD BUTTON
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.kSecondary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(35),
                      ),
                    ),
                    onPressed: () {
                      Get.offAllNamed(
                        Routes.LOGIN,
                      ); // GANTI route sesuai kebutuhan
                    },
                    child: Text(
                      "Sign in with password",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 25),

                /// SIGN UP LINK
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: TextStyle(color: Colors.white70),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.offAllNamed(
                          Routes.REGISTER,
                        ); // GANTI route sesuai kebutuhan
                      },
                      child: Text(
                        "Sign up",
                        style: TextStyle(
                          color: AppColors.kSecondary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// SOCIAL BUTTON RE-USABLE WIDGET
  Widget socialButton({required String iconPath, required String text}) {
    return Container(
      height: 55,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white24),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(iconPath, width: 27),
          SizedBox(width: 30),
          Text(
            text,
            style: TextStyle(color: AppColors.kTextColor, fontSize: 16),
          ),
        ],
      ),
    );
  }
}

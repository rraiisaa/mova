import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mova_app/auth/auth_services.dart';
import 'package:mova_app/auth/widgets/custom_text_fields.dart';
import 'package:mova_app/auth/widgets/social_button.dart';
import 'package:mova_app/routes/app_pages.dart';
import 'package:mova_app/screens/widgets/custom_loader.dart';
import 'package:mova_app/utils/app_color.dart';

class LoginScreen extends StatefulWidget {
  final VoidCallback onRegisterTap;

  const LoginScreen({super.key, required this.onRegisterTap});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool rememberMe = false;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _authService = AuthServices();
  bool _isLoading = false;
  bool _obscurePassword = true;

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      await _authService.signInWithEmailAndPassword(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );

      // NAVIGASI JIKA SUKSES
      if (mounted) Get.offAllNamed(Routes.HOME);

    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            backgroundColor: AppColors.kSecondary,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kPrimary,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24),

          // FIX: Form ditambahkan (UI TIDAK berubah)
          child: Form(
            key: _formKey,

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 40),
                
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                  ),
                ),
                SizedBox(height: 10),

                Image.asset("assets/images/logo.png", width: 120, height: 120),

                SizedBox(height: 30),

                Text(
                  "Login To Your Account",
                  style: TextStyle(
                    color: AppColors.kTextColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),

                SizedBox(height: 30),

                CustomTextField(
                  controller: _emailController,
                  label: 'Email',
                  hint: 'Enter your Email',
                  isPassword: false,
                  icon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) =>
                      value?.isEmpty ?? true ? 'Please enter your email' : null,
                ),

                SizedBox(height: 20),

                CustomTextField(
                  controller: _passwordController,
                  label: 'Password',
                  hint: 'Enter your Password',
                  icon: Icons.lock_outlined,
                  isPassword: _obscurePassword,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: Colors.white70,
                    ),
                    onPressed: () =>
                        setState(() => _obscurePassword = !_obscurePassword),
                  ),
                  validator: (value) =>
                      value?.isEmpty ?? true ? 'Please enter your password' : null,
                ),

                SizedBox(height: 30),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => setState(() => rememberMe = !rememberMe),
                      child: Icon(
                        rememberMe
                            ? Icons.check_box
                            : Icons.check_box_outline_blank,
                        color: Colors.red,
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Remember Me",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 40),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _login,   // ← FIX DI SINI
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ),
                    child: _isLoading
                        ? CustomLoader()
                        : Text(
                            "Sign in",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                ),

                SizedBox(height: 20),

                GestureDetector(
                  onTap: () {
                    Get.offAllNamed(Routes.HOME);
                  },
                  child: Text(
                    "Forgot The Password?",
                    style: TextStyle(
                      color: AppColors.kSecondary,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),

                SizedBox(height: 30),

                Row(
                  children: [
                    Expanded(child: Divider(color: Colors.grey)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        "or continue with",
                        style: TextStyle(color: Colors.white54),
                      ),
                    ),
                    Expanded(child: Divider(color: Colors.grey)),
                  ],
                ),

                SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SocialButton(iconPath: "assets/icons/facebook.svg"),
                    SizedBox(width: 20),
                    SocialButton(iconPath: "assets/icons/google.svg"),
                    SizedBox(width: 20),
                    SocialButton(iconPath: "assets/icons/apple.svg"),
                  ],
                ),

                SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an Account?",
                      style: TextStyle(color: AppColors.kTextColor),
                    ),
                    SizedBox(width: 5),
                    GestureDetector(
                      onTap: widget.onRegisterTap,
                      child: Text(
                        "Sign Up",
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
}

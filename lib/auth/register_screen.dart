import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mova_app/auth/auth_services.dart';
import 'package:mova_app/auth/widgets/custom_text_fields.dart';
import 'package:mova_app/auth/widgets/social_button.dart';
import 'package:mova_app/routes/app_pages.dart';
import 'package:mova_app/screens/widgets/custom_loader.dart';
import 'package:mova_app/utils/app_color.dart';

class RegisterScreen extends StatefulWidget {
  final VoidCallback onLoginTap;

  const RegisterScreen({super.key, required this.onLoginTap});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _obscureConfirm = true;

  final _authService = AuthServices();

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;
    setState(
      () => _isLoading = true,
    ); // jika dia sudah memvalidasi, dia akan loading

    try {
      // try = dijalankan kalo berhasil
      await _authService.registerWithEmailAndPassword(
        _emailController.text
            .trim(), // trim() = menghilangkan spasi di awal dan akhir
        _passwordController.text.trim(),
      );
    } catch (e) {
      // catch = dijalankan kalo ada error
      if (mounted) {
        // mounted = properti boolean untuk cek apakah widget masih ada di struktur widget di flutter atau ga
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            backgroundColor: AppColors.kSecondary,
          ),
        );
      }
    } finally {
      // finally = dijalankan setelah try atau catch selesai
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kPrimary,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),

          // FIX: Form ditambahkan (UI tidak berubah)
          child: Form(
            key: _formKey,

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 40),

                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                  ),
                ),

                const SizedBox(height: 10),

                Image.asset("assets/images/logo.png", width: 120, height: 120),

                const SizedBox(height: 30),

                const Text(
                  "Create Your Account",
                  style: TextStyle(
                    color: AppColors.kTextColor,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 30),

                CustomTextField(
                  controller: _nameController,
                  label: 'Full Name',
                  hint: 'Enter your Full Name',
                  icon: Icons.person_outlined,
                  validator: (value) =>
                      value!.isEmpty ? "Please enter your full name" : null,
                ),

                const SizedBox(height: 20),

                CustomTextField(
                  controller: _emailController,
                  label: 'Email',
                  hint: 'Enter your Email',
                  icon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) =>
                      value!.isEmpty ? "Please enter your email" : null,
                ),

                const SizedBox(height: 20),

                CustomTextField(
                  controller: _passwordController,
                  label: 'Password',
                  hint: 'Enter your Password',
                  icon: Icons.lock_outline,
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
                      value!.isEmpty ? "Please enter a password" : null,
                ),

                const SizedBox(height: 20),

                CustomTextField(
                  controller: _confirmPasswordController,
                  label: 'Confirm Password',
                  hint: 'Re-enter your Password',
                  icon: Icons.lock_outline,
                  isPassword: _obscureConfirm,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureConfirm
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: Colors.white70,
                    ),
                    onPressed: () =>
                        setState(() => _obscureConfirm = !_obscureConfirm),
                  ),
                  validator: (value) =>
                      value!.isEmpty ? "Please confirm your password" : null,
                ),

                const SizedBox(height: 40),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isLoading
                        ? null
                        : () async {
                            await _register();
                            if (!mounted) return;
                            Get.offAllNamed(Routes.CHOOSE_INTEREST);
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.kSecondary,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(40)),
                      ),
                      elevation: 4,
                    ),
                    child: _isLoading
                        ? SizedBox(
                            height: 10,
                            width: 10,
                            child: CustomLoader(),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Register",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                  ),
                ),

                const SizedBox(height: 20),

                Row(
                  children: const [
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

                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SocialButton(iconPath: "assets/icons/facebook.svg"),
                    const SizedBox(width: 20),
                    SocialButton(iconPath: "assets/icons/google.svg"),
                    const SizedBox(width: 20),
                    SocialButton(iconPath: "assets/icons/apple.svg"),
                  ],
                ),

                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an Account?",
                      style: TextStyle(color: Colors.white),
                    ),
                    const SizedBox(width: 5),
                    GestureDetector(
                      onTap: widget.onLoginTap,
                      child: const Text(
                        "Sign In",
                        style: TextStyle(
                          color: AppColors.kSecondary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

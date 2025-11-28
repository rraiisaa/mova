import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mova_app/auth/choice_auth_screen.dart';
import 'package:mova_app/auth/register_screen.dart';
import 'package:mova_app/auth/login_screen.dart';

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  bool _showLogin = true;

  void _toggleView() {
    setState(() {
      _showLogin = !_showLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) { // snapshot = ketika aplikasi kita punya data dari 3rd party (data autentifikasi)
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (snapshot.hasData) {
          return ChoiceScreen();
        }
        return _showLogin ? LoginScreen(onRegisterTap: _toggleView) : RegisterScreen(onLoginTap: _toggleView);
      },
    );
  }
}
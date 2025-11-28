import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mova_app/l10n/app_localizations.dart';
import 'package:mova_app/routes/app_pages.dart';
import 'package:mova_app/utils/app_color.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyBT-i9DJ8088xKLI7c4whJhuFQQNE1AKMA",
      appId: "1:605150603894:android:36feb8b6ac6a799b3c8d57",
      messagingSenderId: "605150603894",
      projectId: "mova-31bbd",
    ),
  );
  runApp(const MovieApp());
}

class MovieApp extends StatefulWidget {
  const MovieApp({super.key});

  static _MovieAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<_MovieAppState>();

  static void setLocale(BuildContext context, Locale newLocale) {
    of(context)?._setLocale(newLocale);
  }

  @override
  State<MovieApp> createState() => _MovieAppState();
}

class _MovieAppState extends State<MovieApp> {
  Locale _locale = const Locale('id');

  Locale get currentLocale => _locale;

  void _setLocale(Locale locale) {
    setState(() => _locale = locale);
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      locale: _locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: AppColors.kPrimary,
        textTheme: ThemeData.dark().textTheme.apply(
          bodyColor: AppColors.kTextColor,
          displayColor: AppColors.kTextColor,
        ),
        colorScheme: const ColorScheme.dark().copyWith(
          primary: AppColors.kSecondary,
        ),
      ),
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    );
  }
}

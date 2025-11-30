import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mova_app/controllers/my_list_controller.dart';
import 'package:mova_app/l10n/app_localizations.dart';
import 'package:mova_app/provider/download_provider.dart';
import 'package:mova_app/routes/app_pages.dart';
import 'package:mova_app/utils/app_color.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyDk_XHE99-gFL3oeg9Zv8GOIotRtdh158Y",
      appId: "1:573455585666:android:20b2d19d72ef1d0a2c3f9b",
      messagingSenderId: "573455585666",
      projectId: "mova-app-32cef",
    ),
  );

  // Daftar controller supaya bisa dipanggil kapanpun
  // Fenix = jika controller pernah dihapus, GetX akan membuatnya ulang otomatis saat ada Get.find() dipanggil.
  Get.lazyPut(() => MyListController(), fenix: true); 
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DownloadProvider()),
        // tambahkan provider lain kalau nanti ada
      ],
      
      child: MovieApp(),
    ),
  );
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
        colorScheme: ColorScheme.dark().copyWith(primary: AppColors.kSecondary),
      ),
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    );
  }
  
}

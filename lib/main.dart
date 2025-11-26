import 'package:flutter/material.dart';
import 'package:get/get.dart'; 
import 'package:mova_app/routes/app_pages.dart';
import 'package:mova_app/screens/home/home_screen.dart';
import 'package:mova_app/utils/app_color.dart';

void main() {
  runApp(const MovaApp());
}

class MovaApp extends StatelessWidget {
  const MovaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mova',
      // theme: ThemeData(
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
      //   useMaterial3: true,
      // ),

      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,   
    );
  }
}

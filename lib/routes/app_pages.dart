import 'package:flutter/material.dart';
import 'package:mova_app/screens/detail/detail_screen.dart';
import 'package:mova_app/screens/home/home_screen.dart';
import 'package:mova_app/screens/popular/popular_screen.dart';
import 'app_routes.dart';

class AppPages {
  static Map<String, WidgetBuilder> routes = {
    AppRoutes.home: (_) => HomeScreen(),
    AppRoutes.details: (_) => MovieDetailsScreen(),
    AppRoutes.popular: (_) => PopularScreen(movies: []),
  };
}

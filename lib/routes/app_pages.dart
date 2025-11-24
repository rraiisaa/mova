import 'package:flutter/material.dart';
import 'package:mova_app/screens/home/home_screen.dart';
import 'package:mova_app/screens/popular/popular_screen.dart';

import 'app_routes.dart';

class AppPages {
  static Map<String, WidgetBuilder> routes = {
    AppRoutes.home: (_) => const Home(),
    // AppRoutes.top10: (_) => const Top10Screen(),
    AppRoutes.popular: (_) => PopularScreen(movies: []),
  };
}

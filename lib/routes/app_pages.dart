import 'package:get/get.dart';
import 'package:mova_app/screens/detail/detail_screen.dart';
import 'package:mova_app/screens/home/home_screen.dart';
import 'package:mova_app/screens/popular/popular_screen.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  // INITIAL = screen pertama yang muncul saat apliaksi dibuka
  static const INITIAL = Routes.MOVIE_DETAIL;

   static final routes  = [
    // GetPage(
    //   name: _Paths.SPLASH,
    //   page: () => SplashScreen()
    // ),
    // GetPage(
    //   name: _Paths.HOME,
    //   page: () => HomeScreen(),
    // ),
    GetPage(
      name: _Paths.MOVIE_DETAIL,
      page: () => MovieDetailsScreen(),
    ),
   ];
}

// GetPage(
//       name: _Paths.MOVIE_DETAIL,
//       page: () => MovieDetailsScreen(movie: Get.arguments),
//     ),
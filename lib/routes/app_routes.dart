part of 'app_pages.dart';

abstract class Routes {
  Routes._();

  static const SPLASH = _Paths.SPLASH;
  static const ONBOARDING = _Paths.ONBOARDING;
  static const HOME = _Paths.HOME;
  static const MOVIE_DETAIL = _Paths.MOVIE_DETAIL;
  static const EXPLORE = _Paths.EXPLORE;
}

// pendeklarasian routes dari masing masing screen
abstract class _Paths {
  _Paths._();
  static const SPLASH = '/splash';
  static const ONBOARDING = '/onboarding';
  static const HOME = '/home';
  static const MOVIE_DETAIL = '/movie-detail';
  static const EXPLORE = '/explore';
  }
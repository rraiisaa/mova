part of 'app_pages.dart';

abstract class Routes {
  Routes._();

  static const SPLASH = _Paths.SPLASH;
  static const HOME = _Paths.HOME;
  static const MOVIE_DETAIL = _Paths.MOVIE_DETAIL;
}

// pendeklarasian routes dari masing masing screen
abstract class _Paths {
  _Paths._();
  static const SPLASH = '/splash';
  static const HOME = '/home';
  static const MOVIE_DETAIL = '/movie-detail';
}
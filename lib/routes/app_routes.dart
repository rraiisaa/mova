part of 'app_pages.dart';

abstract class Routes {
  Routes._();

  static const SPLASH = _Paths.SPLASH;
  static const YOUIN = _Paths.YOUIN;
  static const LOGIN = _Paths.LOGIN;
  static const REGISTER = _Paths.REGISTER;
  static const ONBOARDING = _Paths.ONBOARDING;
  static const PROFILE_FORM = _Paths.PROFILE_FORM;
  static const CREATE_PIN = _Paths.CREATE_PIN;
  static const CHOOSE_INTEREST = _Paths.CHOOSE_INTEREST;
  static const HOME = _Paths.HOME;
  static const MOVIE_DETAIL = _Paths.MOVIE_DETAIL;
  static const EXPLORE = _Paths.EXPLORE;
  static const MYLIST = _Paths.MYLIST;
  static const DOWNLOAD = _Paths.DOWNLOAD;
  static const PROFILE = _Paths.PROFILE;
  static const PREMIUM = _Paths.PREMIUM;
  static const LANGUAGE_SETTING = _Paths.LANGUAGE_SETTING;
  static const EDIT_PROFILE = _Paths.EDIT_PROFILE;
}

// pendeklarasian routes dari masing masing screen
abstract class _Paths {
  _Paths._();
  static const SPLASH = '/splash';
  static const YOUIN = '/you-in';
  static const LOGIN = '/login';
  static const REGISTER = '/register';
  static const ONBOARDING = '/onboarding';
  static const PROFILE_FORM = '/profile-form';
  static const CREATE_PIN = '/create-pin';
  static const CHOOSE_INTEREST = '/choose-interest';
  static const HOME = '/home';
  static const MOVIE_DETAIL = '/movie-detail';
  static const EXPLORE = '/explore';
  static const MYLIST = '/mylist';
  static const DOWNLOAD = '/download';
  static const PROFILE = '/profile';
  static const PREMIUM = '/premium';
  static const LANGUAGE_SETTING = '/language-setting';
  static const EDIT_PROFILE = '/edit-profile';
}
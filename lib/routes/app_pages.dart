import 'dart:ui';

import 'package:get/get.dart';
import 'package:mova_app/auth/choice_auth_screen.dart';
import 'package:mova_app/auth/register_screen.dart';
import 'package:mova_app/auth/login_screen.dart';
import 'package:mova_app/screens/premium/premium_screen.dart';
import 'package:mova_app/screens/account_setup/choose_interest_screen.dart';
import 'package:mova_app/screens/account_setup/create_pin_screen.dart';
import 'package:mova_app/screens/account_setup/profile_form_screen.dart';
import 'package:mova_app/screens/detail/detail_screen.dart';
import 'package:mova_app/screens/explore/explore_screen.dart';
import 'package:mova_app/screens/home/home_screen.dart';
import 'package:mova_app/screens/onboarding_screen.dart';
import 'package:mova_app/screens/profile/edit_profile_screen.dart';
import 'package:mova_app/screens/profile/language_setting_screen.dart';
import 'package:mova_app/screens/profile/profile_screen.dart';
import 'package:mova_app/screens/splash.screen.dart';

part 'app_routes.dart';

class AppPages {
  // AppPages._();

  // INITIAL = screen pertama yang muncul saat apliaksi dibuka
  static const INITIAL = Routes.SPLASH;

   static final routes  = [
    GetPage(
      name: _Paths.SPLASH,
      page: () => SplashScreen()
    ),
    GetPage(
      name: _Paths.YOUIN,
      page: () => ChoiceScreen()
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginScreen(onRegisterTap: () { Get.offAllNamed(Routes.REGISTER); })
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => RegisterScreen(onLoginTap: () { Get.offAllNamed(Routes.LOGIN); })
    ),
    GetPage(
      name: _Paths.ONBOARDING,
      page: () => OnboardingScreen()
    ),
    GetPage(
      name: _Paths.PROFILE_FORM,
      page: () => ProfileFormScreen()
    ),
    GetPage(
      name: _Paths.CREATE_PIN,
      page: () => CreatePinScreen()
    ),
    GetPage(
      name: _Paths.CHOOSE_INTEREST,
      page: () => ChooseInterestScreen()
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => HomeScreen(),
    ),
    GetPage(
      name: _Paths.MOVIE_DETAIL,
      page: () => MovieDetailsScreen(movie: Get.arguments),
    ),
    GetPage(
      name: _Paths.EXPLORE,
      page: () => ExploreScreen(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileScreen(),
    ),
    GetPage(
      name: _Paths.PREMIUM,
      page: () => PremiumScreen(),
    ),
    GetPage(
      name: _Paths.LANGUAGE_SETTING,
      page: () => LanguageSettingsScreen(),
    ),
    GetPage(
      name: _Paths.EDIT_PROFILE,
      page: () => EditProfileScreen(locale: Get.locale ?? const Locale('en')),
    ),
   ];
}
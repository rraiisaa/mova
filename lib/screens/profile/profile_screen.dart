import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:mova_app/l10n/app_localizations.dart';
import 'package:mova_app/main.dart';
import 'package:mova_app/routes/app_pages.dart';
import 'package:mova_app/screens/account_setup/widgets/profile.dart';
import 'package:mova_app/screens/premium/premium_screen.dart';
import 'package:mova_app/screens/profile/edit_profile_screen.dart';
import 'package:mova_app/screens/profile/language_setting_screen.dart';
import 'package:mova_app/screens/profile/widgets/premium_card.dart';
import 'package:mova_app/screens/profile/widgets/settings_switch_tile.dart';
import 'package:mova_app/screens/widgets/bottom_navbar.dart';
import 'package:mova_app/utils/app_color.dart';
import 'widgets/settings_tile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Locale? _selectedLocale;
  bool darkMode = true;
  int _selectedIndex = 3;

  @override
  void initState() {
    super.initState();
    _selectedLocale = MovieApp.of(context)?.currentLocale;
  }

  String _getLocaleName(Locale? locale) {
    switch (locale?.languageCode) {
      case 'en':
        return 'English (US)';
      case 'es':
        return 'Spanish';
      case 'id':
        return 'Indonesia';
      default:
        return 'Unknown';
    }
  }

  void _showLogoutSheet(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return DraggableScrollableSheet(
          initialChildSize: 0.32,
          minChildSize: 0.28,
          maxChildSize: 0.50,
          builder: (context, controller) {
            return Container(
              decoration: const BoxDecoration(
                color: Color(0xFF191A1F),
                borderRadius: BorderRadius.vertical(top: Radius.circular(26)),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 18),
              child: Column(
                children: [
                  Center(
                    child: Container(
                      height: 5,
                      width: 45,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  Text(
                    t.logout,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  const SizedBox(height: 14),

                  Text(
                    t.logoutConfirm,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                      height: 1.4,
                    ),
                  ),

                  const SizedBox(height: 28),

                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            decoration: BoxDecoration(
                              color: Colors.white12,
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Center(
                              child: Text(
                                t.cancel,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            decoration: BoxDecoration(
                              color: Color(0xFFE21220),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Center(
                              child: Text(
                                t.yesLogout,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.kPrimary,
      bottomNavigationBar: MovaBottomNav(
        currentIndex: _selectedIndex,
        onTap: (i) {
          setState(() => _selectedIndex = i);
          // tambahkan navigasi
          if (i == 0) {
          Navigator.pushReplacementNamed(context, Routes.HOME);
          } else if (i == 1) {
            Navigator.pushReplacementNamed(context, Routes.EXPLORE);
          } else if (i == 2) {
            // Navigator.pushReplacementNamed(context, Routes.SAVED);
          } else if (i == 3) {
            ;
          }
        },
      ),
      appBar: AppBar(
        backgroundColor: AppColors.kPrimary,
        elevation: 0,
        leading: const Padding(
          padding: EdgeInsets.only(left: 20),
          child: Text(
            "M",
            style: TextStyle(
              color: AppColors.kSecondary,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(
          t.profile,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: AppColors.kTextColor,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 30),

            Stack(
              children: [
                const ProfilePictureArea(),
               
              ],
            ),

            const SizedBox(height: 18),

            const Text(
              "Andrew Ainsley",
              style: TextStyle(
                color: AppColors.kTextColor,
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 4),

            const Text(
              "andrew_ainsley@yourdomain.com",
              style: TextStyle(color: Colors.white70, fontSize: 14),
            ),

            const SizedBox(height: 30),

            PremiumCard(
              onTap: () {
                Get.offAllNamed(Routes.PREMIUM); // Navigate ke Premium
              },
            ),

            const SizedBox(height: 30),

            // 🔥 Semua udah pakai Localization
            SettingsTile(
              icon: FontAwesomeIcons.user,
              title: t.editProfile,
              // onTap: () {
              //   // TODO : Ganti ke Get.toNamed ketika route udah siap
              //   Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (_) => EditProfileScreen(
              //         locale: MovieApp.of(context)!.currentLocale,
              //       ),
              //     ),
              //   );
              // },
              onTap: () {
                Get.offAllNamed(Routes.EDIT_PROFILE); // Navigate ke Premium
              },
            ),
            SettingsTile(icon: FontAwesomeIcons.bell, title: t.notification),
            SettingsTile(icon: FontAwesomeIcons.download, title: t.download),
            SettingsTile(
              icon: FontAwesomeIcons.shieldHalved,
              title: t.security,
            ),
            SettingsTile(icon: FontAwesomeIcons.info, title: t.helpCenter),
            SettingsTile(
              icon: FontAwesomeIcons.notesMedical,
              title: t.privacyPolicy,
            ),

            SettingsTile(
              icon: FontAwesomeIcons.globe,
              title: t.language,
              trailingText: _getLocaleName(MovieApp.of(context)?.currentLocale),
              onTap: () async {
                final selected = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const LanguageSettingsScreen(),
                  ),
                );

                if (selected != null && selected is Locale) {
                  MovieApp.setLocale(context, selected);

                  setState(() {});
                }
              },
            ),

            SettingsSwitchTile(
              icon: FontAwesomeIcons.eye,
              title: t.darkMode,
              value: darkMode,
              onChanged: (v) => setState(() => darkMode = v),
            ),

            SettingsTile(
              icon: FontAwesomeIcons.rightFromBracket,
              title: t.logout,
              onTap: () => _showLogoutSheet(context),
            ),

            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}

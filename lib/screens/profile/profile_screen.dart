import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mova_app/premium/premium_screen.dart';
import 'package:mova_app/screens/profile/widgets/settings_switch_tile.dart';
import 'widgets/premium_card.dart';
import 'widgets/settings_tile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool darkMode = true;
  void _showLogoutSheet(BuildContext context) {
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // --- Drag indicator ---
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

                const Text(
                  'Logout',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                const SizedBox(height: 14),

                const Text(
                  'Are you sure you want to logout?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    height: 1.4,
                  ),
                ),

                const SizedBox(height: 28),

                // --- Buttons ---
                Row(
                  children: [
                    // CANCEL BUTTON
                    Expanded(
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          decoration: BoxDecoration(
                            color: Colors.white12,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: const Center(
                            child: Text(
                              "Cancel",
                              style: TextStyle(
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

                    // LOGOUT BUTTON
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          // Dummy only — ga logout beneran
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          decoration: BoxDecoration(
                            color: Color(0xFFE21220),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: const Center(
                            child: Text(
                              "Yes, Logout",
                              style: TextStyle(
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
    const bg = Color(0xFF0F0F0F);
    const netflixRed = Color(0xFFE21220);

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: bg,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20, ),
          child: Text(
            "M",
            style: const TextStyle(
              color: netflixRed,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: const Text(
          "Profile",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 30),

            // Avatar + edit icon
            Stack(
              children: [
                 CircleAvatar(
                  radius: 55,
                  backgroundImage: AssetImage("assets/profile.jpg"),
                ),
                Positioned(
                  bottom: 4,
                  right: 4,
                  child: Container(
                    height: 28,
                    width: 28,
                    decoration: const BoxDecoration(
                      color: netflixRed,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.edit, color: Colors.white, size: 16),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 18),

            const Text(
              "Andrew Ainsley",
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              "andrew_ainsley@yourdomain.com",
              style: TextStyle(
                color: Colors.white70,
                fontSize: 14,
              ),
            ),

            const SizedBox(height: 30),

            // Premium Card
            PremiumCard(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const PremiumScreen()),
              ),
            ),

            const SizedBox(height: 30),

            // Settings Sections
            SettingsTile(
              icon: FontAwesomeIcons.user,
              title: "Edit Profile",
              onTap: () {},
            ),
            SettingsTile(
              icon: FontAwesomeIcons.bell,
              title: "Notification",
            ),
            SettingsTile(
              icon: FontAwesomeIcons.download,
              title: "Download",
            ),
            SettingsTile(
              icon: FontAwesomeIcons.shieldHalved,
              title: "Security",
            ),
            SettingsTile(
              icon: FontAwesomeIcons.info,
              title: "Help Center",
            ),
            SettingsTile(
              icon: FontAwesomeIcons.notesMedical,
              title: "Privacy Policy",
            ),
            SettingsTile(
              icon: FontAwesomeIcons.globe,
              title: "Language",
              trailingText: "English (US)",
            ),
            SettingsSwitchTile(
              icon: FontAwesomeIcons.eye,
              title: "Dark Mode",
              value: darkMode,
              onChanged: (v) => setState(() => darkMode = v),
            ),
            SettingsTile(
            icon: FontAwesomeIcons.rightFromBracket,
            title: "Logout",
            onTap: () => _showLogoutSheet(context),
          ),


            const SizedBox(height: 80),
          ],
        ),
      ),
      
      
    );
  }
}
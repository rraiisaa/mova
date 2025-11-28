import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mova_app/l10n/app_localizations.dart';

class EditProfileScreen extends StatefulWidget {
  final Locale locale;
  const EditProfileScreen({super.key, required this.locale});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final fullNameCtrl = TextEditingController(text: "Andrew Ainsley");
  final nickNameCtrl = TextEditingController(text: "Andrew");
  final emailCtrl = TextEditingController(text: "andrew@domain.com");
  final phoneCtrl = TextEditingController(text: "+62 812 3456 7890");
  final ImagePicker picker = ImagePicker();

  String? profileImagePath;
  String selectedGender = "Male";
  String selectedCountry = "Indonesia";

  final List<String> countries = [
    "Indonesia",
    "Singapore",
    "Malaysia",
    "United States",
    "Japan",
    "Korea"
  ];

  Future<void> pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        profileImagePath = pickedFile.path;
      });
    }
  }

  Future<void> pickFormCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() => profileImagePath = pickedFile.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F0F0F),
        elevation: 0,
       title: Text(
  AppLocalizations.of(context)!.editProfile,
  style: const TextStyle(
    color: Colors.white,
    fontSize: 20,
    fontWeight: FontWeight.bold,
  ),
),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),

      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 28),

            /// AVATAR + CAMERA ICON UPGRADE
            Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.red.withOpacity(0.25),
                        blurRadius: 20,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child:  CircleAvatar(
                    radius: 57,
                    backgroundColor: Colors.black,
                    backgroundImage: profileImagePath != null
                              ? FileImage(File(profileImagePath!))
                              : AssetImage("assets/images/profile_user.jpg") 
                  ),
                ),
                Positioned(
                  bottom: 4,
                  right: 4,
                  child: GestureDetector(
                    onTap: pickImage,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      height: 32,
                      width: 32,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE21220),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.redAccent.withOpacity(.5),
                            blurRadius: 6,
                          )
                        ],
                      ),
                      child: const Icon(Icons.camera_alt,
                          color: Colors.white, size: 17),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 35),

            sectionTitle(AppLocalizations.of(context)!.personalInfo),

            const SizedBox(height: 10),
            buildField(AppLocalizations.of(context)!.fullName, fullNameCtrl),


            const SizedBox(height: 16),
            buildField(AppLocalizations.of(context)!.nickname, nickNameCtrl),

            const SizedBox(height: 16),
            fieldLabel(AppLocalizations.of(context)!.email),

            const SizedBox(height: 16),
            fieldLabel(AppLocalizations.of(context)!.phoneNumber),

            const SizedBox(height: 28),
            sectionTitle(AppLocalizations.of(context)!.preferences),

            fieldLabel(AppLocalizations.of(context)!.gender),

            Row(
              children: [
                genderRadio(AppLocalizations.of(context)!.male),
                const SizedBox(width: 12),
                genderRadio(AppLocalizations.of(context)!.female),
              ],
            ),

            const SizedBox(height: 18),
            fieldLabel(AppLocalizations.of(context)!.country),
            buildDropdown(),

            const SizedBox(height: 40),

            /// SAVE BUTTON UPGRADE
            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE21220),
                  elevation: 3,
                  shadowColor: Colors.redAccent.withOpacity(.4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  "Save",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 45),
          ],
        ),
      ),
    );
  }

  // TITLE SECTION
  Widget sectionTitle(String label) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        label,
        style: TextStyle(
          color: Colors.red.shade400,
          fontSize: 13,
          fontWeight: FontWeight.w600,
          letterSpacing: .5,
        ),
      ),
    );
  }

  // LABEL
  Widget fieldLabel(String label) => Text(
    
        label,
        style: const TextStyle(
          color: Colors.white70,
          
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      );

  /// ✨ TEXTFIELD POLISHED
  Widget buildField(String label, TextEditingController ctrl,
      {TextInputType keyboard = TextInputType.text}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        fieldLabel(label),
        const SizedBox(height: 6),
        TextField(
          controller: ctrl,
          style: const TextStyle(color: Colors.white),
          keyboardType: keyboard,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white12,
            hintStyle: TextStyle(color: Colors.white.withOpacity(.35)),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide:
                  const BorderSide(color: Color(0xFFE21220), width: 1.3),
            ),
          ),
        ),
      ],
    );
  }

  /// ✨ GENDER RADIO CARD (WITH ANIMATION)
 Widget genderRadio(String gender) {
  final isSelected = selectedGender == gender;

  return Expanded(
    child: GestureDetector(
      onTap: () => setState(() => selectedGender = gender),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        height: 52,
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFFE21220).withOpacity(.20)
              : Colors.white10,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? const Color(0xFFE21220) : Colors.transparent,
            width: 1.2,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.red.withOpacity(.35),
                    blurRadius: 12,
                  )
                ]
              : [],
        ),
        child: Center(
          child: Text(
            gender,
            style: TextStyle(
              color: isSelected ? Colors.redAccent : Colors.white70,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ),
      ),
    ),
  );
}


  /// ✨ DROPDOWN POLISHED
Widget buildDropdown() {
  return Container(
    height: 52,
    padding: const EdgeInsets.symmetric(horizontal: 14),
    decoration: BoxDecoration(
      color: Colors.white12,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.white24, width: 1),
    ),
    child: DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        dropdownColor: const Color(0xFF161616),
        value: selectedCountry,
        alignment: Alignment.centerLeft,
        icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white70),
        style: const TextStyle(color: Colors.white, fontSize: 14),
        items: countries.map((country) {
          return DropdownMenuItem(
            value: country,
            child: Text(country,
                style: const TextStyle(color: Colors.white)),
          );
        }).toList(),
        onChanged: (value) {
          setState(() => selectedCountry = value!);
        },
      ),
    ),
  );
}
}
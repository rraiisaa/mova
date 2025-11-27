import 'package:flutter/material.dart';
import 'package:mova_app/routes/app_pages.dart';
import 'package:mova_app/screens/account_setup/create_pin_screen.dart';
import 'package:mova_app/screens/account_setup/widgets/profile.dart';
import 'package:mova_app/utils/app_color.dart';


class ProfileFormScreen extends StatefulWidget {
  static String routeName = Routes.PROFILE_FORM;

  const ProfileFormScreen({super.key});

  @override
  State<ProfileFormScreen> createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileFormScreen> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _nicknameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  String _gender = 'Female';
  final List<String> _genders = ['Male', 'Female', 'Prefer not to say'];

  final _formKey = GlobalKey<FormState>();

  void _onSkip() {
    Navigator.pop(context, Routes.HOME);
  }

  void _onContinue() {
    Navigator.pop(context, Routes.HOME);
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _nicknameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final Map<String, dynamic> userData = {
        'fullName': _fullNameController.text,
        'nickname': _nicknameController.text,
        'email': _emailController.text,
        'phoneNumber': _phoneController.text,
        'gender': _gender,
      };

      print('Data Ready to Send $userData');

      // TODO: Panggil API Service di sini
      // Navigator.of(context).push(MaterialPageRoute(builder: (context) => SetPinScreen()));
    }
  }

  void _skipSetup() {
    print('Setup skipped.');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kPrimary,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              'Fill Your Profile',
              style: TextStyle(
                color: AppColors.kTextColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),

      body: Stack(
        key: _formKey,
        children: [
          Positioned.fill(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ProfilePictureArea(),
                  SizedBox(height: 40),

                  CustomTextInput(
                    controller: _fullNameController,
                    hintText: 'Full Name',
                    validator: (value) =>
                        value!.isEmpty ? 'Full Name is Required' : null,
                  ),
                  SizedBox(height: 16),

                  CustomTextInput(
                    controller: _nicknameController,
                    hintText: 'Nickname',
                  ),
                  SizedBox(height: 16),

                  CustomTextInput(
                    controller: _emailController,
                    hintText: 'Email',
                    keyboardType: TextInputType.emailAddress,
                    suffixIcon: Icon(Icons.email_outlined, color: Colors.grey),
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          !value.contains('@')) {
                        return "The format email isn't valid";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),

                  PhoneInput(
                    controller: _phoneController,
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 16),

                  // GenderDropdown(
                  //   currentValue: _gender,
                  //   genders: _genders,
                  //   onChanged: (newValue) {
                  //     setState(() => _gender = newValue!);
                  //   }
                  // ),
                  SizedBox(height: 40),

                  Align(
                    alignment: Alignment.bottomCenter,
                    child: GestureDetector(
                      onTap: () =>
                              Navigator.pop(context, Routes.HOME),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 5,
                          vertical: 110,
                        ),
                        child: ActionButtons(
                          onSkip: _onSkip,
                          onContinue: _onContinue,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
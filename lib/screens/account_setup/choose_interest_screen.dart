import 'package:flutter/material.dart';
import 'package:mova_app/routes/app_pages.dart';
import 'package:mova_app/screens/account_setup/profile_form_screen.dart';
import 'package:mova_app/screens/account_setup/widgets/choose_interest.dart';
import 'package:mova_app/utils/app_color.dart';

class ChooseInterestScreen extends StatefulWidget {
  const ChooseInterestScreen({super.key});

  @override
  State<ChooseInterestScreen> createState() => _ChooseInterestScreenState();
}

class _ChooseInterestScreenState extends State<ChooseInterestScreen> {
  final List<String> _allInterests = [
    'Action', 'Drama', 'Comedy', 'Horror', 'Adventure', 'Thriller',
    'Romance', 'Science', 'Music', 'Documentary', 'Crime', 'Fantasy',
    'Mystery', 'Fiction', 'Animation', 'War', 'History', 'Television',
    'Superheroes', 'Anime', 'Sports', 'K-Drama',
  ];
  final Set<String> _selectedInterests = {};

  void _toggleInterest(String interest) {
    setState(() {
      if (_selectedInterests.contains(interest)) {
        _selectedInterests.remove(interest);
      } else {
        _selectedInterests.add(interest);
      }
    });
  }

  void _onSkip() {
    Navigator.pushReplacementNamed(context, Routes.PROFILE_FORM);
  }

  void _onContinue() {
    if (_selectedInterests.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please choose at least one interest.')),
      );
      return;
    }
    
    Navigator.pushReplacementNamed(context, Routes.PROFILE_FORM);

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
            IconButton(
              icon: Icon(Icons.arrow_back),
              color: AppColors.kTextColor,
              onPressed: () => Navigator.of(context).pop(),
            ),
            SizedBox(width: 8),
            Text(
              'Choose Your Interest',
              style: TextStyle(
                color: AppColors.kTextColor,
                fontSize: 18,
                fontWeight: FontWeight.bold
              ),
            )
          ],
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Choose your interests and get the best movie recommendations. Don\'t worry, you can always change it later.',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16
                    ),
                  ),
                  SizedBox(height: 30),

                  // Grid Pilihan Minat
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: _allInterests.map((interest) {
                      final isSelected = _selectedInterests.contains(interest);
                      return InterestChip(
                        label: interest,
                        isSelected: isSelected,
                        onTap: () => _toggleInterest(interest),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 20)
                ],
              ),
            ),
          ),
          
          Align(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              onTap: () => Navigator.pushReplacementNamed(context, Routes.PROFILE_FORM),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                color: AppColors.kPrimary,
                child: ActionButtons(
                  onSkip: _onSkip,
                  onContinue: _onContinue,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
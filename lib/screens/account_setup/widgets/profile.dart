import 'package:flutter/material.dart';
import 'package:mova_app/utils/app_color.dart';

class ProfilePictureArea extends StatelessWidget {
  const ProfilePictureArea({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          SizedBox(
            height: 140,
            width: 140,
            child: CircleAvatar(
              radius: 50,
              backgroundColor: AppColors.kAdded,
              child: Icon(Icons.person, size: 100, color: AppColors.kSecondary),
            ),
          ),
          Positioned(
            bottom: 6,
            right: 4,
            child: GestureDetector(
              onTap: () {
                print('Edit photo clicked');
              },
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.kSecondary,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Icon(
                  Icons.edit,
                  color: Colors.white,
                  size: 16
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomTextInput extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final FormFieldValidator<String>? validator;

  const CustomTextInput({super.key, required this.controller, required this.hintText, this.keyboardType, this.suffixIcon, this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      style: TextStyle(color: AppColors.kTextColor),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey),
        fillColor: AppColors.kAdded,
        filled: true,
        suffixIcon: suffixIcon,
        contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 15),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none
        )
      ),
      validator: validator,
    );
  }
}

class PhoneInput extends StatelessWidget {
  final TextEditingController controller;

  const PhoneInput({super.key, required this.controller, required TextInputType keyboardType});

  @override
  Widget build(BuildContext context) {
    return CustomTextInput(
      controller: controller,
      hintText: 'Phone Number',
      keyboardType: TextInputType.number,
      validator: (value) => value!.isEmpty ? 'Phone number cannot be empty' : null
    );
  }
}

// class GenderDropdown extends StatelessWidget {
//   final String currentValue;
//   final List<String> genders;
//   final ValueChanged<String?> onChanged;

//   const GenderDropdown({super.key, required this.currentValue, required this.genders, required this.onChanged});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.black,
//         borderRadius: BorderRadius.circular(12.0),
//       ),
//       child: DropdownButtonFormField<String>(
//         value: currentValue,
//         icon: Icon(Icons.arrow_drop_down, color: Colors.grey), // Menghapus const
//         decoration: InputDecoration(
//           border: InputBorder.none,
//           hintText: 'Gender',
//           hintStyle: TextStyle(color: Colors.grey),
//           contentPadding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 18.0),
//         ),
//         dropdownColor: Colors.black45,
//         style: TextStyle(color: Colors.white), // Menghapus const
//         items: genders.map<DropdownMenuItem<String>>((String value) {
//           return DropdownMenuItem<String>(
//             value: value,
//             child: Text(value, style: TextStyle(color: Colors.white)), // Menghapus const
//           );
//         }).toList(),
//         onChanged: onChanged,
//       ),
//     );
//   }
// }

class ActionButtons extends StatelessWidget {
  final VoidCallback onSkip;
  final VoidCallback onContinue;

  const ActionButtons({super.key, required this.onSkip, required this.onContinue});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Row(
        children: [
          // Skip button
          Expanded(
            child: TextButton(
              onPressed: onSkip,
              style: TextButton.styleFrom(
                backgroundColor: Colors.grey[800],
                padding: EdgeInsets.symmetric(vertical: 13),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(45),
                ),
              ),
              child: Text(
                'Skip',
                style: TextStyle(fontSize: 14, color: AppColors.kTextColor, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          SizedBox(width: 15),
          
          // Continue button
          Expanded(
            child: ElevatedButton(
              onPressed: onContinue,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.kSecondary,
                padding: EdgeInsets.symmetric(vertical: 13),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(45),
                ),
              ),
              child: Text(
                'Continue',
                style: TextStyle(fontSize: 14, color: AppColors.kTextColor, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
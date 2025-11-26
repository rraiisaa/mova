import 'package:flutter/material.dart';

class FilterButton extends StatelessWidget {
  const FilterButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF281920),
        borderRadius: BorderRadius.circular(10),
      ),
      child: IconButton(
        icon: Icon(Icons.filter_list_rounded, color: Colors.red),
        onPressed: () {},
      ),
    );
  }
}
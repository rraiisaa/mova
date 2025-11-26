import 'package:flutter/material.dart';

class SelectedFilterChips extends StatelessWidget {
  final List<String> selectedFilters;
  final VoidCallback onClear;

  SelectedFilterChips({
    Key? key,
    required this.selectedFilters,
    required this.onClear,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (selectedFilters.isEmpty) return SizedBox();

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: selectedFilters.map((f) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            margin: EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              f,
              style: TextStyle(color: Colors.white),
            ),
          );
        }).toList(),
      ),
    );
  }
}
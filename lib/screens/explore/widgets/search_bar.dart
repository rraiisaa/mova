import 'package:flutter/material.dart';
import 'package:mova_app/utils/app_color.dart';

class CustomSearchBar extends StatefulWidget {
  final Function(String) onChanged;
  final VoidCallback onFilterTap;

  CustomSearchBar({
    Key? key,
    required this.onChanged,
    required this.onFilterTap,
  }) : super(key: key);

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  FocusNode focusNode = FocusNode();
  bool isFocused = false;

  @override
  void initState() {
    super.initState();
    focusNode.addListener(() {
      setState(() {
        isFocused = focusNode.hasFocus;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10, bottom: 14),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                color: isFocused
                    ? AppColors.kPrimary
                    : Colors.black45,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: isFocused ? AppColors.kSecondary : Colors.transparent,
                  width: 2,
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 14),
              child: Row(
                children: [
                  Icon(
                    Icons.search,
                    color: isFocused ? AppColors.kSecondary : Color(0xFF9B9B9B),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      focusNode: focusNode,
                      onChanged: widget.onChanged,
                      style: TextStyle(color: AppColors.kTextColor),
                      decoration: InputDecoration(
                        hintText: "Search",
                        hintStyle: TextStyle(color: Color(0xFF7D7D7D)),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 12),
          GestureDetector(
            onTap: widget.onFilterTap,
            child: Container(
              height: 48,
              width: 48,
              decoration: BoxDecoration(
                color: AppColors.kPrimary,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(Icons.tune, color: AppColors.kSecondary),
            ),
          ),
        ],
      ),
    );
  }
}
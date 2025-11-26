import 'package:flutter/material.dart';
import 'filter_chip_item.dart';

class FilterBottomSheet extends StatefulWidget {
  final List<String> selectedFilters;
  final Function(List<String>) onApply;

  FilterBottomSheet({
    Key? key,
    required this.selectedFilters,
    required this.onApply,
  }) : super(key: key);

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  List<String> selectedLocal = [];

  List<String> categories = [
    "Movie",
    "TV Shows",
    "K-Drama",
    "Anime",
    "Documentary",
  ];

  List<String> regions = ["All Regions", "US", "South Korea", "China", "Japan"];

  List<String> genres = ["Action", "Comedy", "Romance", "Thriller"];

  List<String> years = ["All Periods", "2022", "2021", "2020"];

  @override
  void initState() {
    selectedLocal = List.from(widget.selectedFilters);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
      decoration: BoxDecoration(
        color: Color(0xFF16161A),
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                margin: EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            Text(
              "Sort & Filter",
              style: TextStyle(
                color: Colors.red,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Divider(color: Colors.white12),
            _buildSection("Categories", categories),
            _buildSection("Regions", regions),
            _buildSection("Genre", genres),
            _buildSection("Time/Periods", years),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() => selectedLocal.clear());
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Color(0xFF2C2C30),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Center(
                        child: Text(
                          "Reset",
                          style: TextStyle(color: Colors.white60, fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      widget.onApply(selectedLocal);
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Center(
                        child: Text(
                          "Apply",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
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
      ),
    );
  }

  Widget _buildSection(String title, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 22),
        Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 12),
        // biar kategori chip nya horizontal
        SizedBox(
          height: 46,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: items.map((item) {
              return Padding(
                padding: EdgeInsets.only(right: 12),
                child: FilterChipItem(
                  text: item,
                  selected: selectedLocal.contains(item),
                  onTap: () {
                    setState(() {
                      if (selectedLocal.contains(item)) {
                        selectedLocal.remove(item);
                      } else {
                        selectedLocal.add(item);
                      }
                    });
                  },
                ),
              );
            }).toList(),
          ),
        ),
        SizedBox(height: 18),
        //biar ada garisnya
        Divider(color: Colors.white12, thickness: 1),
      ],
    );
  }
}
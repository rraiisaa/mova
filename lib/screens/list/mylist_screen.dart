import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mova_app/routes/app_pages.dart';
import 'package:mova_app/screens/widgets/bottom_navbar.dart';
import 'package:mova_app/utils/app_color.dart';

class MyListScreen extends StatefulWidget {
  MyListScreen({super.key});

  @override
  State<MyListScreen> createState() => _MyListScreenState();
}

class _MyListScreenState extends State<MyListScreen> {
  int _selectedIndex = 2;

  List<String> categories = [
    "All Categories",
    "Movies",
    "Series",
    "Anime",
    "Documentary",
  ];

  String selectedCategory = "All Categories";
  String searchQuery = "";

  List<Map<String, String>> myList = [
    {"rating": "9.8", "image": "assets/images/aouad.jpg", "title": "All Of Us Are Dead"},
    {"rating": "9.7", "image": "assets/images/joker.jpg", "title": "Joker"},
    {"rating": "9.6", "image": "assets/images/megan.jpg", "title": "Megan"},
    {"rating": "9.6", "image": "assets/images/parasite.jpg", "title": "Parasite"},
    {"rating": "9.6", "image": "assets/images/spiderman.jpg", "title": "Spiderman"},
    {"rating": "9.6", "image": "assets/images/stalker.jpg", "title": "Stalker"},
    {"rating": "9.6", "image": "assets/images/tangled.jpg", "title": "Tangled"},
    {"rating": "9.6", "image": "assets/images/tlou.jpg", "title": "The Last Of Us"},
    {"rating": "9.6", "image": "assets/images/cargo.jpg", "title": "Cargo"},
    {"rating": "9.6", "image": "assets/images/dune.jpg", "title": "Dune"},
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> filteredList = myList.where((item) {
      bool matchSearch = item["title"]!.toLowerCase().contains(searchQuery.toLowerCase());
      bool matchCategory = selectedCategory == "All Categories" || item["title"]!.toLowerCase().contains(selectedCategory.toLowerCase());
      return matchSearch && matchCategory;
    }).toList();

    return Scaffold(
      backgroundColor: AppColors.kPrimary,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset("assets/images/logo.png", width: 34),
                      SizedBox(width: 20),
                      Text(
                        "My List",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              SizedBox(height: 16),
              Container(
                height: 42,
                decoration: BoxDecoration(
                  color: Colors.white12,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.symmetric(horizontal: 14),
                child: Row(
                  children: [
                    Icon(Icons.search, color: Colors.white54),
                    SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        style: TextStyle(color: Colors.white),
                        onChanged: (value) {
                          setState(() {
                            searchQuery = value;
                          });
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Search your list...",
                          hintStyle: TextStyle(color: Colors.white38),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 18),

              SizedBox(
                height: 36,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    String cat = categories[index];
                    bool isSelected = selectedCategory == cat;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedCategory = cat;
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 10),
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: isSelected ? AppColors.kSecondary : Colors.white10,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          cat,
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.white70,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              SizedBox(height: 14),

              Expanded(
                child: filteredList.isEmpty
                    ? _buildEmpty()
                    : _buildGrid(filteredList),
              ),
            ],
          ),
        ),
      ),
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
            ; // tetap di my list 
          } else if (i == 3) {
            Navigator.pushReplacementNamed(context, Routes.DOWNLOAD);
          } else if (i == 4) {
          Navigator.pushReplacementNamed(context, Routes.PROFILE)
            ;
          }
        },
      ),
    );
  }

  Widget _buildEmpty() {
  return Center(
    child: SingleChildScrollView(  
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset("assets/lottie/emptyred.json", width: 200),
          SizedBox(height: 14),
          Text(
            "No Results",
            style: TextStyle(
              color: AppColors.kSecondary,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            "Try searching something else",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white70,
              fontSize: 15,
              height: 1.5,
            ),
          ),
        ],
      ),
    ),
  );
}


  Widget _buildGrid(List<Map<String, String>> list) {
    return GridView.builder(
      itemCount: list.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 14,
        crossAxisSpacing: 12,
        childAspectRatio: 0.66,
      ),
      itemBuilder: (context, index) {
        final item = list[index];

        return Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                item["image"]!,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
            Positioned(
              top: 8,
              left: 8,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  item["rating"]!,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mova_app/controllers/my_list_controller.dart';
import 'package:mova_app/models/mova_model.dart';
import 'package:mova_app/routes/app_pages.dart';
import 'package:mova_app/screens/detail/detail_screen.dart';
import 'package:mova_app/screens/widgets/bottom_navbar.dart';
import 'package:mova_app/utils/app_color.dart';

class MyListScreen extends StatefulWidget {
  @override
  State<MyListScreen> createState() => _MyListScreenState();
}

class _MyListScreenState extends State<MyListScreen> {
  final MyListController myListC = Get.find<MyListController>();
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

  @override
  Widget build(BuildContext context) {
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

              SizedBox(height: 16),
              _buildSearchBar(),
              SizedBox(height: 18),
              _buildCategories(),

              SizedBox(height: 14),

              Expanded(
                child: Obx(() {
                  final filtered = myListC.myListMovies.where((movie) {
                    bool matchSearch = movie["title"]
                        .toString()
                        .toLowerCase()
                        .contains(searchQuery.toLowerCase());
                    return matchSearch;
                  }).toList();

                  return filtered.isEmpty
                      ? _buildEmpty()
                      : _buildGrid(filtered);
                }),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: MovaBottomNav(
        currentIndex: _selectedIndex,
        onTap: (i) {
          setState(() => _selectedIndex = i);
          if (i == 0) Navigator.pushReplacementNamed(context, Routes.HOME);
          if (i == 1) Navigator.pushReplacementNamed(context, Routes.EXPLORE);
          if (i == 3) Navigator.pushReplacementNamed(context, Routes.DOWNLOAD);
          if (i == 4) Navigator.pushReplacementNamed(context, Routes.PROFILE);
        },
      ),
    );
  }

  Widget _buildEmpty() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
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
            style: TextStyle(color: Colors.white70, fontSize: 15, height: 1.5),
          ),
        ],
      ),
    );
  }

  // grid view for my list movies
  Widget _buildGrid(List<Map<String, dynamic>> list) {
    return GridView.builder(
  padding: const EdgeInsets.all(16),
  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    crossAxisSpacing: 12,
    mainAxisSpacing: 12,
    childAspectRatio: 0.65,
  ),
  itemCount: list.length,
  itemBuilder: (context, index) {
    final map = list[index];
    final movieModel = Movie.fromMap(map);

    return GestureDetector(
      onTap: () {
        // navigate to detail if needed, for example:
        // Get.to(() => DetailScreen(movie: movieModel));
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(16),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.network(
                "https://image.tmdb.org/t/p/w500${map['backdrop_path'] ?? map['backDropPath'] ?? map['poster_path'] ?? ''}",
                fit: BoxFit.cover,
                errorBuilder: (c, e, s) =>
                    Image.network('https://picsum.photos/800/600', fit: BoxFit.cover),
              ),

              // BADGE RATING
              Positioned(
                top: 8,
                left: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.kSecondary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    (map["vote_average"] ?? '-').toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  },
);
  }

  Widget _buildCategories() {
    return SizedBox(
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
    );
  }

  Widget _buildSearchBar() {
    return Container(
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
              onChanged: (v) => setState(() => searchQuery = v),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Search your list...",
                hintStyle: TextStyle(color: Colors.white38),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

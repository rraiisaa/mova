import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mova_app/routes/app_pages.dart';
import 'package:mova_app/screens/explore/widgets/filter_bottom_sheets.dart';
import 'package:mova_app/screens/explore/widgets/movie_card.dart';
import 'package:mova_app/screens/explore/widgets/search_bar.dart';
import 'package:mova_app/screens/explore/widgets/selected_filter_chip.dart';
import 'package:mova_app/screens/widget/bottom_navbar.dart';
import 'package:mova_app/screens/widget/custom_loader.dart';
import 'package:mova_app/services/mova_services.dart';
import 'package:mova_app/models/mova_model.dart';
import 'package:mova_app/utils/app_color.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  List<Movie> movies = [];
  bool isLoading = true;
  String searchQuery = "";
  List<String> selectedFilters = [];

  int _selectedIndex = 1;

  @override
  void initState() {
    super.initState();
    fetchMovies();
  }

  Future<void> fetchMovies() async {
    try {
      movies = await MovieServices().getPopularMovies(); // or upcoming/topRated
    } catch (e) {
      print("Error loading movies: $e");
    }
    setState(() => isLoading = false);
  }

  void openFilterSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.85,
          child: FilterBottomSheet(
            selectedFilters: selectedFilters,
            onApply: (newFilters) {
              setState(() => selectedFilters = newFilters);
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final filtered = movies.where((movie) {
      return movie.title.toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      backgroundColor: AppColors.kPrimary,
      bottomNavigationBar: MovaBottomNav(
        currentIndex: _selectedIndex,
        onTap: (i) {
          setState(() => _selectedIndex = i);
          // tambahkan navigasi
          if (i == 0) {
            Navigator.pushReplacementNamed(context, Routes.HOME);
          } else if (i == 1) {
            // tetap di explore
          } else if (i == 2) {
            Navigator.pushReplacementNamed(context, '/saved');
          } else if (i == 3) {
            Navigator.pushReplacementNamed(context, '/profile');
          }
        },
      ),

      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomSearchBar(
                onChanged: (value) => setState(() => searchQuery = value),
                onFilterTap: openFilterSheet,
              ),

              SelectedFilterChips(
                selectedFilters: selectedFilters,
                onClear: () => setState(() => selectedFilters.clear()),
              ),

              Expanded(
                child: isLoading
                    ? Center(
                        child: const CustomLoader()
                      )
                    : filtered.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Lottie.asset(
                              'assets/lottie/error.json',
                              width: 200,
                              height: 200,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Not Found',
                              style: TextStyle(
                                color: AppColors.kSecondary,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Sorry, the keyword you entered couldn't be found.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      )
                    : GridView.builder(
                        itemCount: filtered.length,
                        padding: EdgeInsets.only(top: 10),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 14,
                          crossAxisSpacing: 12,
                          childAspectRatio: 0.67,
                        ),
                        itemBuilder: (_, i) {
                          final movie = filtered[i];
                          return MovieCard(
                            rating: movie.voteAverage.toStringAsFixed(1),
                            imagePath:
                                "https://image.tmdb.org/t/p/w500${movie.posterPath}",
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

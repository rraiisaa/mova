import 'package:flutter/material.dart';
import 'package:mova_app/core/api.dart';
import 'package:mova_app/models/mova_model.dart';
import 'package:mova_app/routes/app_pages.dart';
import 'package:mova_app/screens/detail/detail_screen.dart';
import 'package:mova_app/screens/home/widgets/home_header.dart';
import 'package:mova_app/screens/home/widgets/movie_horizontal_list.dart';
import 'package:mova_app/screens/popular/popular_screen.dart';
import 'package:mova_app/screens/widgets/bottom_navbar.dart';
import 'package:mova_app/screens/widgets/custom_loader.dart';
import 'package:mova_app/utils/app_color.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Movie>> upcoming;
  late Future<List<Movie>> popular;
  late Future<List<Movie>> topRated;

  int _selectedIndex = 0;

  @override
  void initState() {
    upcoming = Api().getUpcomingMovies();
    popular = Api().getPopularMovies();
    topRated = Api().getTopRatedMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kPrimary,

       bottomNavigationBar: MovaBottomNav(
        currentIndex: _selectedIndex,
        onTap: (i) {
          setState(() => _selectedIndex = i);
          // tambahkan navigasi
          if (i == 0) {
            ;
          } else if (i == 1) {
            Navigator.pushReplacementNamed(context, Routes.EXPLORE);
          } else if (i == 2) {
            Navigator.pushReplacementNamed(context, Routes.MYLIST);
          } else if (i == 3) {
            Navigator.pushReplacementNamed(context, Routes.DOWNLOAD);
          } else if (i == 4) {
            Navigator.pushReplacementNamed(context, Routes.PROFILE);
          }
        },
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // upcoming header
              FutureBuilder<List<Movie>>(
                future: upcoming,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const SizedBox(
                      height: 260,
                      child: Center(child: CustomLoader()),
                    );
                  }

                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Text(
                      "No Data",
                      style: TextStyle(color: Colors.white),
                    );
                  }

                  final movie = snapshot.data!.first;

                  return HomeHeader(movie: movie);
                },
              ),

              const SizedBox(height: 18),

              // popular section
              FutureBuilder<List<Movie>>(
                future: popular,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const SizedBox(
                      height: 220,
                      child: Center(child: CustomLoader()),
                    );
                  }

                  if (snapshot.hasError) {
                    return Text(
                      "Error: ${snapshot.error}",
                      style: const TextStyle(color: Colors.white),
                    );
                  }

                  final movies = snapshot.data ?? [];

                  return MovieHorizontalList(
                    title: 'Top 10 Movies This Week',
                    movies: movies,
                    onSeeAll: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => PopularScreen(
                            movies: movies,
                            title: 'Top 10 Movies This Week',
                          ),
                        ),
                      );
                    },
                    onMovieTap: (movie) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => MovieDetailsScreen(movie: movie),
                        ),
                      );
                    },
                  );
                },
              ),

              const SizedBox(height: 20),

              // top rated section
              FutureBuilder<List<Movie>>(
                future: topRated,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const SizedBox(
                      height: 220,
                      child: Center(child: CustomLoader()),
                    );
                  }

                  if (snapshot.hasError) {
                    return Text(
                      "Error: ${snapshot.error}",
                      style: const TextStyle(color: Colors.white),
                    );
                  }

                  final movies = snapshot.data ?? [];

                  return MovieHorizontalList(
                    title: 'Top Rated',
                    movies: movies,
                    onSeeAll: () {},
                    onMovieTap: (movie) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => MovieDetailsScreen(movie: movie),
                        ),
                      );
                    },
                  );
                },
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:mova_app/core/api.dart';
import 'package:mova_app/models/mova_model.dart';
import 'package:mova_app/screens/home/widgets/home_header.dart';
import 'package:mova_app/screens/home/widgets/movie_poster_item.dart';
import 'package:mova_app/screens/home/widgets/movie_horizontal_list.dart';
import 'package:mova_app/screens/popular/popular_screen.dart';
import 'package:mova_app/screens/widget/bottom_navbar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
      backgroundColor: const Color(0xFF2B2B2B),
      bottomNavigationBar: MovaBottomNav(
        currentIndex: _selectedIndex,
        onTap: (i) {
          setState(() {
            _selectedIndex = i;
          });
        },
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // HOME HEADER - uses first upcoming movie
              FutureBuilder<List<Movie>>(
                future: upcoming,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const SizedBox(
                        height: 260, child: Center(child: CircularProgressIndicator()));
                  }
                  if (snapshot.hasError) {
                    return SizedBox(
                        height: 260,
                        child: Center(child: Text('Error: ${snapshot.error}', style: TextStyle(color: Colors.white))));
                  }
                  final movie = snapshot.data!.first;
                  return HomeHeader(movie: movie);
                },
              ),

              const SizedBox(height: 18),

              // POPULAR SECTION (with See all -> PopularScreen)
              FutureBuilder<List<Movie>>(
                future: popular,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const SizedBox(height: 220, child: Center(child: CircularProgressIndicator()));
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}', style: const TextStyle(color: Colors.white)));
                  }
                  final movies = snapshot.data ?? [];
                  return MovieHorizontalList(
                    title: 'Top 10 Movies This Week',
                    movies: movies,
                    onSeeAll: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => PopularScreen(movies: movies, title: 'Top 10 Movies This Week'),
                        ),
                      );
                    },
                  );
                },
              ),

              const SizedBox(height: 20),

              // TOP RATED
              FutureBuilder<List<Movie>>(
                future: topRated,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const SizedBox(height: 220, child: Center(child: CircularProgressIndicator()));
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}', style: const TextStyle(color: Colors.white)));
                  }
                  final movies = snapshot.data ?? [];
                  return MovieHorizontalList(
                    title: 'Top Rated',
                    movies: movies,
                    onSeeAll: () {
                      // if you want a separate TopRated screen, navigate here
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

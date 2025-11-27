import 'package:flutter/material.dart';
import 'package:mova_app/models/mova_model.dart';
import 'package:mova_app/screens/detail/widgets/more_like_this.dart';
import 'package:mova_app/screens/detail/widgets/trailer.dart';
import 'package:mova_app/services/mova_services.dart';
import 'package:mova_app/utils/app_color.dart';
import 'Widgets/comments.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:ui';

class MovieDetailsScreen extends StatefulWidget {
  final Movie
  movie; // Menerima data Movie dari screen sebelumnya (home / explore).

  const MovieDetailsScreen({super.key, required this.movie});

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen>
    with SingleTickerProviderStateMixin {
  late TabController
  _tabController; // TabController untuk mengatur TabBar (Trailers, More Like This, Comments).
  List<String> genres = []; // Menyimpan genre film yang diambil dari API.
  String? trailerKey; // Menyimpan kunci trailer film yang diambil dari API.

  @override
  void initState() {
    // panggil api (fetch genres & trailer) saat inisialisasi state
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    loadMovieDetails();
  }

  // ambil genre film & trailer dari API
  Future<void> loadMovieDetails() async {
    genres = await MovieServices.fetchGenres(widget.movie.id);
    trailerKey = await MovieServices().getMovieTrailerKey(
      widget.movie.id,
      widget.movie.mediaType,
    );
    setState(() {}); // setState() supaya UI update.
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // ===== POSTER =====
  Widget _buildPoster() {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.network(
          "https://image.tmdb.org/t/p/w500${widget.movie.backDropPath}",
          fit: BoxFit.cover,
          errorBuilder: (c, e, s) =>
              Image.network('https://picsum.photos/800/600', fit: BoxFit.cover),
        ),

        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.center,
              end: Alignment.bottomCenter,
              colors: [Colors.transparent, Color(0xCC000000)],
            ),
          ),
        ),
        Positioned(
          top: 40,
          left: 12,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: Colors.black45,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.cast, color: Colors.white),
          ),
        ),
      ],
    );
  }

  // ===== TITLE =====
  Widget _buildTitleRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: Text(
              widget.movie.title ?? "No Title",
              style: TextStyle(
                color: AppColors.kTextColor,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.bookmark_border, color: Colors.white70),
          ),
          IconButton(
            onPressed: () => showShareSheet(context),
            icon: const Icon(Icons.send, color: Colors.white70),
          ),
        ],
      ),
    );
  }

  void _showRatingSheet(BuildContext context) {
    int selectedRating = 0;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setState) {
            return DraggableScrollableSheet(
              initialChildSize: 0.55,
              minChildSize: 0.30,
              maxChildSize: 0.80,
              builder: (context, controller) {
                return Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFF191A1F),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(26),
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 22,
                    vertical: 18,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          height: 5,
                          width: 45,
                          decoration: BoxDecoration(
                            color: AppColors.kTextColor.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      const Center(
                        child: Text(
                          'Give Rating',
                          style: TextStyle(
                            color: AppColors.kTextColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // ----- STATIC INFO -----
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${widget.movie.voteAverage?.toStringAsFixed(1)}",
                                style: TextStyle(
                                  color: AppColors.kTextColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),

                              SizedBox(height: 4),
                              Text(
                                '/10',
                                style: TextStyle(
                                  color: Colors.white54,
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(height: 6),
                              Text(
                                '(24.679 users)',
                                style: TextStyle(
                                  color: Colors.white38,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 28),
                          Expanded(
                            child: Column(
                              children: List.generate(5, (i) {
                                int star = 5 - i;
                                double width = [1.0, 0.7, 0.3, 0.2, 0.1][i];

                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 3,
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        "$star",
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                        ),
                                      ),
                                      const SizedBox(width: 6),
                                      Expanded(
                                        child: Container(
                                          height: 5,
                                          decoration: BoxDecoration(
                                            color: Colors.white12,
                                            borderRadius: BorderRadius.circular(
                                              3,
                                            ),
                                          ),
                                          child: FractionallySizedBox(
                                            widthFactor: width,
                                            alignment: Alignment.centerLeft,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Color(0xFFE21220),
                                                borderRadius:
                                                    BorderRadius.circular(3),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 30),

                      // ====== CLICKABLE STAR ======
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(5, (i) {
                          int starIndex = i + 1;

                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedRating = starIndex;
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                              ),
                              child: Icon(
                                selectedRating >= starIndex
                                    ? Icons.star
                                    : Icons.star_border,
                                color: Colors.redAccent,
                                size: 36,
                              ),
                            ),
                          );
                        }),
                      ),

                      const SizedBox(height: 30),

                      // ===== BUTTONS =====
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white12,
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                alignment: Alignment.center,
                                child: const Text(
                                  'Cancel',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                if (selectedRating == 0) return;

                                Navigator.pop(context);

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      "Thank you! You rated $selectedRating stars ❤️",
                                    ),
                                    backgroundColor: Colors.redAccent,
                                  ),
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFE21220),
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                alignment: Alignment.center,
                                child: const Text(
                                  'Submit',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  Widget _buildChips() {
    Widget chip(String label) => Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white24),
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 12, color: Colors.white),
      ),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      child: Row(
        // TODO : Jadiin childern di bawah ini putih semua
        children: [
          const Icon(Icons.star, color: AppColors.kSecondary, size: 18),
          const SizedBox(width: 6),
          GestureDetector(
            onTap: () => _showRatingSheet(context),
            child: Text(
              "${widget.movie.voteAverage?.toStringAsFixed(1)}",
              style: TextStyle(
                color: AppColors.kTextColor,
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
          ),
          const SizedBox(width: 12),
          chip('2022'),
          chip('13+'),
          chip('United States'),
          chip('Subtitle'),
        ],
      ),
    );
  }

  // button play & download
  Widget _buildActionButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.kSecondary,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onPressed: () async {
                final trailerKey = await MovieServices().getMovieTrailerKey(
                  widget.movie.id,
                  widget.movie.mediaType,
                );

                if (trailerKey == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Trailer not available")),
                  );
                  return;
                }

                final url = Uri.parse(
                  "https://www.youtube.com/watch?v=$trailerKey",
                );
                // ganti canLaunch dengan launchUrl biar langsung launch, kalau gagal baru catch error.
                try {
                  await launchUrl(url, mode: LaunchMode.externalApplication);
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Could not launch trailer")),
                  );
                }
              },

              icon: const Icon(Icons.play_arrow, color: Colors.white),
              label: const Text(
                'Play',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppColors.kSecondary),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onPressed: () {},
              icon: const Icon(
                Icons.download_outlined,
                color: AppColors.kTextColor,
              ),
              label: const Text(
                'Download',
                style: TextStyle(
                  color: AppColors.kTextColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ===== SYNOPSIS =====
  Widget _buildSynopsis() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Genre: Action, Superhero, Science Fiction, Romance, Thriller...",
            style: TextStyle(color: AppColors.kTextColor),
          ),
          SizedBox(height: 8),
          Text(
            widget.movie.overview ?? "No description available",
            style: TextStyle(height: 1.3, color: AppColors.kTextColor),
          ),
        ],
      ),
    );
  }

  // ===== CAST =====
  Widget _buildCastRow() {
    Widget person(String name, String role) => Column(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundImage: NetworkImage("https://picsum.photos/seed/$name/200"),
        ),
        const SizedBox(height: 6),
        Text(
          name,
          style: const TextStyle(fontSize: 12, color: AppColors.kTextColor),
        ),
        Text(role, style: const TextStyle(color: Colors.white54)),
      ],
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          person("James Cameron", "Director"),
          person("Sam Worthington", "Cast"),
          person("Zoe Saldana", "Cast"),
          person("Sigourney", "Cast"),
        ],
      ),
    );
  }

  // ===== TABBAR (must be TabBar return type) =====
  TabBar _buildTabBar() {
    return TabBar(
      controller: _tabController,
      labelColor: AppColors.kSecondary,
      unselectedLabelColor: Colors.white70,
      indicatorColor: AppColors.kSecondary,

      labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      unselectedLabelStyle: const TextStyle(
        fontWeight: FontWeight.w600, // sedikit lebih ringan dari bold
        fontSize: 15,
      ),

      tabs: const [
        Tab(text: "Trailers"),
        Tab(text: "More Like This"),
        Tab(text: "Comments"),
      ],
    );
  }

  // ===== SHARE SHEET =====
  void showShareSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF191A1F),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
      ),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // drag bar
              Container(
                width: 50,
                height: 5,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),

              const Text(
                "Send to",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              GridView.count(
                crossAxisCount: 4,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                childAspectRatio: 0.78,
                children: const [
                  _ShareIcon(icon: Icons.wechat_sharp, label: "WhatsApp"),
                  _ShareIcon(icon: Icons.chat, label: "Twitter"),
                  _ShareIcon(icon: Icons.facebook, label: "Facebook"),
                  _ShareIcon(icon: Icons.camera_alt, label: "Instagram"),
                  _ShareIcon(icon: Icons.mail, label: "Yahoo"),
                  _ShareIcon(icon: Icons.message, label: "Chat"),
                  _ShareIcon(icon: Icons.wechat, label: "WeChat"),
                  _ShareIcon(icon: Icons.tiktok, label: "TikTok"),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            expandedHeight: 340,
            pinned: true,
            backgroundColor: const Color(0xFF121212),
            flexibleSpace: FlexibleSpaceBar(background: _buildPoster()),
          ),

          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),
                _buildTitleRow(),
                const SizedBox(height: 12),
                _buildChips(),
                const SizedBox(height: 9),
                _buildActionButton(),
                const SizedBox(height: 9),
                _buildSynopsis(),
                _buildCastRow(),
                const SizedBox(height: 12),
              ],
            ),
          ),

          SliverPersistentHeader(
            pinned: true,
            delegate: _StickyTabBarDelegate(_buildTabBar()),
          ),
        ],

        body: TabBarView(
          controller: _tabController,
          children: [
            // TRAILERS
            trailerKey == null
                ? Center(
                    child: Text(
                      "Trailer not available",
                      style: TextStyle(color: Colors.white70),
                    ),
                  )
                : ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      TrailerCard(
                        title: "Official Trailer",
                        duration: "1m 45s",
                        trailerKey: trailerKey!, // kirim ke widget trailer
                      ),
                      const SizedBox(height: 14),
                    ],
                  ),

            // MORE LIKE THIS
            GridView.count(
              padding: const EdgeInsets.all(16),
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.62,
              children: List.generate(6, (i) => MoreLikeThisCard(index: i)),
            ),

            // COMMENTS
            ListView(
              padding: const EdgeInsets.all(16),
              children: const [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "24.6K Comments",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      "See all",
                      style: TextStyle(color: AppColors.kSecondary),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                CommentTile(
                  name: "Kristin Watson",
                  text: "Lorem ipsum dolor sit amet...",
                  color: AppColors.kTextColor,
                ),
                SizedBox(height: 12),
                CommentTile(
                  name: "John Doe",
                  text: "Great visuals and soundtrack!",
                  color: AppColors.kTextColor,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ===== STICKY TABBAR DELEGATE =====
class _StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;

  _StickyTabBarDelegate(this.tabBar);

  @override
  double get minExtent => tabBar.preferredSize.height;
  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  Widget build(context, shrinkOffset, overlapsContent) {
    return Container(color: const Color(0xFF121212), child: tabBar);
  }

  @override
  bool shouldRebuild(_) => false;
}

// ===== SHARE ICON =====
class _ShareIcon extends StatelessWidget {
  final IconData icon;
  final String label;

  const _ShareIcon({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: Colors.white10,
          radius: 28,
          child: Icon(icon, size: 26, color: Colors.white),
        ),
        const SizedBox(height: 6),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}

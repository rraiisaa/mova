import 'package:flutter/material.dart';
import 'package:mova_app/screens/detail/Widgets/comments.dart';
import 'package:mova_app/screens/detail/widgets/more_like_this.dart';
import 'package:mova_app/screens/detail/widgets/trailer.dart';
import 'package:mova_app/utils/app_color.dart';
import 'dart:ui';

class MovieDetailsScreen extends StatefulWidget {
  const MovieDetailsScreen({super.key});

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
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
        Image.asset(
          "assets/images/poster.jpg",
          fit: BoxFit.cover,
          errorBuilder: (c, e, s) =>
              Image.network('https://picsum.photos/800/600', fit: BoxFit.cover),
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.center,
              end: Alignment.bottomCenter,
              colors: [Colors.transparent, AppColors.kPrimary],
            ),
          ),
        ),
        Positioned(
          top: 40,
          left: 12,
          child: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.black45,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.cast, color: AppColors.kTextColor),
          ),
        ),
      ],
    );
  }

  // ===== TITLE =====
  Widget _buildTitleRow() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
         Expanded(
            child: Text(
              'Avatar: The Way of Water',
              style: TextStyle(
                color: AppColors.kTextColor,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          IconButton(
            onPressed: () {},
            icon: Icon(Icons.bookmark_border, color: Colors.white70),
          ),
          IconButton(
            onPressed: () => showShareSheet(context),
            icon: Icon(Icons.send, color: Colors.white70),
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
                  decoration: BoxDecoration(
                    color: AppColors.kPrimary,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(26),
                    ),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 22, vertical: 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          height: 5,
                          width: 45,
                          decoration: BoxDecoration(
                            color: AppColors.kTextColor.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),

                      Center(
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
                                '9.8',
                                style: TextStyle(
                                  color: AppColors.kTextColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 36,
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
                          SizedBox(width: 28),
                          Expanded(
                            child: Column(
                              children: List.generate(5, (i) {
                                int star = 5 - i;
                                double width = [1.0, 0.7, 0.3, 0.2, 0.1][i];

                                return Padding(
                                  padding: EdgeInsets.symmetric(vertical: 3),
                                  child: Row(
                                    children: [
                                      Text(
                                        "$star",
                                        style: TextStyle(
                                          color: AppColors.kTextColor,
                                          fontSize: 12,
                                        ),
                                      ),
                                      SizedBox(width: 6),
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
                                                color: AppColors.kSecondary,
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

                      SizedBox(height: 30),

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
                              padding: EdgeInsets.symmetric(horizontal: 6),
                              child: Icon(
                                selectedRating >= starIndex
                                    ? Icons.star
                                    : Icons.star_border,
                                color: AppColors.kSecondary,
                                size: 36,
                              ),
                            ),
                          );
                        }),
                      ),

                      SizedBox(height: 30),

                      // ===== BUTTONS =====
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 14),
                                decoration: BoxDecoration(
                                  color: Colors.white12,
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  'Cancel',
                                  style: TextStyle(
                                    color: AppColors.kTextColor,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 14),
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
                                    backgroundColor: AppColors.kSecondary,
                                  ),
                                );
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 14),
                                decoration: BoxDecoration(
                                  color: AppColors.kSecondary,
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  'Submit',
                                  style: TextStyle(
                                    color: AppColors.kTextColor,
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
      margin: EdgeInsets.only(right: 8),
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white24),
      ),
      child: Text(label, style: TextStyle(fontSize: 12)),
    );

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      child: Row(
        children: [
          Icon(Icons.star, color: Color(0xFFE21220), size: 18),
          SizedBox(width: 6),
          GestureDetector(
            onTap: () => _showRatingSheet(context),
            child: const Text(
              '9.8',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
            ),
          ),
          SizedBox(width: 12),
          chip('2022'),
          chip('13+'),
          chip('United States'),
          chip('Subtitle'),
        ],
      ),
    );
  }

  // ===== PLAY BUTTON =====
  Widget _buildActionButton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.kSecondary,
                padding: EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onPressed: () {},
              icon: Icon(Icons.play_arrow, color: Colors.white),
              label: Text(
                'Play',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: AppColors.kSecondary),
                padding: EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onPressed: () {},
              icon: Icon(Icons.download_outlined),
              label: Text(
                'Download',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
          ),
          SizedBox(height: 8),
          Text(
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit...",
            style: TextStyle(height: 1.3),
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
        SizedBox(height: 6),
        Text(name, style: TextStyle(fontSize: 12)),
        Text(role, style: TextStyle(color: Colors.white54)),
      ],
    );

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
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

      labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      unselectedLabelStyle: TextStyle(
        fontWeight: FontWeight.w600, // sedikit lebih ringan dari bold
        fontSize: 15,
      ),

      tabs: [
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
      backgroundColor: AppColors.kPrimary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
      ),
      builder: (_) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // drag bar
              Container(
                width: 50,
                height: 5,
                margin: EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),

              Text(
                "Send to",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),

              GridView.count(
                crossAxisCount: 4,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                childAspectRatio: 0.78,
                children: [
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
              SizedBox(height: 16),
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
            ListView(
              padding: const EdgeInsets.all(16),
              children: const [
                TrailerCard(title: "Official Trailer 1", duration: "2m 34s"),
                SizedBox(height: 14),
                TrailerCard(title: "Official Trailer 2", duration: "1m 24s"),
              ],
            ),
            // ListView(

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
                ),
                SizedBox(height: 12),
                CommentTile(
                  name: "John Doe",
                  text: "Great visuals and soundtrack!",
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
        SizedBox(height: 6),
        Text(label, style: TextStyle(fontSize: 12)),
      ],
    );
  }
}

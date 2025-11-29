import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mova_app/provider/download_provider.dart';
import 'package:mova_app/routes/app_pages.dart';
import 'package:mova_app/screens/download/widgets/delete_dialog.dart';
import 'package:mova_app/screens/download/widgets/download_item.dart';
import 'package:mova_app/screens/widgets/bottom_navbar.dart';
import 'package:provider/provider.dart';

class DownloadScreen extends StatefulWidget {
  DownloadScreen({super.key});

  @override
  State<DownloadScreen> createState() => _DownloadState();
}

class _DownloadState extends State<DownloadScreen> {
  int _selectedIndex = 3;
  String searchQuery = "";

  void deleteItem(BuildContext context, Map<String, String> item) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return DeleteDialog(
          item: item,
          onConfirm: () {
            Provider.of<DownloadProvider>(context, listen: false)
                .deleteItem(item);

            Navigator.pop(context);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DownloadProvider>(context);
    final downloadList = provider.downloadList;

    final list = searchQuery.isEmpty
        ? downloadList
        : downloadList.where((item) {
            return item["title"]!
                .toLowerCase()
                .contains(searchQuery.toLowerCase());
          }).toList();

    return Scaffold(
      backgroundColor: Color(0xFF0E0E10),
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
            Navigator.pushReplacementNamed(context, Routes.MYLIST);
          } else if (i == 3) {
            ;
          } else if (i == 4) {
            Navigator.pushReplacementNamed(context, Routes.PROFILE);
          }
        },
      ),
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
                    "Download",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),

              Container(
                height: 42,
                padding: EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                  color: Colors.white12,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(Icons.search, color: Colors.white54),
                    SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        style: TextStyle(color: Colors.white),
                        onChanged: (v) {
                          setState(() {
                            searchQuery = v;
                          });
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Search your movie...",
                          hintStyle: TextStyle(color: Colors.white38),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 16),

              if (searchQuery.isNotEmpty)
                Text(
                  "${list.length} results found for \"$searchQuery\"",
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),

              SizedBox(height: 8),

              Expanded(
                child: list.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Lottie.asset(
                              "assets/lottie/emptyred.json",
                              width: 220,
                            ),
                            SizedBox(height: 12),
                            Text(
                              searchQuery.isEmpty
                                  ? "No Downloads Yet"
                                  : "No Results Found",
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 6),
                            Text(
                              searchQuery.isEmpty
                                  ? "Download your favorite movies or series to watch offline"
                                  : "Try searching something else",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 15,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount: list.length,
                        itemBuilder: (context, i) {
                          final item = list[i];

                          return DownloadItem(
                            item: item,
                            onDelete: () => deleteItem(context, item),
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
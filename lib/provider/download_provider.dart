import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DownloadProvider extends ChangeNotifier {
  List<Map<String, String>> downloadList = [];

  DownloadProvider() {
    loadData();
  }

  Future<void> loadData() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString("downloads");

    if (saved != null) {
      final decoded = json.decode(saved);

      // convert semua value ke string biar ga error JsonMap
      downloadList = (decoded as List)
          .map(
            (e) => Map<String, String>.from(
              e.map((key, value) => MapEntry(key.toString(), value.toString())),
            ),
          )
          .toList();
    } else {
      downloadList = [
        {
          "duration": "1h 42m 33s",
          "image": "assets/images/aouad.jpg",
          "title": "All Of Us Are Dead",
          "fileSize": "1.4 GB",
        },
        {
          "duration": "1h 56m 49s",
          "image": "assets/images/tangled.jpg",
          "title": "Tangled",
          "fileSize": "1.3 GB",
        },
        {
          "duration": "2h 28m 32s",
          "image": "/assets/images/stalker.jpg",
          "title": "Stalker",
          "fileSize": "928.3 MB",
        },
        {
          "duration": "56m 43s",
          "image": "assets/images/joker.jpg",
          "title": "Joker",
          "fileSize": "827.6 MB",
        },
        {
          "duration": "2h 49m 56s",
          "image": "assets/images/spiderman.jpg",
          "title": "Spiderman: No Way Home",
          "fileSize": "1.9 GB",
        },
      ];
    }

    notifyListeners();
  }

  Future<void> saveData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("downloads", json.encode(downloadList));
  }

  void deleteItem(Map<String, String> item) {
    downloadList.remove(item);
    saveData();
    notifyListeners();
  }
}

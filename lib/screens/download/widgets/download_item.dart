import 'package:flutter/material.dart';

class DownloadItem extends StatelessWidget {
  final Map<String, String> item;
  final VoidCallback onDelete;

  DownloadItem({super.key, required this.item, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  item["image"]!,
                  width: 90,
                  height: 120,
                  fit: BoxFit.cover,
                ),
              ),
              Icon(
                Icons.play_circle_fill,
                size: 40,
                color: Colors.white.withValues(alpha: 0.8),
              ),
            ],
          ),
          SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item["title"]!,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4),
                  Text(
                    item["duration"]!,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 13,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    item["fileSize"]!,
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: onDelete,
            child: Padding(
              padding: EdgeInsets.only(top: 10),
              child: Icon(
                Icons.delete_outline_rounded,
                color: Colors.white38,
                size: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
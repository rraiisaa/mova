import 'package:flutter/material.dart';

class MoreLikeThisCard extends StatelessWidget {
  final int index;
  const MoreLikeThisCard({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(image: NetworkImage('https://picsum.photos/seed/mlt$index/400/600'), fit: BoxFit.cover),
            ),
          ),
        ),
        SizedBox(height: 8),
        Text('Movie Title', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 4),
        Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.black54),
              child: Text('9.7', style: TextStyle(fontSize: 12)),
            ),
            SizedBox(width: 8),
            Text('1h 45m', style: TextStyle(fontSize: 12, color: Colors.white54)),
          ],
        )
      ],
    );
  }
}
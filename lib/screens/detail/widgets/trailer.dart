import 'package:flutter/material.dart';

class TrailerCard extends StatelessWidget {
  final String title;
  final String duration;
  const TrailerCard({Key? key, required this.title, required this.duration}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 110,
          height: 70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(image: NetworkImage('https://picsum.photos/seed/trailer/300/200'), fit: BoxFit.cover),
          ),
          child: Center(child: Icon(Icons.play_circle_fill, size: 40)),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 6),
              Text(duration, style: TextStyle(color: Colors.white54, fontSize: 12)),
            ],
          ),
        )
      ],
    );
  }
}
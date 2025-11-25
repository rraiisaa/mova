
import 'package:flutter/material.dart';

class CommentTile extends StatelessWidget {
  final String name;
  final String text;
  const CommentTile({Key? key, required this.name, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(radius: 22, backgroundImage: NetworkImage('https://picsum.photos/seed/$name/200')),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text('3 days ago', style: const TextStyle(color: Colors.white54, fontSize: 12)),
                ],
              ),
              SizedBox(height: 6),
              Text(text),
              SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.favorite_border, size: 18),
                  SizedBox(width: 6),
                  Text('938', style: TextStyle(color: Colors.white54)),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
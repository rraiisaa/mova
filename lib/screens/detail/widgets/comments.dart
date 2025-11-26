
import 'package:flutter/material.dart';
import 'package:mova_app/utils/app_color.dart';

class CommentTile extends StatelessWidget {
  final String name;
  final String text;
  final Color color;
  const CommentTile({Key? key, required this.name, required this.text, required this.color}) : super(key: key);

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
                  Text(name, style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.kTextColor)),
                  Text('3 days ago', style: const TextStyle(color: Colors.white54, fontSize: 12)),
                ],
              ),
              const SizedBox(height: 6),
              Text(text),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.favorite_border, size: 18, color: Colors.white54),
                  const SizedBox(width: 6),
                  const Text('938', style: TextStyle(color: Colors.white54)),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
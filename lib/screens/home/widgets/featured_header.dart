// import 'package:flutter/material.dart';

// class FeaturedHeader extends StatelessWidget {
//   final String title;
//   final String imageUrl;
//   final double rating;

//   const FeaturedHeader({
//     super.key,
//     required this.title,
//     required this.imageUrl,
//     required this.rating,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 260,
//       width: double.infinity,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(16),
//         image: DecorationImage(
//           image: NetworkImage(imageUrl),
//           fit: BoxFit.cover,
//         ),
//       ),
//       child: Container(
//         padding: const EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(16),
//           gradient: LinearGradient(
//             begin: Alignment.bottomCenter,
//             end: Alignment.topCenter,
//             colors: [
//               Colors.black.withOpacity(0.7),
//               Colors.black.withOpacity(0.0),
//             ],
//           ),
//         ),
//         child: Align(
//           alignment: Alignment.bottomLeft,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Expanded(
//                 child: Text(
//                   title,
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontSize: 22,
//                     fontWeight: FontWeight.bold,
//                     height: 1.1,
//                   ),
//                 ),
//               ),
//               Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
//                 decoration: BoxDecoration(
//                   color: const Color(0xFFE21220),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Text(
//                   rating.toString(),
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

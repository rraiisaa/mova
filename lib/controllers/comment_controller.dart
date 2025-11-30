import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class CommentController extends GetxController {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getComments(String movieId) {
    return _db
        .collection("comments")
        .doc(movieId)
        .collection("items")
        .orderBy("timestamp", descending: true)
        .snapshots();
  }

  Future<void> addComment(String movieId, String text) async {
    await _db.collection("comments").doc(movieId).collection("items").add({
      "name": "Anonymous",
      "text": text,
      "timestamp": DateTime.now(),
    });
  }
}

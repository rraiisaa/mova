import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:mova_app/models/mova_model.dart';

class MyListController extends GetxController {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Real-time list
  RxList<Map<String, dynamic>> myListMovies = <Map<String, dynamic>>[].obs;

  /// Selected category for filtering
  RxString selectedCategory = "All".obs;

  /// Simpan data berdasarkan user yang sedang login
  String get userId => FirebaseAuth.instance.currentUser!.uid;

  @override
  void onInit() {
    super.onInit();
    _listenToMyList();
  }

  /// Listens to firestore in real time
  void _listenToMyList() {
    _db
        .collection("users")
        .doc(userId)
        .collection("myList")
        .orderBy("createdAt", descending: true)
        .snapshots()
        .listen(
          (snapshot) {
            myListMovies.value = snapshot.docs
                .map((doc) => doc.data())
                .toList();
          },
          onError: (e) {
            print("Firestore Listener Error: $e");
          },
        );
  }

  // Save movie to firestore
Future<void> saveMovie(Movie movie) async {
  await _db
      .collection("users")
      .doc(userId)
      .collection("myList")
      .doc(movie.id.toString()) // Menggunakan ID film sebagai Document ID (SUDAH BENAR)
      .set({
        ...movie.toJson(), // Mengambil semua field dari model film
        "media_type": movie.mediaType, // Menimpa/menambahkan media_type
        "createdAt": FieldValue.serverTimestamp(), // Menambahkan timestamp server (SUDAH BENAR)
      });
}


  /// Remove movie
  Future<void> removeMovie(String movieId) async {
    await _db
        .collection("users")
        .doc(userId)
        .collection("myList")
        .doc(movieId)
        .delete();
  }

  /// Check if already saved
  bool isSaved(String movieId) {
    return myListMovies.any((movie) => movie["id"].toString() == movieId);
  }

  /// Filter based on selected category
  List<Map<String, dynamic>> get filteredMovies {
    if (selectedCategory.value == "All") return myListMovies;
    return myListMovies
        .where(
          (movie) =>
              movie["category"]?.toString().toLowerCase() ==
              selectedCategory.value.toLowerCase(),
        )
        .toList();
  }
}

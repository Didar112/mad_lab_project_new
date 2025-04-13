import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> saveBookmark(Map<String, dynamic> article) async {
    final uid = _auth.currentUser?.uid;
    if (uid != null) {
      await _firestore.collection('bookmarks').doc(uid).collection('articles').add(article);
    }
  }

  Stream<QuerySnapshot> getBookmarks() {
    final uid = _auth.currentUser?.uid;
    if (uid != null) {
      return _firestore.collection('bookmarks').doc(uid).collection('articles').snapshots();
    } else {
      return const Stream.empty();
    }
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
 import 'package:firebase_core/firebase_core.dart';
import '../firebase_options.dart';
import 'sports_entry.dart';

class FirestoreHelper {
  FirebaseFirestore _firebaseFirestoreInstance = FirebaseFirestore.instance;

  FirestoreHelper();

  static FirestoreHelper _singleObj = FirestoreHelper();
  static bool _isFirstTime = true;

  static Future<FirestoreHelper> getInstance() async {
    if (_isFirstTime == true) {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      _isFirstTime = false;
    }
    return _singleObj;
  }

  Future saveSportsRecord(SportEntry activity) async {
    _firebaseFirestoreInstance
        .collection("sportsCollection")
        .doc(activity.id.toString())
        .set(activity.toMap());
  }

  Future<List<SportEntry>> getAllGamesData() async {
    List<SportEntry> listGames = [];
    var collectionSports =
        await _firebaseFirestoreInstance.collection("sportsCollection").get();

    for (var doc in collectionSports.docs) {
      listGames.add(SportEntry.fromMap(doc.data()));
    }

    return listGames;
  }
}

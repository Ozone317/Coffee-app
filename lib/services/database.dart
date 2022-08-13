import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_app/models/brew.dart';
import 'package:coffee_app/models/user_model.dart';

class DatabaseService {
  final String? uid;
  DatabaseService(this.uid);

  // collection reference: it is a referece to a particular collection to which
  // you can add data or read from
  final CollectionReference brewCollection = FirebaseFirestore.instance
      .collection('brews'); // 'brews' is just the name for the collection

  Future updateUserData(
      {required String? sugars,
      required String? name,
      required int strength}) async {
    return await brewCollection.doc(uid).set(
      {'sugars': sugars, 'name': name, 'strength': strength},
    );
  }

  // brew list from QuerySnapshot
  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Brew(
          name: doc.get('name') ?? '',
          strength: doc.get('strength') ?? 0,
          sugars: doc.get('sugars') ?? '0');
    }).toList();
  }

  // user data from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        uid, snapshot['name'], snapshot['sugars'], snapshot['strength']);
  }

  // get brews stream
  // QuerySnapshot is the snapshot of the Firestore collection at the time it
  // is called
  Stream<List<Brew>> get brews {
    return brewCollection.snapshots().map(_brewListFromSnapshot);
  }

  // get user doc stream
  Stream<UserData> get userData {
    return brewCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}

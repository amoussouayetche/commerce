import 'package:commerce/consts/consts.dart';

class FirestoreServices {
  //recuperer les info du user
  static getUser(uid) {
    return firestore
        .collection(usersCollection)
        .where('id', isEqualTo: uid)
        .snapshots();
  }
}

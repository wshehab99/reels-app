import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseFireStoreHelper {
  static Future<void> createUser(UserCredential credential) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(credential.user!.uid)
        .set({
      "userId": credential.user!.uid,
      "userImg": "https://cdn-icons-png.flaticon.com/512/21/21104.png",
      "phoneNumber": credential.user!.phoneNumber,
    });
  }
}

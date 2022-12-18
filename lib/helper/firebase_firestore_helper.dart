import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:reels_app/models/user_model.dart';

class FirebaseFireStoreHelper {
  static Future<void> createUser(UserCredential credential) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(credential.user!.uid)
        .set({
      "userId": credential.user!.uid,
      "userImg": "https://cdn-icons-png.flaticon.com/512/21/21104.png",
      "phoneNumber": credential.user!.phoneNumber,
    }).then((value) {
      UserModel.init(UserModel(
          phoneNumber: credential.user!.phoneNumber,
          imgUrl: "https://cdn-icons-png.flaticon.com/512/21/21104.png"));
    });
  }

  static Future<QuerySnapshot<Map<String, dynamic>>> gitVideos() async {
    return await FirebaseFirestore.instance
        .collection('videos')
        .orderBy("date")
        .get();
  }

  static Future<String> uploadVideo(String path) async {
    return await FirebaseStorage.instance
        .ref()
        .child("videos/${path.split("/").last}")
        .putFile(File(path))
        .snapshot
        .ref
        .getDownloadURL();
  }
}

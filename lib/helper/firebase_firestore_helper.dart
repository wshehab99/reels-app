import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:reels_app/models/user_model.dart';
import 'package:reels_app/models/video_model.dart';

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
          userId: credential.user!.uid,
          phoneNumber: credential.user!.phoneNumber,
          imgUrl: "https://cdn-icons-png.flaticon.com/512/21/21104.png"));
    });
  }

  static List<VideoModel> videos = [];
  static Future<List<VideoModel>> gitVideos() async {
    videos.clear();
    print(1);
    QuerySnapshot<Map<String, dynamic>> value = await FirebaseFirestore.instance
        .collection('videos')
        .orderBy("date")
        .get();
    print(2);
    await Future.forEach(value.docs, (element) async {
      DocumentSnapshot<Map<String, dynamic>> user =
          await getUserById(element.data()['userId']);
      Map<String, dynamic> json = element.data();
      json.addAll({"user": user.data()});
      videos.add(VideoModel.fromMap(json: json));
      print(videos);
    });

    return videos;
  }

  static Future<DocumentSnapshot<Map<String, dynamic>>> getUserById(uid) async {
    return await FirebaseFirestore.instance.collection("users").doc(uid).get();
  }

  static Future<void> postVideo({required VideoModel video}) async {
    await FirebaseFirestore.instance.collection('videos').add({
      "title": video.title,
      "videoUrl": video.videoUrl,
      "category": video.category,
      "date": video.date,
      "userId": video.user!.userId,
      "location": video.location,
    });
  }

  static Future<String?> uploadVideo(String path) async {
    final storageRef = FirebaseStorage.instance.ref();
    final mountainsRef = storageRef.child("videos/${path.split("/").last}");

    await mountainsRef.putFile(File(path));
    return await mountainsRef.getDownloadURL();
  }
}

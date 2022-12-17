import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_firestore_helper.dart';

class FireBaseHelper {
  static PhoneAuthCredential? credential;
  static Future init() async {
    FirebaseApp app = await Firebase.initializeApp().whenComplete(() {
      print("completed");
    });
  }

  static Future<void> verifyPhoneNumber(String phoneNumber) async {
    return await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: const Duration(minutes: 1),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  }

  static void verificationCompleted(PhoneAuthCredential credential) {
    print(credential.smsCode);
  }

  static void verificationFailed(FirebaseAuthException exception) {
    print(exception.message);
  }

  static void codeSent(String verificationId, int? resendToken) {
    String smsCode = '';
    credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: smsCode);
  }

  static void codeAutoRetrievalTimeout(String verificationId) {
    print("timeout $verificationId");
  }

  static Future<UserCredential> confirm(String smsCode) async {
    credential = PhoneAuthProvider.credential(
        verificationId: credential!.verificationId!, smsCode: smsCode);
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential!);
    await FirebaseFireStoreHelper.createUser(userCredential);
    return userCredential;
  }

  static Future resendOTP(String phoneNumber) async {
    FirebaseAuth.instance.verifyPhoneNumber(
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
      forceResendingToken: 1,
      phoneNumber: phoneNumber,
    );
  }
}

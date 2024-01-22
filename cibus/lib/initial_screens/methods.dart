// ignore: file_names
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<User?> createAccount(
    String name, String email, String password, String phone) async {
  FirebaseAuth _auth = FirebaseAuth.instance;

  try {
    User? user = (await _auth.createUserWithEmailAndPassword(
            email: email, password: password))
        .user;

    if (user != null) {
      print("account creation successful");
      FirebaseFirestore.instance.collection("users").doc(user.uid).set({
        'uid': user.uid,
        'Name': name,
        'Email': email,
        'Password': password,
        'Phone': phone,
        'identity': "volunteer",
      });
      return user;
    } else {
      print("account creation failed");
      return user;
    }
  } catch (e) {
    print(e);
    return null;
  }
}

Future<User?> logIn(String email, String password) async {
  FirebaseAuth _auth = FirebaseAuth.instance;

  try {
    User? user = (await _auth.signInWithEmailAndPassword(
            email: email, password: password))
        .user;
    if (user != null) {
      print("login successful");

      return user;
    } else {
      print("login failed");
      return user;
    }
  } catch (e) {
    print(e);
    return null;
  }
}

Future logOut() async {
  FirebaseAuth _auth = FirebaseAuth.instance;

  try {
    await _auth.signOut();
  } catch (e) {
    print("error");
  }
}

Future<User?> createOwnAccount(String name, String email, String password,
    String phone, String restname) async {
  FirebaseAuth _auth = FirebaseAuth.instance;

  try {
    User? user = (await _auth.createUserWithEmailAndPassword(
            email: email, password: password))
        .user;

    if (user != null) {
      print("account creation successful");
      FirebaseFirestore.instance.collection("users").doc(user.uid).set({
        'uid': user.uid,
        'Name': name,
        'Email': email,
        'Password': password,
        'Phone': phone,
        'Restaurant': restname,
        'identity': "owner",
      });
      return user;
    } else {
      print("account creation failed");
      return user;
    }
  } catch (e) {
    print(e);
    return null;
  }
}

Future<List<String>> getData(String uid) async {
  DocumentSnapshot valuedata =
      await FirebaseFirestore.instance.collection('users').doc(uid).get();
  String identity = valuedata.get('identity');
  List<String> data = [identity];
  return data;
}

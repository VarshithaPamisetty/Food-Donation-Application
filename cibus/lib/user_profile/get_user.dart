import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseAuth auth = FirebaseAuth.instance;

Future<List<String>> getUserProfile() async {
  final User user = auth.currentUser!;
  final uid = user.uid;
  List<String> data = [];
  DocumentSnapshot valuedata =
      await FirebaseFirestore.instance.collection('users').doc(uid).get();
  String identity = valuedata.get('identity');
  if (identity == "owner") {
    String ownerName = valuedata.get('Name');
    String phone = valuedata.get('Phone');
    String email = valuedata.get('Email');
    data = [ownerName, phone, email, identity];
  } else if (identity == "volunteer") {
    String name = valuedata.get('Name');
    String phone = valuedata.get('Phone');
    String email = valuedata.get('Email');
    data = [name, phone, email, identity];
  }
  return data;
}

//Future<List<String>> UpdateVolProfile(
//    String name, String phone, String email) async {
 // final User user = auth.currentUser!;
 // final uid = user.uid;
 // List<String> data = [];
//  FirebaseFirestore.instance.collection("users").doc(user.uid).set({
 //   'uid': user.uid,
 //   'Name': name,
  //  'Phone': phone,
//    'Email': email,
 //   'identity': "volunteer",
 // });
 // return data;
//}


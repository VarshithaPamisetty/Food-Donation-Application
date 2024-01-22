import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<User?> databaseEntry(
    String time, String quantity, String address) async {
  FirebaseAuth _auth = FirebaseAuth.instance;

  try {
    final User? user = (_auth.currentUser!);

    if (user != null) {
      print("data entry successful");
      var identity = await getRestaurantName(user.uid);
      FirebaseFirestore.instance.collection("donation data").doc(user.uid).set({
        'uid': user.uid,
        'restaurant': identity[0],
        'time': time,
        'quantity': quantity,
        'address': address,
      });
      return user;
    } else {
      print("data entry failed");
      return user;
    }
  } catch (e) {
    print(e);
    return null;
  }
}

Future<List<String>> getRestaurantName(String uid) async {
  DocumentSnapshot valuedata =
      await FirebaseFirestore.instance.collection('users').doc(uid).get();
  String identity = valuedata.get('Restaurant');
  List<String> data = [identity];
  return data;
}

import 'package:cibus/initial_screens/login_screen.dart';
import 'package:cibus/user_profile/get_user.dart';
import 'package:cibus/user_profile/profile.dart';
import 'package:cibus/volunteer/retrieve_voldata.dart';
import 'package:cibus/volunteer/selected_restaurant.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class VolunteerHome extends StatefulWidget {
  const VolunteerHome({Key? key}) : super(key: key);

  @override
  _VolunteerHomeState createState() => _VolunteerHomeState();
}

class _VolunteerHomeState extends State<VolunteerHome> {
  List userProfilesList = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF76ACD2),
      appBar: AppBar(
        title: const Text("Cibus",
            style: TextStyle(
                color: Color(0xFF1A1A1A), fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF76ACD2),
        iconTheme: const IconThemeData(color: Color(0xFF1A1A1A)),
      ),
      drawer: _buildDrawer(context),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("donation data")
              .snapshots(),
          builder: (context, snapshot) {
            try {
              if (snapshot.hasError) {
                return const Text('Something went wrong');
              } else if (snapshot.hasData || snapshot.data != null) {
                print(snapshot);
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data?.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      QueryDocumentSnapshot<Object?>? documentSnapshot =
                          snapshot.data?.docs[index];
                      return Dismissible(
                          key: Key(index.toString()),
                          child: Card(
                            elevation: 4,
                            child: ListTile(
                              title: Text((documentSnapshot != null)
                                  ? (documentSnapshot['restaurant'])
                                  : ""),
                              subtitle: Text((documentSnapshot != null)
                                  ? ((documentSnapshot['quantity'] != null)
                                      ? documentSnapshot['quantity']
                                      : "")
                                  : ""),
                              trailing: IconButton(
                                icon: const Icon(Icons.arrow_forward),
                                color: const Color(0xFF1A1A1A),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => SelectedRestaurant(
                                                address: documentSnapshot![
                                                    'address'],
                                                quantity: documentSnapshot[
                                                    'quantity'],
                                                restName: documentSnapshot[
                                                    'restaurant'],
                                                userid: documentSnapshot['uid'],
                                              )));
                                },
                              ),
                            ),
                          ));
                    });
              }
            } catch (e) {
              print("state error");
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}

Drawer _buildDrawer(BuildContext context) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
            decoration: const BoxDecoration(
              color: Color(0xFF76ACD2),
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Stack(
                children: const <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: CircleAvatar(
                      backgroundImage: AssetImage("assets/images/user.png"),
                      radius: 50.0,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'Volunteer',
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                  ),
                ],
              ),
            )),
        ListTile(
          title: const Text('Home'),
          leading: const Icon(Icons.house_outlined),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => const VolunteerHome()));
          },
        ),
        ListTile(
          title: const Text('Profile'),
          leading: const Icon(Icons.person),
          onTap: () async {
            var identity = await getUserProfile();
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => Profile(
                        name: identity[0],
                        phone: identity[1],
                        email: identity[2],
                        identity: "Volunteer")));
          },
        ),
        ListTile(
          title: const Text('Logout'),
          leading: const Icon(Icons.logout),
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => LoginScreen()));
          },
        ),
      ],
    ),
  );
}

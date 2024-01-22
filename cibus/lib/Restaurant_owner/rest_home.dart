import 'package:cibus/Restaurant_owner/donate_food.dart';
import 'package:cibus/initial_screens/login_screen.dart';
import 'package:cibus/user_profile/get_user.dart';
import 'package:cibus/user_profile/profile.dart';
import 'package:flutter/material.dart';

class RestHome extends StatefulWidget {
  const RestHome({Key? key}) : super(key: key);

  @override
  _RestHomeState createState() => _RestHomeState();
}

class _RestHomeState extends State<RestHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF76ACD2),
        appBar: AppBar(
          title: const Text('Cibus',
              style: TextStyle(
                  color: Color(0xFF1A1A1A), fontWeight: FontWeight.bold)),
          backgroundColor: const Color(0xFF76ACD2),
          iconTheme: const IconThemeData(color: Color(0xFF1A1A1A)),
        ),
        body: Center(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 100.0),
                child: Text(
                  'Want to share food?',
                  style: TextStyle(
                      color: Color(0xFF1A1A1A),
                      fontWeight: FontWeight.bold,
                      fontSize: 24),
                ),
              ),
              GestureDetector(
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(60),
                      image: const DecorationImage(
                          image: AssetImage("assets/images/donate.png"),
                          fit: BoxFit.cover),
                    ),
                  ),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const DonateFood()));
                  }),
              // ignore: avoid_unnecessary_containers
              Container(
                child: const Text(
                  'Click! to donate',
                  style: TextStyle(
                      color: Color(0xFF1A1A1A),
                      fontWeight: FontWeight.bold,
                      fontSize: 24),
                ),
              )
            ],
          ),
        ),
        drawer: _buildDrawer(context));
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
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => const RestHome()));
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
                        identity: "Restaurant Owner")));
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

import 'package:cibus/initial_screens/login_screen.dart';
import 'package:cibus/maps/mymap.dart';
import 'package:cibus/initial_screens/methods.dart';
import 'package:cibus/user_profile/get_user.dart';
import 'package:cibus/user_profile/profile.dart';
import 'package:cibus/volunteer/volunteer_home.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderAccepted extends StatefulWidget {
  final String restName;
  final String address;
  final String quantity;
  final String userid;
  const OrderAccepted(
      {Key? key,
      required this.restName,
      required this.address,
      required this.quantity,
      required this.userid})
      : super(key: key);

  @override
  _OrderAcceptedState createState() => _OrderAcceptedState();
}

class _OrderAcceptedState extends State<OrderAccepted> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFF76ACD2),
      drawer: _buildDrawer(context),
      appBar: AppBar(
        title: const Text('Cibus',
            style: TextStyle(
                color: Color(0xFF1A1A1A), fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF76ACD2),
        iconTheme: const IconThemeData(color: Color(0xFF1A1A1A)),
        actions: [],
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: size.height / 15,
            ),
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: const Color(0xFF76ACD2),
                borderRadius: BorderRadius.circular(80),
                image: const DecorationImage(
                  image: AssetImage("assets/images/rest_owner.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              height: size.height / 20,
            ),
            Container(
              child: const Text(
                'Donation Order!!',
                style: TextStyle(
                    color: Color(0xFF1A1A1A),
                    fontWeight: FontWeight.bold,
                    fontSize: 24),
              ),
            ),
            Container(
                child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              child: Text(
                "Restaurant name: " + widget.restName,
                style: const TextStyle(color: Color(0xFF1A1A1A), fontSize: 20),
              ),
            )),
            Container(
                child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              child: Text(
                "Quantity: " + widget.quantity,
                style: const TextStyle(color: Color(0xFF1A1A1A), fontSize: 20),
              ),
            )),
            Container(
                child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              child: Text(
                "Address: " + widget.address,
                style: const TextStyle(color: Color(0xFF1A1A1A), fontSize: 20),
              ),
            )),
            SizedBox(
              height: size.height / 20,
            ),
            customButton1(size, context),
            SizedBox(
              height: size.height / 20,
            ),
            customButton2(size, context),
          ],
        ),
      ),
    );
  }
}

Widget customButton1(Size size, BuildContext context) {
  return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => MapScreen()));
      },
      child: Container(
        height: size.height / 15,
        width: size.width / 1.2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color(0xFF1A1A1A),
        ),
        alignment: Alignment.center,
        child: const Text(
          "View Map",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ));
}

Widget customButton2(Size size, BuildContext context) {
  return GestureDetector(
      onTap: () {},
      child: Container(
        height: size.height / 15,
        width: size.width / 1.2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color(0xFF8FD14F),
        ),
        alignment: Alignment.center,
        child: const Text(
          "Accepted",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ));
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
                          identity: "Volunteer",
                        )));
          },
        ),
        ListTile(
          title: const Text('Logout'),
          leading: const Icon(Icons.logout),
          onTap: () {
            logOut();
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => LoginScreen()));
          },
        ),
      ],
    ),
  );
}

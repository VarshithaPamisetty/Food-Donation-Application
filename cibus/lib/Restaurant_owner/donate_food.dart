import 'package:cibus/Restaurant_owner/donate_successful.dart';
import 'package:cibus/Restaurant_owner/donate_unsuccessful.dart';
import 'package:cibus/Restaurant_owner/rest_home.dart';
import 'package:cibus/initial_screens/login_screen.dart';
import 'package:cibus/user_profile/get_user.dart';
import 'package:cibus/user_profile/profile.dart';
import 'package:flutter/material.dart';

import '../initial_screens/own_account.dart';
import 'data_entry_methods.dart';

class DonateFood extends StatefulWidget {
  const DonateFood({Key? key}) : super(key: key);

  @override
  _DonateFoodState createState() => _DonateFoodState();
}

class _DonateFoodState extends State<DonateFood> {
  final TextEditingController _time = TextEditingController();
  final TextEditingController _quantity = TextEditingController();
  final TextEditingController _address = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Color(0xFF76ACD2),
        drawer: _buildDrawer(context),
        appBar: AppBar(
          title: const Text('Cibus',
              style: TextStyle(
                  color: Color(0xFF1A1A1A),
                  fontWeight: FontWeight.bold,
                  fontSize: 23)),
          backgroundColor: const Color(0xFF76ACD2),
          iconTheme: const IconThemeData(color: Color(0xFF1A1A1A)),
          actions: [
            Container(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 3.0, horizontal: 3),
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      width: size.width / 9,
                      height: size.height / 18,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Color(0xFF1A1A1A),
                      ),
                      child: IconButton(
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                          onPressed: () {}),
                    )),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 48.0),
            child: Column(children: [
              SizedBox(
                height: size.height / 20,
              ),
              Container(
                width: size.width / 1.3,
                child: const Text(
                  "Donate Food",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: size.height / 20,
              ),
              Container(
                width: size.width / 1.4,
                height: size.width / 7.5,
                color: Colors.white,
                alignment: Alignment.center,
                child: TextFormField(
                    cursorColor: Color(0xFF1A1A1A),
                    controller: _time,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(
                        Icons.timer,
                        color: Color(0xFF1A1A1A),
                      ),
                      hintText: 'Pickup Time',
                    ),
                    style: const TextStyle(
                      color: Color(0xFF1A1A1A),
                    )),
              ),
              SizedBox(
                height: size.height / 20,
              ),
              Container(
                width: size.width / 1.4,
                height: size.width / 7.5,
                color: Colors.white,
                alignment: Alignment.center,
                child: TextFormField(
                    cursorColor: Color(0xFF1A1A1A),
                    controller: _quantity,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(
                        Icons.people,
                        color: Color(0xFF1A1A1A),
                      ),
                      hintText: 'Sufficient for',
                    ),
                    style: const TextStyle(
                      color: Color(0xFF1A1A1A),
                    )),
              ),
              SizedBox(
                height: size.height / 20,
              ),
              Container(
                width: size.width / 1.4,
                height: size.width / 6.5,
                color: Colors.white,
                alignment: Alignment.center,
                child: TextFormField(
                    cursorColor: Color(0xFF1A1A1A),
                    controller: _address,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(
                        Icons.gps_not_fixed,
                        color: Color(0xFF1A1A1A),
                      ),
                      hintText: 'pick up location',
                    ),
                    style: const TextStyle(
                      color: Color(0xFF1A1A1A),
                    )),
              ),
              SizedBox(
                height: size.height / 20,
              ),
              customButton(
                  size, _time, _quantity, _address, isLoading, context),
            ])));
  }
}

Widget customButton(
    Size size,
    TextEditingController _time,
    TextEditingController _quantity,
    TextEditingController _address,
    bool isLoading,
    BuildContext context) {
  return GestureDetector(
      onTap: () {
        if (_time.text.isNotEmpty &&
            _quantity.text.isNotEmpty &&
            _address.text.isNotEmpty) {
          setState(() {
            isLoading = true;
          });

          databaseEntry(_time.text, _quantity.text, _address.text).then((user) {
            if (user != null) {
              setState(() {
                isLoading = false;
              });
              print("data entry successful");
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const DonateSuccessful()));
            } else {
              print("data entry failed");
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const DonateUnsuccessful()));
            }
          });
        } else {
          print("please enter fields");
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => const DonateUnsuccessful()));
        }
      },
      child: Container(
        height: size.height / 15,
        width: size.width / 2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color(0xFF1A1A1A),
        ),
        alignment: Alignment.center,
        child: const Text(
          "Donate",
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
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => const RestHome()));
          },
        ),
        ListTile(
          title: const Text('Profile'),
          leading: const Icon(Icons.logout),
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
          leading: const Icon(Icons.person),
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => LoginScreen()));
          },
        ),
      ],
    ),
  );
}

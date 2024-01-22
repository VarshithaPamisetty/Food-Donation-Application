import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  final String name;
  final String phone;
  final String email;
  final String identity;
  const Profile(
      {Key? key,
      required this.name,
      required this.phone,
      required this.email,
      required this.identity})
      : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFF76ACD2),
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Cibus',
            style: TextStyle(
              color: Color(0xFF1A1A1A),
              fontWeight: FontWeight.bold,
            )),
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF76ACD2),
        iconTheme: const IconThemeData(color: Color(0xFF1A1A1A)),
        actions: [
          Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 3),
              child: Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    width: size.width / 9,
                    height: size.height / 18,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: const Color(0xFF1A1A1A),
                    ),
                    child: IconButton(
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                  )),
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: size.height / 15,
            ),
            Container(
              child: Text(
                widget.identity,
                style: const TextStyle(
                    color: Color(0xFF1A1A1A),
                    fontWeight: FontWeight.bold,
                    fontSize: 24),
              ),
            ),
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: const Color(0xFF76ACD2),
                borderRadius: BorderRadius.circular(80),
                image: const DecorationImage(
                  image: AssetImage("assets/images/user.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              height: size.height / 20,
            ),
            Container(
                child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              child: Text(
                "Name: " + widget.name,
                style: const TextStyle(color: Color(0xFF1A1A1A), fontSize: 20),
              ),
            )),
            Container(
                child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              child: Text(
                "Phone: " + widget.phone,
                style: const TextStyle(color: Color(0xFF1A1A1A), fontSize: 20),
              ),
            )),
            Container(
                child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              child: Text(
                "Email: " + widget.email,
                style: const TextStyle(color: Color(0xFF1A1A1A), fontSize: 20),
              ),
            )),
            SizedBox(
              height: size.height / 20,
            ),
            SizedBox(
              height: size.height / 20,
            ),
          ],
        ),
      ),
    );
  }
}

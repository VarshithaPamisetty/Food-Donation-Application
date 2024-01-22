// ignore_for_file: use_key_in_widget_constructors

import 'package:cibus/Restaurant_owner/rest_home.dart';
import 'package:cibus/initial_screens/own_account.dart';
import 'package:cibus/initial_screens/vol_account.dart' as prefix;
import 'package:cibus/volunteer/volunteer_home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'choice.dart';
import 'package:flutter/material.dart';
import 'methods.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool isLoading = false;
  var userData;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xFF76ACD2),
      body: isLoading
          ? Center(
              child: Container(
                  height: size.height / 20,
                  width: size.height / 20,
                  child: CircularProgressIndicator()),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 33.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: size.height / 20,
                    ),
                    SizedBox(
                      height: size.height / 20,
                    ),
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: Color(0xFF76ACD2),
                        borderRadius: BorderRadius.circular(80),
                        image: const DecorationImage(
                          image: AssetImage("assets/images/logo.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height / 10,
                    ),
                    Container(
                      width: size.width / 1.3,
                      child: const Text(
                        "Sign In",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height / 10,
                    ),
                    Container(
                      width: size.width / 1.4,
                      height: size.width / 7.5,
                      color: Colors.white,
                      alignment: Alignment.center,
                      child: TextFormField(
                          cursorColor: Color(0xFF1A1A1A),
                          controller: _email,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(
                              Icons.email_rounded,
                              color: Color(0xFF1A1A1A),
                            ),
                            hintText: 'Email',
                          ),
                          style: const TextStyle(
                            color: Color(0xFF1A1A1A),
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 18.0),
                      child: Container(
                        width: size.width / 1.4,
                        height: size.width / 7.5,
                        color: Colors.white,
                        alignment: Alignment.center,
                        child: TextFormField(
                            obscureText: true,
                            cursorColor: Color(0xFF1A1A1A),
                            controller: _password,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(
                                Icons.password_rounded,
                                color: Color(0xFF1A1A1A),
                              ),
                              hintText: 'Password',
                            ),
                            style: const TextStyle(
                              color: Color(0xFF1A1A1A),
                            )),
                      ),
                    ),
                    SizedBox(
                      height: size.height / 10,
                    ),
                    customButton(size, _email, _password, isLoading, context),
                    SizedBox(
                      height: size.height / 40,
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const Choice())),
                      child: const Text(
                        "Create Account",
                        style: TextStyle(
                          color: Color(0xFF1A1A1A),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}

Widget customButton(Size size, TextEditingController _email,
    TextEditingController _password, bool isLoading, BuildContext context) {
  return GestureDetector(
      onTap: () {
        if (_email.text.isNotEmpty && _password.text.isNotEmpty) {
          setState(() {
            isLoading = true;
          });

          logIn(_email.text, _password.text).then((user) async {
            if (user != null) {
              setState(() {
                isLoading = false;
              });
              print("login successful");
              var identity = await getData(user.uid);
              if (identity[0] == 'owner') {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const RestHome()));
              } else if (identity[0] == 'volunteer') {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const VolunteerHome()));
              }
            } else {
              print("login failed");
            }
          });
        } else {
          print("please enter fields");
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
          "Login",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ));
}

Widget field(
    Size size, String hintText, IconData icon, TextEditingController cont) {
  return Container(
      height: size.height / 15,
      width: size.width / 1.3,
      child: TextField(
        controller: cont,
        decoration: InputDecoration(
            prefixIcon: Icon(icon),
            hintText: hintText,
            hintStyle: const TextStyle(
              color: Color(0xFF1A1A1A),
            ),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
      ));
}

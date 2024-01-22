import 'package:cibus/initial_screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'methods.dart';

class VolAccount extends StatefulWidget {
  const VolAccount({Key? key}) : super(key: key);

  @override
  _VolAccountState createState() => _VolAccountState();
}

class _VolAccountState extends State<VolAccount> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  bool isLoading = false;
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
                child: CircularProgressIndicator(),
              ),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 33.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: size.height / 20,
                    ),
                    Align(
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
                              onPressed: () {
                                Navigator.pop(context);
                              }),
                        )),
                    SizedBox(
                      height: size.height / 50,
                    ),
                    Container(
                      width: size.width / 1.3,
                      child: const Text(
                        "Sign Up",
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
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Container(
                        width: size.width / 1.4,
                        height: size.width / 7.5,
                        color: Colors.white,
                        alignment: Alignment.center,
                        child: TextFormField(
                            cursorColor: Color(0xFF1A1A1A),
                            controller: _name,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(
                                Icons.account_circle,
                                color: Color(0xFF1A1A1A),
                              ),
                              hintText: 'Name',
                            ),
                            style: const TextStyle(
                              color: Color(0xFF1A1A1A),
                            )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Container(
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
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Container(
                        width: size.width / 1.4,
                        height: size.width / 7.5,
                        color: Colors.white,
                        alignment: Alignment.center,
                        child: TextFormField(
                            cursorColor: Color(0xFF1A1A1A),
                            controller: _phone,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(
                                Icons.phone,
                                color: Color(0xFF1A1A1A),
                              ),
                              hintText: 'Phone',
                            ),
                            style: const TextStyle(
                              color: Color(0xFF1A1A1A),
                            )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Container(
                        width: size.width / 1.4,
                        height: size.width / 7.5,
                        color: Colors.white,
                        alignment: Alignment.center,
                        child: TextFormField(
                            cursorColor: Color(0xFF1A1A1A),
                            obscureText: true,
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
                      height: size.height / 20,
                    ),
                    customButton(size, context, _name, _email, _password,
                        _phone, isLoading),
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: GestureDetector(
                          onTap: () => Navigator.push(context,
                              MaterialPageRoute(builder: (_) => LoginScreen())),
                          child: const Text(
                            "Login",
                            style: TextStyle(
                              color: Color(0xFF1A1A1A),
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )),
                    SizedBox(
                      height: size.height / 40,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

Widget customButton(
    Size size,
    BuildContext context,
    TextEditingController _name,
    TextEditingController _email,
    TextEditingController _password,
    TextEditingController _phone,
    bool isLoading) {
  return GestureDetector(
      onTap: () {
        if (_name.text.isNotEmpty &&
            _email.text.isNotEmpty &&
            _password.text.isNotEmpty &&
            _phone.text.isNotEmpty) {
          setState(() {
            isLoading = true;
          });

          createAccount(_name.text, _email.text, _password.text, _phone.text)
              .then((user) {
            if (user != null) {
              setState(() {
                isLoading = false;
              });
              print("login successful");
              onTap:
              () => Navigator.push(
                  context, MaterialPageRoute(builder: (_) => LoginScreen()));
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
          "Create Account",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ));
}

void setState(Null Function() param0) {}

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
            hintStyle: TextStyle(color: Colors.grey),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
      ));
}

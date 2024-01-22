import 'package:cibus/initial_screens/own_account.dart';
import 'package:cibus/initial_screens/vol_account.dart';
import 'package:flutter/material.dart';

class Choice extends StatefulWidget {
  const Choice({Key? key}) : super(key: key);

  @override
  _ChoiceState createState() => _ChoiceState();
}

class _ChoiceState extends State<Choice> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Color(0xFF76ACD2),
        body: SingleChildScrollView(
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
                      height: size.height / 4,
                    ),
                    Container(child: customButton1(size, context)),
                    SizedBox(
                      height: size.height / 20,
                    ),
                    Container(child: customButton2(size, context)),
                    SizedBox(
                      height: size.height / 40,
                    ),
                  ],
                ))));
  }

  padding(Column column) {}
}

Widget customButton1(Size size, BuildContext context) {
  return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => const OwnAccount()));
      },
      child: Container(
        height: size.height / 15,
        width: size.width / 2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color(0xFF1A1A1A),
        ),
        alignment: Alignment.center,
        child: const Text(
          "Restaurant owner",
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
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => const VolAccount()));
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
          "volunteer",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ));
}

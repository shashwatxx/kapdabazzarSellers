import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kapdabazzarsellers/const.dart';
import 'package:kapdabazzarsellers/mywidgets/softtextfield.dart';
import 'package:kapdabazzarsellers/pages/register.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool _showpassword = false;

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: Text(
                    "Welcome to",
                    style: GoogleFonts.lacquer(color: mycolor),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      "assets/splash.png",
                      // scale: 5,
                      height: 50,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Kapdabazzar Sellers",
                      style: GoogleFonts.offside(
                          fontSize: _width * 0.07, color: mycolor),
                    )
                  ],
                ),
                SizedBox(
                  height: 70,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: Text("E-mail"),
                ),
                SizedBox(
                  height: 20,
                ),
                SoftUiTextField(
                  hintText: "Enter your E-mail here..",
                  validator: (String value) {
                    if (value.isEmpty ||
                        !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                            .hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                  },
                  // autofocus: true,
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: Text("Password"),
                ),
                SizedBox(
                  height: 20,
                ),
                SoftUiTextField(
                  hintText: "Enter your Password here..",
                  obscureText: !_showpassword,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Checkbox(
                        value: _showpassword,
                        onChanged: (bool value) {
                          setState(() {
                            _showpassword = value;
                          });
                        }),
                    Text(
                      'Show Password',
                    ),
                    SizedBox(
                      width: 30,
                    )
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: CupertinoButton(
                          color: mycolor,
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, '/homepage');
                          },
                          child: Text("Log In"),
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => RegisterPage(),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: Text(
                        "New at Kapdabazzar?? Register here..",
                        style: GoogleFonts.montserrat(color: mycolor),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

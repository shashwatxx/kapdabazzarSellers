import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kapdabazzarsellers/mywidgets/softtextfield.dart';
import 'package:kapdabazzarsellers/pages/home.dart';

import '../const.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordTextController = TextEditingController();
  bool _showpassword = false;
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            Image.asset(
              'assets/splash.png',
              height: _width * 0.08,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              "KapdaBazzar Seller",
              style: GoogleFonts.offside(color: mycolor),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Form(key:_formKey ,
                          child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Register Here As Seller',
                      style: GoogleFonts.offside(
                          fontSize: _width * 0.07, color: mycolor),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Divider(),
                  Align(
                    child: Text(
                      "Basic Info",
                      style: GoogleFonts.offside(fontSize: 20),
                    ),
                  ),
                  Divider(),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25),
                    child: Text("Seller Name"),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SoftUiTextField(
                    hintText: "Enter Seller Name here..",
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25),
                    child: Text("Shop Name"),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SoftUiTextField(
                    hintText: "Enter your Shop Name here...",
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25),
                    child: Text("E-mail"),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SoftUiTextField(
                    hintText: "Enter your E-mail here...",
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
                    hintText: "Enter your Password here...",
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
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25),
                    child: Text("E-mail"),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SoftUiTextField(
                    hintText: "Enter your E-mail here...",
                  ),
                  SoftUiTextField(),
                  SoftUiTextField(),
                  SoftUiTextField(),
                  SoftUiTextField(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kapdabazzarsellers/const.dart';
import 'package:kapdabazzarsellers/mywidgets/softtextfield.dart';
import 'package:kapdabazzarsellers/pages/noconn.dart';
import 'package:kapdabazzarsellers/pages/register.dart';
import 'package:kapdabazzarsellers/scoped-models/main.dart';
import 'package:scoped_model/scoped_model.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  // final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String email;
  String password;

  bool _showpassword = false;

  _submitForm(
      MainModel model, String email, String password, BuildContext context) {
    if (email.isNotEmpty) {
      model.signinUser(email, password, context);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Center(child: ScopedModelDescendant(
          builder: (BuildContext context, Widget child, MainModel model) {
            model.checkNetwork();
            if (model.isConnected == true) {
              if (model.isLoading == true) {
                return FlareActor(
                  'assets/kapdamyani2.flr',
                  animation: 'idle',
                  fit: BoxFit.contain,
                );
              }
              return SingleChildScrollView(
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
                      onChanged: (String value) {
                        setState(() {
                          email = value;
                          print(email);
                        });
                      },
                      hintText: "Enter your E-mail here..",
                      keyboardType: TextInputType.emailAddress,
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
                      onChanged: (String value) {
                        setState(() {
                          password = value;
                          print(password);
                        });
                      },
                      hintText: "Enter your Password here..",
                      obscureText: !_showpassword,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return "Invalid Password";
                        }
                      },
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
                              _submitForm(model, email, password, context);
                            },
                            child: Text("Log In"),
                          )),
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
                              builder: (BuildContext context) => RegisterPage(
                                model: model,
                              ),
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
              );
            } else {
              return NoConnectionPage();
              // Navigator.pushReplacement(
              //   context,
              //   MaterialPageRoute(
              //     builder: (BuildContext context) => NoConnectionPage(),
              //   ),
              // );
            }
          },
        )),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../const.dart';

class RegistrationDonePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double _width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
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
              height: 40,
            ),
            Text(
              "Thank-you For registering\n with Kapdabazzar Sellers",
              style: GoogleFonts.montserrat(fontSize: _width * 0.06),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Your Registeration Request is Submitted Successfully \n You'll get an email after the confirmation of your Registration Shortly\n Once you are accepted then you can \nstart uploading Your products",
              style: GoogleFonts.montserrat(fontSize: _width * 0.04),
              textAlign: TextAlign.center,
              softWrap: true,
            ),
            FlatButton.icon(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/');
              },
              icon: Icon(Icons.chevron_right),
              label: Text("OK"),
              color: mycolor,
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            )
          ],
        )),
      ),
    );
  }
}

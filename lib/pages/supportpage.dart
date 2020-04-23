import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kapdabazzarsellers/const.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportPages extends StatelessWidget {
// _launchURL() async {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  _launchURLCall1() async {
    String url = 'tel:+919131246125';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could no launch $url';
    }
  }

  _launchURLCall2() async {
    String url = 'tel:+917400840088';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could no launch $url';
    }
  }

  _launchURLMail1() async {
    String url = 'mailto:admin@kapdabazzar.com?subject=Need Support';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could no launch $url';
    }
  }

  _launchURLMail2() async {
    String url = 'mailto:kapdabazzar775@gmail.com?subject=Need Support';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could no launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    var card = Card(
      margin: EdgeInsets.all(50),
      elevation: 10,
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.circular(40),
      ),
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 15,
            ),
            Text(
              "For Support & Info\n",
              style: TextStyle(
                  color: Colors.redAccent,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: GestureDetector(
                onTap: _launchURLCall1,
                child: Text(
                  '+919131246125',
                  style: TextStyle(color: Colors.blueGrey, fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: GestureDetector(
                onTap: _launchURLCall2,
                child: Text(
                  '+917400840088',
                  style: TextStyle(color: Colors.blueGrey, fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: GestureDetector(
                onTap: _launchURLMail1,
                child: Text(
                  'admin@kapdabazzar.com',
                  style: TextStyle(color: Colors.blueGrey, fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: GestureDetector(
                onTap: _launchURLMail2,
                child: Text(
                  'kapdabazzar775@gmail.com',
                  style: TextStyle(color: Colors.blueGrey, fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            // MaterialButton(
            //   color: Colors.orangeAccent,
            //   child: Text(
            //     "Go Back",
            //     style: TextStyle(color: Colors.white),
            //   ),
            //   onPressed: () {
            //     Navigator.pop(context);
            //   },
            // ),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.keyboard_backspace),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            InkWell(
              onTap: () {
                if (_scaffoldKey.currentState.isDrawerOpen) {
                  _scaffoldKey.currentState.openEndDrawer();
                } else {
                  _scaffoldKey.currentState.openDrawer();
                }
              },
              child: Image.asset(
                'assets/splash.png',
                width: width * 0.1,
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              'KapdaBazzar Sellers',
              style: GoogleFonts.offside(color: mycolor),
            )
          ],
        ),
      ),
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 0.0),
                  // child: Image.asset("assets/image_01.png"),
                ),
                Expanded(
                  child: Container(),
                ),
                // Image.asset("assets/image_02.png")
              ],
            ),
            Center(
              child: card,
            ),
          ],
        ),
      ),
    );
  }
}

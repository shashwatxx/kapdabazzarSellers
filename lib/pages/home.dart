import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kapdabazzarsellers/mywidgets/drawer.dart';
import 'package:kapdabazzarsellers/mywidgets/statdislay.dart';
import 'package:kapdabazzarsellers/pages/product.dart';
import 'package:kapdabazzarsellers/scoped-models/main.dart';
import 'package:scoped_model/scoped_model.dart';
import '../const.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String _animation = 'rotate';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size mysize = MediaQuery.of(context).size;
    // TextStyle mystyle = TextStyle(fontSize: mysize.width * 0.05);
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent,
      ),
    );

    return ScopedModelDescendant(
      builder: (BuildContext context, Widget child, MainModel model) {
        return Scaffold(
          key: _scaffoldKey,
          drawer: MyDrawer(
            model: model,
          ),
          backgroundColor: Colors.white,
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.white,
            title: Text(
              "KapdaBazzar",
              style: GoogleFonts.bitter(
                  fontSize: 30, color: mycolor, letterSpacing: 2),
            ),
            leading: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: InkWell(
                onTap: () {
                  if (_scaffoldKey.currentState.isDrawerOpen) {
                    setState(() {
                      _animation = 'rotate';
                    });
                    _scaffoldKey.currentState.openEndDrawer();
                  } else {
                    setState(() {
                      _animation = 'rotate';
                    });
                    _scaffoldKey.currentState.openDrawer();
                  }
                },
                child: FlareActor("assets/kapdabazzar.flr",
                    alignment: Alignment.center,
                    fit: BoxFit.cover,
                    animation: _animation),
              ),
            ),
          ),
          body: SafeArea(
              child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                      child: Text(
                        "Welcome PANKAJ",
                        style: GoogleFonts.annieUseYourTelescope(
                          fontSize: 40,
                        ),
                      ),
                      // color: Colors.lightBlueAccent.shade100,
                    ),
                    Divider(
                      color: mycolor,
                    ),
                    StatDisplayROw(
                      mysize: mysize,
                      heading: "ORDERS",
                      icon: Icons.open_in_browser,
                      stat1: "45",
                      stat2: '19361',
                      stat1Detail: 'Total Orders',
                      stat2Detail: 'Value of Orders',
                    ),
                    Divider(
                      color: mycolor,
                    ),
                    StatDisplayROw(
                      mysize: mysize,
                      heading: "PRODUCTS",
                      icon: Icons.offline_pin,
                      stat1: "908",
                      stat2: '350',
                      stat1Detail: 'Total',
                      stat2Detail: 'Active',
                      // sizedBoxwidth: 40,
                    ),
                    Divider(
                      color: mycolor,
                    ),
                    StatDisplayROw(
                      mysize: mysize,
                      heading: "PAYOUT",
                      icon: Icons.account_balance_wallet,
                      stat1: "₹ 24040",
                      stat2: '₹ 18077',
                      stat1Detail: '7th June 2019',
                      stat2Detail: 'Next Payout',
                    ),
                    Divider(
                      color: mycolor,
                    ),
                    StatDisplayROw(
                      mysize: mysize,
                      heading: "CUSTOMER \nREVIEWS",
                      icon: Icons.open_in_browser,
                      stat1: "0",
                      stat2: '2.69',
                      stat1Detail: 'Last order review',
                      stat2Detail: 'Average Rating',
                    ),
                    Divider(
                      color: mycolor,
                    ),
                    StatDisplayROw(
                      mysize: mysize,
                      heading: "RETURNS",
                      icon: Icons.reply,
                      stat1: "3",
                      // stat2: '2.69',
                      stat1Detail: 'Returns',
                      // stat2Detail: 'Average Rating',
                    ),
                    Divider(
                      color: mycolor,
                    ),
                  ],
                ),
              ),
            ),
          )),
        );
      },
    );
  }
}

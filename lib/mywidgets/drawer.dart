import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kapdabazzarsellers/pages/product.dart';
import 'package:kapdabazzarsellers/scoped-models/main.dart';

import '../const.dart';

class MyDrawer extends StatefulWidget {
  MyDrawer({this.model});
  final MainModel model;

  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        backgroundColor: mycolor,
                        backgroundImage: AssetImage('assets/splash.png'),
                      ),
                    ),
                    Text(
                      "Pankaj Chawla",
                      style: GoogleFonts.offside(
                          color: Colors.white, fontSize: width * 0.05),
                    ),
                  ],
                ),
              ],
            ),
            decoration: BoxDecoration(color: mycolor),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text("Home"),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/homepage');
            },
          ),
          ListTile(
            leading: Icon(Icons.present_to_all),
            title: Text(
              "My Products",
            ),
            subtitle: Text("View all your products here..."),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => ProductPage(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.add),
            title: Text("Add Product"),
            subtitle: Text("Quickly Add new product here..."),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/homepage');
            },
          ),
          ListTile(
            leading: Icon(Icons.open_in_browser),
            title: Text("Orders"),
            subtitle: Text("View all your Orders here..."),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/homepage');
            },
          ),
          ListTile(
            leading: Icon(Icons.call),
            title: Text("Support"),
            subtitle: Text("For any kind of support..."),
            onTap: () {
              Navigator.pushNamed(context, '/support');
            },
          ),
          ListTile(
            leading: Icon(Icons.info_outline),
            title: Text("About"),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/homepage');
            },
          ),
        ],
      ),
    );
  }
}

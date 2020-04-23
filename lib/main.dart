import 'package:flutter/material.dart';
import 'package:kapdabazzarsellers/const.dart';
import 'package:kapdabazzarsellers/pages/about.dart';

import 'package:kapdabazzarsellers/pages/auth.dart';
import 'package:kapdabazzarsellers/pages/home.dart';

import 'package:kapdabazzarsellers/pages/supportpage.dart';

import './scoped-models/main.dart';
import 'package:scoped_model/scoped_model.dart';

void main() {
  // debugPaintSizeEnabled = true;

  runApp(
    MyApp(),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final MainModel _model = MainModel();

  @override
  void initState() {
    // _model.autoLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("Building main page");
    return ScopedModel<MainModel>(
      model: _model,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (BuildContext context) => AuthPage(),
          "/homepage": (BuildContext context) => HomePage(),
          '/support': (BuildContext context) => SupportPages(),
          '/about': (BuildContext context) => AboutPage(),
          // '/addproduct': (BuildContext context) => AddProduct()
        },
        onUnknownRoute: (RouteSettings settings) {
          return MaterialPageRoute(builder: (BuildContext context) {
            return HomePage();
          });
        },
        theme: ThemeData(
            scaffoldBackgroundColor: Color(0XFFEFF3F6),
            appBarTheme: AppBarTheme(
              color: Color(0XFFEFF3F6),
              iconTheme: IconThemeData(color: mycolor),
              elevation: 0,
            ),
            primaryColor: mycolor,
            // primaryIconTheme: IconThemeData(color: mycolor),
            iconTheme: IconThemeData(
              color: mycolor,
            )),
      ),
    );
  }
}

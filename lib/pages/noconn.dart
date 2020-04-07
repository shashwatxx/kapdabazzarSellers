import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NoConnectionPage extends StatefulWidget {
  @override
  _NoConnectionPageState createState() => _NoConnectionPageState();
}

class _NoConnectionPageState extends State<NoConnectionPage> {
  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Center(
      child: Stack(
        children: <Widget>[
          Container(
            height: height * 0.9,
            width: width * 0.9,
            child: FlareActor(
              'assets/no_network.flr',
              animation: 'idle',
              fit: BoxFit.contain,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              child: Column(
                children: <Widget>[
                  Container(
                    height: height * 0.7,
                  ),
                  // ScopedModelDescendant(builder:
                  //     (BuildContext context, Widget child, MainModel model) {
                  //   return FlatButton(
                  //     onPressed: () {},
                  //     child: Text("Retry"),
                  //   );
                  // }),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "No Connection\n Please Check your Internet connection",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

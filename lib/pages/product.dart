import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kapdabazzarsellers/const.dart';
import 'package:kapdabazzarsellers/models/product.dart';
import 'package:kapdabazzarsellers/mywidgets/drawer.dart';
import 'package:kapdabazzarsellers/scoped-models/main.dart';
import 'package:scoped_model/scoped_model.dart';
// import 'package:sellerkapda/models/product.dart';

class ProductPage extends StatefulWidget {
  final Product product;
  ProductPage({this.product});

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool isOn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        drawer: MyDrawer(),
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          // elevation: 1?0,
          title: Text(
            'SellerShopName',
            style: TextStyle(color: mycolor),
          ),
          leading: InkWell(
            onTap: () {
              if (_scaffoldKey.currentState.isDrawerOpen) {
                _scaffoldKey.currentState.openEndDrawer();
              } else {
                _scaffoldKey.currentState.openDrawer();
              }
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Image.asset(
                'assets/splash.png',
                fit: BoxFit.contain,
                // scale: 0.5,
              ),
            ),
          ),
        ),
        body: ScopedModelDescendant(
          builder: (BuildContext context, Widget child, MainModel model) {
            if (model.allproducts.length == 0) {
              return Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  FlareActor(
                    'assets/empty.flr',
                    animation: 'empty',
                  ),
                  Positioned(
                    top: 500,
                    right: 10,
                    left: 10,
                    bottom: 20,
                    child: Center(
                      child: Text(
                        "You have uploaded any product yet,\nPlease upload to view them here",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.abel(
                          fontSize: MediaQuery.of(context).size.width * 0.08,
                        ),
                      ),
                    ),
                  )
                ],
              );
            }
            return ListView.builder(
              itemCount: model.allproducts.length,
              itemBuilder: (BuildContext context, int index) => Text("TRyyyyy"),
            );
          },
        ));
  }
}

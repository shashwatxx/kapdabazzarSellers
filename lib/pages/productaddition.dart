import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:kapdabazzarsellers/const.dart';
import 'package:kapdabazzarsellers/mywidgets/drawer.dart';
import 'package:kapdabazzarsellers/mywidgets/softtextfield.dart';
import 'package:kapdabazzarsellers/scoped-models/main.dart';
import 'package:scoped_model/scoped_model.dart';

class ProductDaloPage extends StatefulWidget {
  @override
  _ProductDaloPageState createState() => _ProductDaloPageState();
}

class _ProductDaloPageState extends State<ProductDaloPage>
    with TickerProviderStateMixin {
  AnimationController _animationController;
  final List<String> _statusOption = ["Active", "Inactive"];
  bool isPlaying = false;
  // String selectedCategory;
  bool haveSameProduct = false;
  // String status;
  // String selectedSubCategory;
  Map<String, dynamic> _formData = {
    "categories": null,
    "subCategory": null,
    "status": null,
    "title": "",
    "description": "",
    "VarientCount": ""
  };
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget child, MainModel model) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Add New Product",
              style: TextStyle(color: mycolor),
            ),
          ),
          drawer: MyDrawer(
            model: model,
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    StreamBuilder<QuerySnapshot>(
                      stream: Firestore.instance
                          .collection('categories')
                          .snapshots(),
                      builder: (BuildContext context, snapshot) {
                        if (!snapshot.hasData) {
                          return Text("Loading....");
                        } else {
                          List<DropdownMenuItem> categoriesItems = [];
                          for (int i = 0;
                              i < snapshot.data.documents.length;
                              i++) {
                            DocumentSnapshot snap = snapshot.data.documents[i];
                            categoriesItems.add(
                              DropdownMenuItem(
                                child: Text(snap.documentID),
                                value: "${snap.documentID}",
                              ),
                            );
                          }
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 60),
                            child: DropdownButton(
                              underline: Container(
                                height: 2,
                                color: Theme.of(context).primaryColor,
                              ),
                              onTap: () {
                                setState(() {
                                  _formData['categories'] = null;
                                  _formData['subCategory'] = null;
                                });
                              },
                              hint: Text("Select Category"),
                              isExpanded: true,
                              autofocus: true,
                              items: categoriesItems,
                              onChanged: (categoryValue) {
                                final SnackBar snakbar = SnackBar(
                                  duration: Duration(milliseconds: 600),
                                  content: Text("You selected  $categoryValue"),
                                  action: SnackBarAction(
                                    label: "okay",
                                    onPressed: () {},
                                    textColor: mycolor,
                                  ),
                                );
                                Scaffold.of(context).showSnackBar(snakbar);
                                setState(() {
                                  _formData['categories'] = categoryValue;
                                  // selectedCategory = categoryValue;
                                });
                              },
                              value: _formData['categories'],
                            ),
                          );
                        }
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                    ///
                    ///
                    _formData['categories'] != null
                        ? StreamBuilder<DocumentSnapshot>(
                            stream: Firestore.instance
                                .collection('categories')
                                .document('${_formData['categories']}')
                                .snapshots(),
                            // .snapshots(),
                            builder: (BuildContext context, snapshot) {
                              if (!snapshot.hasData) {
                                return Text("Loading....");
                              } else {
                                List<DropdownMenuItem> subcategoriesItems = [];
                                // for (int i = 0;
                                //     i < snapshot.data.data.length;
                                //     i++) {
                                DocumentSnapshot snap = snapshot.data;

                                Map<String, dynamic> docValueMap = snap.data;
                                docValueMap.forEach((key, value) {
                                  subcategoriesItems.add(
                                    DropdownMenuItem(
                                      child: Text(value),
                                      value: value,
                                    ),
                                  );
                                });
                                // subcategoriesItems.add(
                                //   DropdownMenuItem(
                                //     child: Text(snap.documentID),
                                //     value: "${snap.documentID}",
                                //   ),
                                // );

                                // }
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 60),
                                  child: DropdownButton(
                                    underline: Container(
                                      height: 2,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    hint: Text("Select SubCategory"),
                                    isExpanded: true,
                                    // autofocus: true,
                                    items: subcategoriesItems,
                                    onChanged: (subcategoryValue) {
                                      final SnackBar snakbar = SnackBar(
                                        duration: Duration(milliseconds: 600),
                                        content: Text(
                                            "You selected  $subcategoryValue"),
                                        action: SnackBarAction(
                                          label: "okay",
                                          onPressed: () {},
                                          textColor: mycolor,
                                        ),
                                      );
                                      Scaffold.of(context)
                                          .showSnackBar(snakbar);
                                      setState(() {
                                        _formData['subCategory'] =
                                            subcategoryValue;
                                      });
                                    },
                                    value: _formData['subCategory'],
                                  ),
                                );
                              }
                            },
                          )
                        : Container(),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 60),
                      child: DropdownButton(
                          isExpanded: true,
                          hint: Text("Select Status"),
                          items: _statusOption
                              .map<DropdownMenuItem<String>>((String e) {
                            return DropdownMenuItem(
                              value: e,
                              child: Text(e),
                            );
                          }).toList(),
                          underline: Container(
                            height: 2,
                            color: Theme.of(context).primaryColor,
                          ),
                          value: _formData['status'],
                          onChanged: (value) {
                            setState(() {
                              _formData['status'] = value;
                            });
                            // e = value;
                          }),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    MyTextField(
                      icon: Icons.library_add,
                      title: "Product title",
                      hintText: "Enter the title of your Product",
                      onSaved: (value) {
                        _formData['title'] = value;
                      },
                      validator: (value) {
                        if (value.isEmpty) return "Product cannot be blank";
                      },
                    ),
                    MyTextField(
                      maxlines: 10,
                      icon: Icons.description,
                      title: "Product Description",
                      hintText: "Enter the description of your Product",
                      onSaved: (value) {
                        _formData['description'] = value;
                      },
                      validator: (value) {
                        if (value.isEmpty) return "This field cannot be blank";
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //   children: <Widget>[
                    //     Container(
                    //       child: TextFormField(
                    //         keyboardType: TextInputType.number,
                    //         decoration: InputDecoration(
                    //           labelText: "Retail Price",
                    //           border: OutlineInputBorder(),
                    //         ),
                    //         textAlign: TextAlign.center,
                    //       ),
                    //       width: width * 0.4,
                    //     ),
                    //     Container(
                    //       child: TextFormField(
                    //         keyboardType: TextInputType.number,
                    //         decoration: InputDecoration(
                    //           labelText: "Wholesale Price",
                    //           border: OutlineInputBorder(),
                    //         ),
                    //         textAlign: TextAlign.center,
                    //       ),
                    //       width: width * 0.4,
                    //     ),
                    //   ],
                    // ),
                    SizedBox(
                      height: 10,
                    ),
                    // MyTextField(
                    //   title: "Stock",
                    //   icon: Icons.storage,
                    //   hintText: "Enter the Stocks Available",
                    //   keyboardType: TextInputType.number,
                    //   initialValue: "1",
                    // ),
                    Container(
                      width: width * 0.90,
                      child: Row(
                        children: [
                          Checkbox(
                            activeColor: mycolor,
                            visualDensity:
                                VisualDensity.adaptivePlatformDensity,
                            materialTapTargetSize: MaterialTapTargetSize.padded,
                            value: haveSameProduct,
                            onChanged: (bool value) {
                              setState(() {
                                haveSameProduct = !haveSameProduct;
                              });
                            },
                          ),
                          Text(
                            "Do you have More product having same \n Description and Title but diffrent specification",
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    haveSameProduct
                        ? MyTextField(
                            title: "No. of Varients",
                            icon: Icons.category,
                            hintText: "Enter the number of varients you have",
                            keyboardType: TextInputType.number,
                            initialValue: "1",
                            onSaved: (value) {
                              _formData['VarientCount'] = value;
                            },
                          )
                        : Container(),
                    SizedBox(
                      height: 20,
                    ),
                    CupertinoButton(
                      child: Text("Next Step"),
                      color: mycolor,
                      onPressed: () {
                        // _formKey.currentState.validate();

                        if (_formKey.currentState.validate() == true) {
                          _formKey.currentState.save();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductAdditionSecondStep(),
                            ),
                          );
                        }
                      },
                    ),
                    SizedBox(
                      height: 40,
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class ProductAdditionSecondStep extends StatefulWidget {
  final String title;
  final String productId;
  ProductAdditionSecondStep({
    this.title,
    this.productId,
  });

  @override
  _ProductAdditionSecondStepState createState() =>
      _ProductAdditionSecondStepState();
}

class _ProductAdditionSecondStepState extends State<ProductAdditionSecondStep> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}

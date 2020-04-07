import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kapdabazzarsellers/mywidgets/softtextfield.dart';

import 'package:kapdabazzarsellers/scoped-models/main.dart';

import '../const.dart';

class RegisterPage extends StatefulWidget {
  final MainModel model;
  RegisterPage({this.model});
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    setState(() {
      firebaseStorage = widget.model.getStorageRefrence();
    });
    super.initState();
  }

  StorageReference firebaseStorage;
  //  StorageReference firebaseStorage;
  String _localFileUrl = null;

  String uploadedFileUrl = null;
  bool _showpassword = false;
  String name;

  Map<String, dynamic> _formData = {
    'sellerName': "",
    'shopName': "",
    'address': "",
    'phone': "",
    'email': "",
    'password': "",
    'accHolderName': "",
    'accNumber': "",
    'ifsc': "",
    "gstin": "",
    "sellerID": "",
    "reviewed": false
  };

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return widget.model.isLoading
        ? Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Scaffold(
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
                  child: Form(
                    key: _formKey,
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
                          onSaved: (String value) {
                            setState(() {
                              _formData['sellerName'] = value;
                              _formData['sellerID'] =
                                  widget.model.docId.documentID;
                            });
                          },
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
                          onSaved: (String value) {
                            setState(() {
                              _formData['shopName'] = value;
                            });
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 25),
                          child: Text("Phone Number"),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SoftUiTextField(
                          hintText: "Enter your Number here...",
                          keyboardType: TextInputType.phone,
                          onSaved: (String value) {
                            setState(() {
                              _formData['phone'] = value;
                            });
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 25),
                          child: Text("Address"),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SoftUiTextField(
                          hintText: "Enter your Address here...",
                          onSaved: (String value) {
                            setState(() {
                              _formData['address'] = value;
                            });
                          },
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
                          keyboardType: TextInputType.emailAddress,
                          onSaved: (String value) {
                            setState(() {
                              _formData['email'] = value;
                            });
                          },
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
                          onSaved: (String value) {
                            setState(() {
                              _formData['password'] = value;
                            });
                          },
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
                          height: 10,
                        ),
                        Divider(),
                        Align(
                          child: Text(
                            "Bank Account Info",
                            style: GoogleFonts.offside(fontSize: 20),
                          ),
                        ),
                        Divider(),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 25),
                          child: Text("Account Holder Name"),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SoftUiTextField(
                          hintText:
                              "Enter your Bank Account Holder Name here...",
                          onSaved: (String value) {
                            setState(() {
                              _formData['accHolderName'] = value;
                            });
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 25),
                          child: Text("Account Number"),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SoftUiTextField(
                          keyboardType: TextInputType.number,
                          hintText: "Enter your Bank Account Number here...",
                          onSaved: (String value) {
                            setState(() {
                              _formData['accNumber'] = value;
                            });
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 25),
                          child: Text("IFSC Code"),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SoftUiTextField(
                          hintText: "Enter your IFSC code",
                          onSaved: (String value) {
                            setState(() {
                              _formData['ifsc'] = value;
                            });
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 25),
                          child: Text("GSTIN Number(optional)"),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SoftUiTextField(
                          hintText: "Enter your GSTIN here..",
                          onSaved: (String value) {
                            setState(() {
                              _formData['gstin'] = value;
                            });
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 25),
                          child: Text("Upload GSTIN Document"),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: GestureDetector(
                              onTap: getfile,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 10),
                                color: mycolor,
                                child: _localFileUrl == null
                                    ? Text(
                                        widget.model.fileUploadingStatus,
                                        style: TextStyle(color: Colors.white),
                                      )
                                    : Text(
                                        _localFileUrl,
                                        style: TextStyle(color: Colors.white),
                                      ),
                              )),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Align(
                          child: CupertinoButton(
                              color: mycolor,
                              child: Text("Register"),
                              onPressed: _submitForm),
                        ),
                        SizedBox(
                          height: 40,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
  }

  _submitForm() async {
    if (_localFileUrl == null) {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text("No File Uploaded"),
          content: Text(
              "Please Upload File supporting your Sellers Credibility\n Ex-"),
          actions: <Widget>[
            FlatButton(
              child: Text("OK"),
              onPressed: () => Navigator.pop(context),
            )
          ],
        ),
      );
    }

    _formKey.currentState.validate();
    _formKey.currentState.save();
    widget.model.cretesellerinDB(_formData, context);

    print(_formData);
  }

  getfile() async {
    widget.model.file = await FilePicker.getFile();
    if (widget.model.file.path == null) {
      setState(() {
        _localFileUrl = null;
      });
    }
    setState(() {
      _localFileUrl = widget.model.file.path;

      final StorageUploadTask task = firebaseStorage.putFile(widget.model.file);
      if (task.isComplete) {
        firebaseStorage.getDownloadURL();
        widget.model.fileUploadingStatus = "Uploaded Succesfully";
        print("The Download url is " + uploadedFileUrl);
        _formData['uploadedFileUrl'] = uploadedFileUrl;
      }
    });
  }
}

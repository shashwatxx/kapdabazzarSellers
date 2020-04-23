import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kapdabazzarsellers/models/product.dart';
import 'package:kapdabazzarsellers/models/seller.dart';
import 'package:kapdabazzarsellers/models/order.dart';
import 'package:kapdabazzarsellers/pages/auth.dart';
import 'package:kapdabazzarsellers/pages/registerDone.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

mixin ConnectedProductsModel on Model {
  List<Product> _products = [];
  bool isConnected = false;
  List<String> catgories = ["Ethnic", "New", "Lehsun"];
  Seller _authenticatedSeller;
  bool isAuthenticated = false;
  Map<String, dynamic> currentSellerDetail = {
    'email': '',
  };
  String _selProductId;
  bool isLoading = false;
  DocumentReference docId;
  File file;
  // StorageReference firebaseStorage;
  String fileUploadingStatus = "Upload Here";

  String localFileUrl = null;
  Firestore firestoreReference = Firestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser user;
}

mixin ProductModel on ConnectedProductsModel {
  List<Product> get allproducts {
    return List.from(_products);
  }

  // List<Product> get displayedProdcuts {
  //   // if(){}
  // }
  cretesellerinDB(Map<String, dynamic> sellerData, BuildContext context) {
    isLoading = true;
    firestoreReference
        .collection('sellers')
        .document(docId.documentID)
        .setData(sellerData)
        .then((value) {
      isLoading = false;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => RegistrationDonePage(),
        ),
      );
    });
  }

  // getfile() async {
  //   file = await FilePicker.getFile();
  //   notifyListeners();
  //   if (file.path == null) {
  //     localFileUrl = null;
  //     // notifyListeners();s
  //     fileUploadingStatus = "No file Selected";
  //     notifyListeners();
  //     return "";
  //   }

  //   localFileUrl = file.path;
  //   notifyListeners();
  //   final StorageUploadTask task = firebaseStorage.putFile(file);
  //   if (task.isComplete) {
  //     String uploadedFileUrl = await firebaseStorage.getDownloadURL();
  //     fileUploadingStatus = "Uploaded Succesfully";
  //     notifyListeners();
  //     // print("The Download url is " + uploadedFileUrl);

  //   }
  // }

  Future<bool> addProduct(
      String id,
      String title,
      String category,
      String gid,
      String iid,
      String sellerId,
      String stock,
      List<String> availableSizes,
      String description,
      double price,
      List<String> imageUrls,
      String userId,
      String sku) async {
    isLoading = true;
    notifyListeners();

    try {
      DocumentReference productReference =
          firestoreReference.collection('products').document();
      if (productReference != null) {
        final Map<String, dynamic> productData = {
          'title': title,
          'category': category,
          'gid': gid,
          'iid': productReference.documentID,
          'sku': sku,
          'sellerId': sellerId,
          'stock': stock,
          'availableSizes': availableSizes,
          'description': description,
          'price': price,
          'imageUrls': imageUrls,
        };

        await productReference.setData(productData).then(
          (value) {
            isLoading = false;
            notifyListeners();
          },
        );
      }
    } catch (error) {
      isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> deleteProduct() {
    isLoading = true;
    final deletedProductId = selectedProduct.id;
    _products.removeAt(selectedProductIndex);
    _selProductId = null;
    notifyListeners();
    firestoreReference
        .collection('products')
        .document('$deletedProductId')
        .delete()
        .then((value) {
      isLoading = false;
      notifyListeners();
      return true;
    }).catchError((error) {
      isLoading = false;
      notifyListeners();
      return false;
    });
  }

  StorageReference getStorageRefrence() {
    docId = firestoreReference.collection('sellers').document();
    notifyListeners();
    final StorageReference firebaseStorage =
        FirebaseStorage.instance.ref().child('user_reg/${docId.documentID}');

    // return firestoreReference.collection('sellers').document().documentID;
    return firebaseStorage;
  }

  signinUser(String email, String password, BuildContext context) async {
    isLoading = true;
    notifyListeners();
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('email', '$email');
      await prefs.setString('password', '$password');

      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .catchError((error) {
        showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: Text(
              "error",
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Try Again"),
              )
            ],
          ),
        );
      }).then((value) async {
        isLoading = false;
        notifyListeners();
        user = value.user;
        print(user.email.toString());
        notifyListeners();

        if (value.user.email == email) {
          print(value.user.email + "Is athenticated ke peh;e w;a hua");
          isAuthenticated = true;
          saveCurrentUserDetails();
          notifyListeners();
          Navigator.pushReplacementNamed(context, '/');
        }
      });
      notifyListeners();
    } on PlatformException {
      isLoading = true;
      notifyListeners();
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text(
            "error",
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Try Again"),
            )
          ],
        ),
      );
    }
  }

  void signOut(BuildContext context) async {
    try {
      isAuthenticated = false;
      notifyListeners();
      SharedPreferences pref = await SharedPreferences.getInstance();

      await pref.remove('email');
      await pref.remove('password');
      await pref.clear();
      await _auth.signOut().then((value) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) => AuthPage()));
      });
    } catch (e) {
      print('Error signin out: $e');
      // return e;
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("$e"),
          );
        },
      );
    }
  }

  void autoLogin() async {
    // print(
    //   "Lavda mera" + _auth.currentUser()
    // );
    FirebaseUser tryh = await _auth.currentUser();
    // print("${tryh.email}+Yaha email id dikhega");

    if (tryh != null) {
      isAuthenticated = true;
      print("${tryh.email}+Yaha email id dikhega");
      notifyListeners();
    } else {
      isAuthenticated = false;
      notifyListeners();
    }

    // if (tryh.email == null) {
    //   // print(
    //   //   "Lavda mera part 2" + _auth.currentUser().toString(),
    //   // );
    //   SharedPreferences prefs = await SharedPreferences.getInstance();
    //   String email = prefs.getString('email');
    //   String pass = prefs.getString('password');
    //   print(email);
    //   print(pass);
    //   _auth
    //       .signInWithEmailAndPassword(email: email, password: pass)
    //       .then((AuthResult value) {
    //     if (value.user.email == email) {
    //       isAuthenticated = true;
    //       notifyListeners();
    //     } else {
    //       isAuthenticated = false;
    //       notifyListeners();
    //     }
    //   });
    // }
  }

  saveCurrentUserDetails() async {
    if (user == null) return null;
    firestoreReference
        .collection('sellers')
        .where('email', isEqualTo: '${user.email}')
        .snapshots()
        .listen(
          (event) => event.documents.forEach(
            (element) async {
              // print(element['email']);
              // print(element['sellerName']);
              // SharedPreferences prefs = await SharedPreferences.getInstance();
              // SharedPreferences prefs = await SharedPreferences.getInstance()
              // await prefs.setString('sellerName', element['sellerName']);
              // await prefs.setString('email', element['email']);
              // await prefs.setString('sellerId', element['sellerId']);
              // await prefs.setString('reviewed', element['reviewed']);
              // await prefs.setString('phone', element['phone']);
              // await prefs.setString('shopName', element['shopName']);
              // await prefs.setString('password', element['password']);
              // prefs.setStringList('key', value)
              currentSellerDetail = element.data;
              // currentSellerDetail['email'] = element['email'];
              // currentSellerDetail['sellerName'] = element['sellerName'];
              // currentSellerDetail['sellerId'] = element['sellerId'];
              // currentSellerDetail['reviewed'] = element['reviewed'];
              // currentSellerDetail['phone'] = element['phone'].;
              // currentSellerDetail['shopName'] = element['shopName'];
              // currentSellerDetail['password'] = element['password'];
              notifyListeners();
            },
          ),
        );
    // print(SellerData);
    notifyListeners();
  }

  fetchCategories() async {
    QuerySnapshot snapshots =
        await firestoreReference.collection('categories').getDocuments();
    // catgories = snapshots.documents;
    // print(catgories.length);
    notifyListeners();
  }

  // addCategories(String category) async {
  //   firestoreReference
  //       .collection('categories')
  //       .document('$category')
  //       .setData({"Clothing": "Clothing"});
  // }

  void placeOrder() {
    firestoreReference.collection('orders').add(order);
  }

  String get selectedProductId {
    return _selProductId;
  }

  int get selectedProductIndex {
    final int inIndex = _products.indexWhere((Product product) {
      return product.id == _selProductId;
    });

    if (inIndex == -1)
      return null;
    else
      return inIndex;
  }

  Product get selectedProduct {
    if (selectedProductIndex == null) {
      return null;
    }
    return _products.firstWhere(
      (Product product) {
        return product.id == _selProductId;
      },
    );
  }
}
mixin UserModel on ConnectedProductsModel {}

mixin UtilityModel on ConnectedProductsModel {
  String genrateSKU(String productName, String price, String documentID) {
    String sku = productName.substring(0, 4) +
        price.substring(0, 2) +
        documentID.substring(0, 4);
    return sku;
  }

  checkNetwork() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      // print("NEtwork checkup --" + result.toString());

      isConnected = true;
      notifyListeners();
    } on SocketException catch (_) {
      isConnected = false;
      print("No connection");
      notifyListeners();
    }
  }
}

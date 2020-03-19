import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kapdabazzarsellers/models/product.dart';
import 'package:kapdabazzarsellers/models/user.dart';
import 'package:kapdabazzarsellers/models/order.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;

mixin ConnectedProductsModel on Model {
  List<Product> _products = [];
  Seller _authenticatedSeller;
  String currentSellerName = '';
  String _selProductId;
  bool _isLoading = false;
  Firestore firestoreReference = Firestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser user;
}

mixin ProductModel on ConnectedProductsModel {
  List<Product> get allproducts {
    return List.from(_products);
  }

  List<Product> get displayedProdcuts {
    // if(){}
  }

  void registerSeller() {}

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
    _isLoading = true;
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
            _isLoading = false;
            notifyListeners();
          },
        );
      }
    } catch (error) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> deleteProduct() {
    _isLoading = true;
    final deletedProductId = selectedProduct.id;
    _products.removeAt(selectedProductIndex);
    _selProductId = null;
    notifyListeners();
    firestoreReference
        .collection('products')
        .document('$deletedProductId')
        .delete()
        .then((value) {
      _isLoading = false;
      notifyListeners();
      return true;
    }).catchError((error) {
      _isLoading = false;
      notifyListeners();
      return false;
    });
  }

  signinUser() async {
    await _auth
        .signInWithEmailAndPassword(
            email: 'test@test.com', password: 'password')
        .then((value) async {
      user = await _auth.currentUser();
      print(user);
      notifyListeners();
    });
    notifyListeners();
  }

  getCurrentUser() async {
    if (user == null) return null;
    firestoreReference
        .collection('sellers')
        .where('email', isEqualTo: '${user.email}')
        .snapshots()
        .listen(
          (event) => event.documents.forEach(
            (element) {
              currentSellerName = element["name"];
              print(element["name"]);
            },
          ),
        );
    // print(SellerData);
    notifyListeners();
  }

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
}

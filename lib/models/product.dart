import 'package:flutter/material.dart';

class Product {
  final String id;
  final String title;
  final String category;
  final String gid;
  final String iid;
  final String sellerId;
  final String stock;
  final List<String> availableSizes;
  final String description;
  final double price;
  final List<String> imageUrls;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrls,
    @required this.availableSizes,
    @required this.category,
    @required this.gid,
    @required this.iid,
    @required this.sellerId,
    @required this.stock,
  });
}

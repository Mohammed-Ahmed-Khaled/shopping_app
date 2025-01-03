import 'package:flutter/material.dart';

class ProductModel {
  final String image;
  final String title;
  final String price;
  final Icon icon = const Icon(Icons.add_shopping_cart);

  ProductModel({
    required this.image,
    required this.title,
    required this.price,
  });
}

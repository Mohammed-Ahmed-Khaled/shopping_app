import 'package:flutter/material.dart';

class OfferModel {
  final String image;
  final String title;
  final String priceAfterDiscount;
  final Icon icon = const Icon(Icons.add_shopping_cart);

  OfferModel({
    required this.image,
    required this.title,
    required this.priceAfterDiscount,
  });
}

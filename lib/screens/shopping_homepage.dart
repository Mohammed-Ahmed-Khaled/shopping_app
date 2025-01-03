import 'package:flutter/material.dart';
import 'package:shopping_app/widgets/text_widget.dart';
import 'package:shopping_app/widgets/product_page_view.dart';
import 'package:shopping_app/widgets/product_grid_view.dart';
import 'package:shopping_app/widgets/offer_list_view.dart';

class ShoppingHomePage extends StatefulWidget {
  const ShoppingHomePage({super.key});

  @override
  State<ShoppingHomePage> createState() => ShoppingHomePageState();
}

class ShoppingHomePageState extends State<ShoppingHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TextWidget(text: 'Shopping App'),
        centerTitle: true,
      ),
      body: const SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextWidget(text: 'Our Products'),
            SizedBox(height: 10),
            ProductPageView(),
            SizedBox(height: 10),
            ProductGridView(),
            SizedBox(height: 10),
            TextWidget(text: 'Hot Offers'),
            SizedBox(height: 10),
            OfferListView(),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shopping_app/widgets/text_widget.dart';
import 'package:shopping_app/widgets/product_page_view.dart';
import 'package:shopping_app/widgets/product_grid_view.dart';
import 'package:shopping_app/widgets/offer_list_view.dart';
import 'package:shopping_app/generated/l10n.dart';

class ShoppingHomePage extends StatefulWidget {
  final VoidCallback togglelanguage;

  const ShoppingHomePage({super.key, required this.togglelanguage});

  @override
  State<ShoppingHomePage> createState() => ShoppingHomePageState();
}

class ShoppingHomePageState extends State<ShoppingHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextWidget(
          text: S.of(context).appTitle,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.language),
            onPressed: widget.togglelanguage, // Toggle between languages
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextWidget(text: S.of(context).ourProducts),
            SizedBox(height: 10),
            ProductPageView(),
            SizedBox(height: 10),
            ProductGridView(),
            SizedBox(height: 10),
            TextWidget(text: S.of(context).hotOffers),
            SizedBox(height: 10),
            OfferListView(),
          ],
        ),
      ),
    );
  }
}

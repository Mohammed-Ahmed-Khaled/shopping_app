import 'package:flutter/material.dart';
import 'package:shopping_app/data/data.dart';
import 'package:shopping_app/widgets/product_card.dart';

class ProductGridView extends StatelessWidget {
  const ProductGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.5,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.9,
        ),
        itemCount: products.length,
        itemBuilder: (ctx, index) {
          var product = products[index];
          return Padding(
            padding: const EdgeInsets.all(5.0),
            child: ProductCard(
              product: product,
            ),
          );
        },
      ),
    );
  }
}
